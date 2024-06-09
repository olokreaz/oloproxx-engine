cmake_minimum_required( VERSION 3.22 )
project( oloproxx-engine )

set( CMAKE_CXX_STANDARD 23 )
set( CMAKE_EXPORT_COMPILE_COMMANDS ON )
message( STATUS "~ ~ ~ ~ ~ ${PROJECT_NAME} ~ ~ ~ ~ ~" )

message( STATUS "CMAKE_CUR_SOURCE ${CMAKE_CURRENT_SOURCE_DIR}" )
message( STATUS "CMAKE_SOURCE ${CMAKE_SOURCE_DIR}" )

message( STATUS "CMAKE_CUR_BIN ${CMAKE_CURRENT_BINARY_DIR}" )
message( STATUS "CMAKE_BIN ${CMAKE_BINARY_DIR}" )