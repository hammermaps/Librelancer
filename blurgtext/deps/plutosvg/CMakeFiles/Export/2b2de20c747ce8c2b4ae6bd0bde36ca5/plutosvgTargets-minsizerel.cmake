#----------------------------------------------------------------
# Generated CMake target import file for configuration "MinSizeRel".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "plutosvg::plutosvg" for configuration "MinSizeRel"
set_property(TARGET plutosvg::plutosvg APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(plutosvg::plutosvg PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "C"
  IMPORTED_LOCATION_MINSIZEREL "${_IMPORT_PREFIX}/lib/libplutosvg.a"
  )

list(APPEND _cmake_import_check_targets plutosvg::plutosvg )
list(APPEND _cmake_import_check_files_for_plutosvg::plutosvg "${_IMPORT_PREFIX}/lib/libplutosvg.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
