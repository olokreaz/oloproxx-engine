# compiler options
if ( ${WIN32} )
	#compiler options
	add_compile_options(
		/utf-8
		/MP
		/EHsc
		/GS
		/GF
		/GR
		/GA
		/wd4996
		/arch:AVX
		/openmp
		/FS
		)
	
	set( CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>" )
	
	#linker options
	add_link_options(
		/SUBSYSTEM:CONSOLE
		)
	
	if ( ${CMAKE_BUILD_TYPE} STREQUAL "Debug" )
		link_directories( $ENV{VCPKG_ROOT}/installed/x64-windows/debug/lib )
		link_directories( $ENV{VCPKG_ROOT}/installed/x64-windows/debug/bin )
	else ()
		link_directories( $ENV{VCPKG_ROOT}/installed/x64-windows/lib )
		link_directories( $ENV{VCPKG_ROOT}/installed/x64-windows/bin )
	endif ()
	
	
	#definition
	add_compile_definitions( OWINDOWS
	                         WIN32
	                         _WIN32
	                         _CONSOLE
	                         )


elseif ( ${LINUX} )
	#compiler options
	add_compile_options( -finput-charset=UTF-8
	                     -fexceptions
	                     -fstack-protector
	                     -frtti
	                     -fexceptions
	                     -Wno-deprecated-declarations
	                     -mavx
	                     -fopenmp )
	
	#linker options
	
	if ( ${CMAKE_BUILD_TYPE} STREQUAL "Debug" )
		link_directories( $ENV{VCPKG_ROOT}/installed/x64-linux/debug/lib )
	else ()
		link_directories( $ENV{VCPKG_ROOT}/installed/x64-linux/lib )
	endif ()
	
	
	#defenitions
	add_compile_definitions( OLINUX
	                         LINUX
	                         _LINUX
	                         _CONSOLE
	                         )
endif ()


add_compile_definitions(
	UNICODE
	_UNICODE
	NOMINMAX
	GLM_FORCE_SWIZZLE # enable swizzle operators v.xyz
	NTKERNEL_ERROR_CATEGORY_INLINE=0
	LLFIO_EXPERIMENTAL_STATUS_CODE=1
	#[[ usefully defines ]]
	NODISCARD=[[nodiscard]]
	)
# platform defines
if ( ${CMAKE_BUILD_TYPE} STREQUAL "Debug" )
	add_compile_definitions(
		_DEBUG
		DEBUG
		DEV
		)
	message( "Debug build" )
else ()
	add_compile_definitions( NDEBUG
	                         RELEASE
	                         )
	message( "Release build" )
endif ()

if ( ${DEV} )
	add_compile_definitions( DEV )
else ()
	add_compile_definitions( NDEV PROD )
endif ()
