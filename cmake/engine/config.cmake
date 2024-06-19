###############################################################
######################## GLOBAL CONFIG ########################
###############################################################

if ( CMAKE_BUILD_TYPE STREQUAL "Debug" )
	set( DEBUG ON )
	set( DBG ON PARENT_SCOPE )
else ()
	set( DEBUG OFF )
	set( DBG OFF PARENT_SCOPE )
endif ()


set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake" PARENT_SCOPE )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake" )

set( ENGINE_VERSION 0.1.0 PARENT_SCOPE )
set( ENGINE_NAME "oloproxx-engine" PARENT_SCOPE )

set( config-engine-client-name oloproxx-engine-client )
set( config-engine-server-name oloproxx-engine-server )


if ( ${WIN32} )
	set( PLATFORM "windows" )
	
	set( BUILD_CLIENT ON )
	set( BUILD_SERVER ON )
	
	set( ENGINE_PLATFORM "windows" PARENT_SCOPE CACHE STRING "Platform" FORCE )
	set( ENGINE_TARGET_CLIENT ON PARENT_SCOPE CACHE STRING "Build the client" FORCE )
	set( ENGINE_TARGET_SERVER ON PARENT_SCOPE CACHE STRING "Build the server" FORCE )

else ()
	set( PLATFORM "linux" )
	
	set( BUILD_CLIENT OFF )
	set( BUILD_SERVER ON )
	
	set( ENGINE_PLATFORM "linux" PARENT_SCOPE CACHE STRING "Platform" FORCE )
	set( ENGINE_TARGET_CLIENT OFF PARENT_SCOPE CACHE STRING "Build the client" FORCE )
	set( ENGINE_TARGET_SERVER ON PARENT_SCOPE CACHE STRING "Build the server" FORCE )
endif ()

