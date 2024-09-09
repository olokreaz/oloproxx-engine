cmake_minimum_required( VERSION 3.22 )
project( oloproxx-engine C CXX )

find_package( CMakeRC CONFIG REQUIRED )

find_package( glm CONFIG REQUIRED )
find_package( fmt CONFIG REQUIRED )
find_package( cpr CONFIG REQUIRED )
find_package( ctre CONFIG REQUIRED )
find_package( nlohmann_json CONFIG REQUIRED )
find_package( scn CONFIG REQUIRED )
find_package( stduuid CONFIG REQUIRED )
find_package( FunctionalPlus CONFIG REQUIRED )
find_package( ipaddress CONFIG REQUIRED )

find_package( alpaca CONFIG REQUIRED )
find_package( libassert CONFIG REQUIRED )
find_package( sigc++-3 CONFIG REQUIRED )
find_package( leveldb CONFIG REQUIRED )

find_package( frozen CONFIG REQUIRED )

find_package( FFMPEG REQUIRED )
include_directories( PRIVATE ${FFMPEG_INCLUDE_DIRS} )
link_directories( ${FFMPEG_LIBRARY_DIRS} )

find_package( spdlog CONFIG REQUIRED )


find_package( Vulkan REQUIRED )
find_package( glfw3 REQUIRED )
find_package( unofficial-gainput CONFIG REQUIRED )


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

set( UL_SDK_PATH $ENV{UL_SDK} )

set( STEAM_SDK_PATH $ENV{STEAM_SDK} )
set( STEAM_AUDIO_SDK_PATH $ENV{STEAM_AUDIO} )

set( FMOD_SDK_PATH $ENV{FMOD_SDK} )

set( STEAMWORKS_SDK ${STEAM_SDK_PATH} )


message( STATUS "UltraLight: ${UL_SDK_PATH}" )
message( STATUS "Steam: ${STEAM_SDK_PATH}" )
message( STATUS "Steam Audio: ${STEAM_AUDIO_SDK_PATH}" )
message( STATUS "FMOD: ${FMOD_SDK_PATH}" )


include( cth-config )

add_compile_definitions()


add_library( engine SHARED
             ${SHARED_SRC}
             ${BASE_SRC}
             ${NETWORK_SRC}
             ${GRAPHICS_SRC}
             ${PHYSICS_SRC}
             )

set_target_properties( engine
                       PROPERTIES
                       OUTPUT_DIR ${CMAKE_BINARY_DIR}/bin/$<CONFIG>
                       OUTPUT_NAME "engine"
                       VS_COPY_TO_OUT_DIR ON
                       MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL"
                       RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/$<CONFIG>
                       )


target_compile_definitions( engine
                            PRIVATE "API=__declspec(dllexport)"
                            INTERFACE "API=__declspec(dllimport)"
                            # utils
                            PUBLIC NOMINMAX
                            )

add_target_config( TARGET engine
                   CONFIG ${CMAKE_CURRENT_SOURCE_DIR}/oloproxx-engine.json
                   OUTPUT conf/engine.hpp
                   )

target_link_directories( engine
                         # Steamworks SDK
                         PUBLIC ${STEAMWORKS_SDK}/redistributable_bin/win64 # Steamworks SDK bin/lib directory
                         # Stream Audio SDK
                         PUBLIC ${STEAM_AUDIO_SDK_PATH}/fmod/steamaudio/lib/windows-x64 ${STEAM_AUDIO_SDK_PATH}/fmod/steamaudio/symbols/windows-x64
                         # UltraLight SDK
                         PUBLIC ${UL_SDK_PATH}/lib ${UL_SDK_PATH}/bin # Ultralight SDK lib directory
                         # FMOD SDK
                         PUBLIC ${FMOD_SDK_PATH}/api/core/lib/x64   # core
                         PUBLIC ${FMOD_SDK_PATH}/api/fsbank/lib/x64 # fsbank
                         PUBLIC ${FMOD_SDK_PATH}/api/studio/lib/x64 # studio
                         
                         #[[ Source/Interface ]]
                         PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include/oloproxx-engine/
                         PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include/
                         
                         
                         )

target_include_directories( engine
                            # Steamworks SDK
                            PUBLIC ${STEAMWORKS_SDK}/public
                            # Stream Audio SDK
                            PUBLIC ${STEAM_AUDIO_SDK_PATH}/fmod/steamaudio/include
                            # UltraLight SDK
                            PUBLIC ${UL_SDK_PATH}/include
                            # FMOD SDK
                            PUBLIC ${FMOD_SDK_PATH}/api/core/inc
                            PUBLIC ${FMOD_SDK_PATH}/api/fsbank/inc
                            PUBLIC ${FMOD_SDK_PATH}/api/studio/inc
                            )


target_link_libraries( engine
                       # SDKs
                       PUBLIC steam_api64 # SteanWorks
                       PUBLIC phonon TrueAudioNext GPUUtilities # Steam Audio
                       # FMOD
                       PUBLIC fmod fmod_vc # core
                       PUBLIC fmodstudio fmodstudio_vc # studio
                       PUBLIC fsbank fsbank_vc #
                       # UltraLight
                       PUBLIC Ultralight UltralightCore WebCore AppCore
                       # Third Party
                       PUBLIC
                       fmt::fmt-header-only
                       glm::glm
                       cpr::cpr
                       ctre::ctre
                       
                       )


add_library( oloproxx::engine ALIAS engine )


######################################
################ TEST ################
######################################

#if ( BUILD_TESTING )
enable_testing()

find_package( GTest CONFIG REQUIRED )

file( GLOB_RECURSE TEST_ENGINE_COMMON ${CMAKE_CURRENT_SOURCE_DIR}/test/common/*.cpp )
add_executable( test-engine-common ${TEST_ENGINE_COMMON} ${SHARED_SRC} )
target_link_libraries( test-engine-common PRIVATE
                       GTest::gtest GTest::gtest_main
                       GTest::gmock GTest::gmock_main
                       )
target_sources( test-engine-common PRIVATE )
target_include_directories( test-engine-common PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include/ )

# add_test( CommonEngineTest test-engine-common )

if ( BUILD_CLIENT AND NO )
	file( GLOB_RECURSE TEST_ENGINE_CLIENT ${CMAKE_CURRENT_SOURCE_DIR}/test/client/*.cpp )
	add_executable( test-engine-client ${TEST_ENGINE_CLIENT} )
	target_link_libraries( test-engine-client PRIVATE
	                       GTest::gtest GTest::gtest_main
	                       GTest::gmock GTest::gmock_main
	                       oloproxx::engine::client
	                       )
	add_test( ClientEngineTest test-engine-client )
endif ()

if ( BUILD_SERVER AND NO )
	file( GLOB_RECURSE TEST_ENGINE_SERVER ${CMAKE_CURRENT_SOURCE_DIR}/test/server/*.cpp )
	add_executable( test-engine-server ${TEST_ENGINE_SERVER} )
	target_link_libraries( test-engine-server PRIVATE
	                       GTest::gtest GTest::gtest_main
	                       GTest::gmock GTest::gmock_main
	                       oloproxx::engine::server
	                       )
	add_test( ServerEngineTest test-engine-server )
endif ()


#endif ()

