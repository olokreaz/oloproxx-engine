#[[
Package Engines
]]

find_package( CMakeRC CONFIG REQUIRED )
#[[ common ]]
find_package( glm CONFIG REQUIRED )
find_package( fmt CONFIG REQUIRED )
find_package( cpr CONFIG REQUIRED )
find_package( ctre CONFIG REQUIRED )
find_package( nlohmann_json CONFIG REQUIRED )
find_package( scn CONFIG REQUIRED )
find_package( stduuid CONFIG REQUIRED )
find_package( FunctionalPlus CONFIG REQUIRED )
find_package( ipaddress CONFIG REQUIRED )


#[[ engine ]]
#find_package( protobuf CONFIG REQUIRED )
find_package( alpaca CONFIG REQUIRED )
find_package( libassert CONFIG REQUIRED )
find_package( sigc++-3 CONFIG REQUIRED )
find_package( leveldb CONFIG REQUIRED )


if ( ${WIN32} )
	#[[ engine::client ]]
	find_package( Vulkan REQUIRED )
	find_package( glfw3 REQUIRED )
	find_package( unofficial-gainput CONFIG REQUIRED )
	#[[ game::client ]]

endif ()

#[[ engine::server ]]

#[[ game::server ]]

if ( ${WIN32} )
	set( STEAM_LIBS steam_api64 )
elseif ( ${LINUX} )
	set( STEAM_LIBS libsteam_api )
endif ()

set( LIBS
     nlohmann_json::nlohmann_json
     FunctionalPlus::fplus
     fmt::fmt
     glm::glm
     cpr::cpr
     ctre::ctre
     uuid
     scn::scn
     alpaca::alpaca
     leveldb::leveldb
     
     #[[ dll only :( ]]
     ${STEAM_LIBS}
     )

set( ENGINE_LIBS
     libassert::assert
     ipaddress::ipaddress
     )


set( CLIENT_LIBS ${LIBS} )
set( SERVER_LIBS ${LIBS} )

set( ENGINE_CLIENT_LIBS
     ${LIBS}
     ${ENGINE_LIBS}
     Vulkan::Vulkan
     glfw
     phonon
     unofficial::gainput::gainput
     )

set( ENGINE_SERVER_LIBS
     ${LIBS}
     ${ENGINE_LIBS}
     )
