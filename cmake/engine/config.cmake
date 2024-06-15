###############################################################
######################## GLOBAL CONFIG ########################
###############################################################

if ( CMAKE_BUILD_TYPE STREQUAL "Debug" )
	set( DEBUG ON )
else ()
	set( DEBUG OFF )
endif ()


set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake" PARENT_SCOPE )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake" )

set( ENGINE_VERSION 0.1.0 PARENT_SCOPE )
set( ENGINE_NAME "oloproxx-engine" PARENT_SCOPE )


if ( ${WIN32} )
	set( PLATFORM "windows" )
	set( ENGINE_PLATFORM "windows" PARENT_SCOPE CACHE STRING "Platform" FORCE )
	
	
	set( BUILD_TARGET_CLIENT ON )
	set( BUILD_TARGET_SERVER ON )
	
	set( ENGINE_BUILD_TARGET_CLIENT ON PARENT_SCOPE CACHE STRING "Build the client" FORCE )
	set( ENGINE_BUILD_TARGET_SERVER ON PARENT_SCOPE CACHE STRING "Build the server" FORCE )

else ()
	set( PLATFORM "linux" )
	
	set( BUILD_TARGET_CLIENT OFF )
	set( BUILD_TARGET_SERVER ON )
	
	set( ENGINE_PLATFORM "linux" PARENT_SCOPE CACHE STRING "Platform" FORCE )
	set( ENGINE_BUILD_TARGET_CLIENT OFF PARENT_SCOPE CACHE STRING "Build the client" FORCE )
	set( ENGINE_BUILD_TARGET_SERVER ON PARENT_SCOPE CACHE STRING "Build the server" FORCE )
endif ()

