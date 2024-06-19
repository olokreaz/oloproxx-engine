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