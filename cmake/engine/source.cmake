##############################################################
######################## Source Files ########################
##############################################################


##############################################################
######################## Shared Client #######################
##############################################################
set_src_and_include( SHARED_SRC
                     ${CMAKE_CURRENT_SOURCE_DIR}/src/shared
                     ${CMAKE_CURRENT_SOURCE_DIR}/include/${PROJECT_NAME}/shared
                     #[[######################]]
                     Filesystem
                     
                     )

set_src_and_include( SHARED_SRC
                     ${CMAKE_CURRENT_SOURCE_DIR}/src/base
                     ${CMAKE_CURRENT_SOURCE_DIR}/include/${PROJECT_NAME}/base
                     #[[######################]]
                     system
                     logger
                     log
                     )


