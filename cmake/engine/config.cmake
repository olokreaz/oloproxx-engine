###############################################################
######################## GLOBAL CONFIG ########################
###############################################################

if ( CMAKE_BUILD_TYPE STREQUAL "Debug" )
	set( DEBUG ON CACHE BOOL "Debug" FORCE )
	set( DBG ON CACHE BOOL "Debug" FORCE )
else ()
	set( DEBUG OFF CACHE BOOL "Debug" FORCE )
	set( DBG OFF CACHE BOOL "Debug" FORCE )
endif ()


set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake" CACHE STRING "CMake module path" FORCE )

