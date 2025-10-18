pipeline {
    agent none
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
        timeout(time: 2, unit: 'HOURS')
    }
    
    stages {
        stage('Build and Test') {
            parallel {
                stage('Linux Build') {
                    agent {
                        label 'linux'
                    }
                    
                    environment {
                        DOTNET_CLI_TELEMETRY_OPTOUT = '1'
                        DOTNET_SKIP_FIRST_TIME_EXPERIENCE = '1'
                        OPENSSL_ENABLE_SHA1_SIGNATURES = '1'
                    }
                    
                    steps {
                        echo 'Starting Linux Build...'
                        
                        // Checkout with submodules
                        checkout([
                            $class: 'GitSCM',
                            branches: scm.branches,
                            doGenerateSubmoduleConfigurations: false,
                            extensions: [
                                [$class: 'SubmoduleOption',
                                 disableSubmodules: false,
                                 parentCredentials: true,
                                 recursiveSubmodules: true,
                                 reference: '',
                                 trackingSubmodules: false]
                            ],
                            submoduleCfg: [],
                            userRemoteConfigs: scm.userRemoteConfigs
                        ])
                        
                        // Install dependencies
                        sh '''
                            echo "Installing dependencies..."
                            sudo apt-get update
                            sudo apt-get install -y libgtk-3-dev cmake libopenal-dev libsdl2-dev gcc g++
                        '''
                        
                        // Build and test
                        sh '''
                            echo "Running build and tests..."
                            chmod +x build.sh
                            ./build.sh -j$(nproc) BuildAndTest
                        '''
                    }
                    
                    post {
                        success {
                            echo 'Linux build completed successfully'
                            archiveArtifacts artifacts: 'bin/**/*', fingerprint: true, allowEmptyArchive: true
                        }
                        failure {
                            echo 'Linux build failed'
                        }
                        always {
                            // Clean up workspace
                            cleanWs()
                        }
                    }
                }
                
                stage('Windows Build') {
                    agent {
                        label 'windows'
                    }
                    
                    environment {
                        DOTNET_CLI_TELEMETRY_OPTOUT = '1'
                        DOTNET_SKIP_FIRST_TIME_EXPERIENCE = '1'
                    }
                    
                    steps {
                        echo 'Starting Windows Build...'
                        
                        // Checkout with submodules
                        checkout([
                            $class: 'GitSCM',
                            branches: scm.branches,
                            doGenerateSubmoduleConfigurations: false,
                            extensions: [
                                [$class: 'SubmoduleOption',
                                 disableSubmodules: false,
                                 parentCredentials: true,
                                 recursiveSubmodules: true,
                                 reference: '',
                                 trackingSubmodules: false]
                            ],
                            submoduleCfg: [],
                            userRemoteConfigs: scm.userRemoteConfigs
                        ])
                        
                        // Build and test
                        powershell '''
                            Write-Host "Running build and tests..."
                            .\\build.ps1 BuildAndTest
                        '''
                    }
                    
                    post {
                        success {
                            echo 'Windows build completed successfully'
                            archiveArtifacts artifacts: 'bin/**/*', fingerprint: true, allowEmptyArchive: true
                        }
                        failure {
                            echo 'Windows build failed'
                        }
                        always {
                            // Clean up workspace
                            cleanWs()
                        }
                    }
                }
            }
        }
        
        stage('Package Daily Builds') {
            when {
                branch 'main'
            }
            
            agent {
                label 'linux'
            }
            
            environment {
                DOTNET_CLI_TELEMETRY_OPTOUT = '1'
                DOTNET_SKIP_FIRST_TIME_EXPERIENCE = '1'
                OPENSSL_ENABLE_SHA1_SIGNATURES = '1'
            }
            
            steps {
                echo 'Creating daily build packages...'
                
                // Checkout with submodules
                checkout([
                    $class: 'GitSCM',
                    branches: scm.branches,
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [
                        [$class: 'SubmoduleOption',
                         disableSubmodules: false,
                         parentCredentials: true,
                         recursiveSubmodules: true,
                         reference: '',
                         trackingSubmodules: false]
                    ],
                    submoduleCfg: [],
                    userRemoteConfigs: scm.userRemoteConfigs
                ])
                
                // Install dependencies including mingw for cross-compilation
                sh '''
                    echo "Installing dependencies..."
                    sudo apt-get update
                    sudo apt-get install -y libgtk-3-dev cmake libopenal-dev libsdl2-dev gcc g++ g++-mingw-w64-x86-64
                '''
                
                // Build Linux and Windows packages
                sh '''
                    echo "Building daily packages..."
                    chmod +x build.sh
                    ./build.sh -j$(nproc) LinuxDaily --with-win64
                '''
            }
            
            post {
                success {
                    echo 'Packaging completed successfully'
                    archiveArtifacts artifacts: 'packaging/packages/*', fingerprint: true
                }
                failure {
                    echo 'Packaging failed'
                }
                always {
                    cleanWs()
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
