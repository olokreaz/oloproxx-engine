#[[
Package Engines
]]


set( STEAM_LIBS steam_api64 )

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
     
     ipaddress::ipaddress
     spdlog::spdlog_header_only
     frozen::frozen-headers
     
     steam_api64
     
     glfw
     phonon
     unofficial::gainput::gainput
     
     Vulkan::Vulkan
     
     )
