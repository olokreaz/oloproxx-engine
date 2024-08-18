cmake_minimum_required( VERSION 3.22 )
project( oloproxx-engine )

enable_language( CXX )
set( CMAKE_CXX_STANDARD 23 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_EXPORT_COMPILE_COMMANDS ON )

message( STATUS "************* ${PROJECT_NAME} *************" )

include( cmake/engine/config.cmake )


message( STATUS "vcpkg-root -> $ENV{VCPKG_ROOT}" )
message( STATUS "vcpkg-triplet -> $ENV{VCPKG_DEFAULT_TRIPLET}" )
message( STATUS "Build Platform: ${PLATFORM}" )

include( cmake/common.cmake )

include( cmake/engine/package.cmake )
include( cmake/engine/source.cmake )

include( cmake/configurator.cmake )

message( STATUS "CHECKSUM: ${CHECKSUM}" )

message( STATUS "SHARED_FILES: ${SHARED_SRC}" )

if ( BUILD_CLIENT )
	add_library( engine-client SHARED ${SHARED_SRC} )
	target_version( engine-client ENGINE_CLIENT 1 0 0 )
	set_target_properties( engine-client PROPERTIES OUTPUT_NAME $<LOWER_CASE:${ENGINE_CLIENT_NAME}> )
endif ()

if ( BUILD_SERVER )
	add_library( engine-server SHARED ${SHARED_SRC} )
	target_version( engine-server ENGINE_SERVER 1 0 0 )
	target_force_include( engine-server ${CMAKE_CURRENT_SOURCE_DIR}/include/oloproxx-engine/base/config.hpp )
	set_target_properties( engine-server PROPERTIES OUTPUT_NAME $<LOWER_CASE:${ENGINE_SERVER_NAME}> )
endif ()

# all targets
get_property( targets DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY BUILDSYSTEM_TARGETS )
foreach ( target ${targets} )
	get_target_property( target_type ${target} TYPE )
	if ( target_type STREQUAL "EXECUTABLE" OR target_type STREQUAL "SHARED_LIBRARY" )
		message( STATUS "Target: ${target} -> ${target_type} " )
		set_target_properties( ${target} PROPERTIES
		                       MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>"
		                       )
		
		target_compile_definitions( ${target}
		                            PRIVATE "API=__declspec(export)"
		                            INTERFACE "API=__declspec(import)"
		                            )
		
		if ( target_type STREQUAL "SHARED_LIBRARY" )
			target_include_directories( engine-server
			                            PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include/oloproxx-engine/
			                            PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include/
			                            )
		endif ()
		
		if ( target_type STREQUAL "EXECUTABLE" )
		
		endif ()
	endif ()


endforeach ()

if ( BUILD_CLIENT )
	add_library( oloproxx::engine::client ALIAS engine-client )
endif ()


if ( BUILD_SERVER )
	add_library( oloproxx::engine::server ALIAS engine-server )
endif ()
