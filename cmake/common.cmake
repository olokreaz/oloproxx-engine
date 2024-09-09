########################################################################
# COMMON FUNCTIONS
########################################################################

# Function to set a glob pattern for files with specific extensions in a directory
function ( set_glob VAR GLOBBING EXTS DIRECTORY )
	set( GLOBS )
	foreach ( ext ${EXTS} )
		list( APPEND GLOBS "${DIRECTORY}/${ext}" )
	endforeach ()
	file( ${GLOBBING} GLOB_RESULT ${GLOBS} )
	list( SORT GLOB_RESULT )
	
	set( FILES )
	foreach ( file ${ARGN} )
		list( APPEND FILES "${PROJECT_SOURCE_DIR}/${DIRECTORY}/${file}" )
	endforeach ()
	
	if ( NOT FILES STREQUAL GLOB_RESULT )
		set( LIST_BUT_NOT_GLOB )
		foreach ( file ${FILES} )
			if ( NOT file IN_LIST GLOB_RESULT )
				list( APPEND LIST_BUT_NOT_GLOB ${file} )
			endif ()
		endforeach ()
		if ( LIST_BUT_NOT_GLOB )
			message( AUTHOR_WARNING "Entries only present in ${VAR}: ${LIST_BUT_NOT_GLOB}" )
		endif ()
		
		set( GLOB_BUT_NOT_LIST )
		foreach ( file ${GLOB_RESULT} )
			if ( NOT file IN_LIST FILES )
				list( APPEND GLOB_BUT_NOT_LIST ${file} )
			endif ()
		endforeach ()
		if ( NOT LIST_BUT_NOT_GLOB AND NOT GLOB_BUT_NOT_LIST )
			message( AUTHOR_WARNING "${VAR} is not alphabetically sorted" )
		endif ()
	endif ()
	
	set( ${VAR} ${FILES} PARENT_SCOPE )
endfunction ()

# Function to set source files for a project
function ( set_src VAR GLOBBING DIRECTORY )
	set_glob( ${VAR} ${GLOBBING} "c;cpp;h;hpp" ${DIRECTORY} ${ARGN} )
	set( ${VAR} ${${VAR}} PARENT_SCOPE )
	set( CHECKSUM_SRC ${CHECKSUM_SRC} ${${VAR}} PARENT_SCOPE )
endfunction ()

# Function to set resource files for a project
function ( set_res VAR GLOBBING DIRECTORY )
	set_glob( ${VAR} ${GLOBBING} "jpg;jpeg;png;wav;mp3;txt;data;bin" ${DIRECTORY} ${ARGN} )
	set( ${VAR} ${${VAR}} PARENT_SCOPE )
	set( CHECKSUM_RES ${CHECKSUM_RES} ${${VAR}} PARENT_SCOPE )
endfunction ()

# Function to generate a .rc file for resources
function ( generate_rc_file DIR_TO_WALK RC_FILE_NAME PREFIX RCTYPE )
	message( STATUS "Generating ${RC_FILE_NAME}.rc from ${PROJECT_BINARY_DIR}/${DIR_TO_WALK}" )
	set( RC_CONTENTS "" )
	file( GLOB_RECURSE FILES RELATIVE ${PROJECT_BINARY_DIR}/${DIR_TO_WALK} "${PROJECT_BINARY_DIR}/${DIR_TO_WALK}/*" )
	
	foreach ( FILE ${FILES} )
		set( EXCLUDE_FILE FALSE )
		foreach ( EXCLUDE_PATTERN ${ARGN} )
			if ( ${FILE} MATCHES ${EXCLUDE_PATTERN} )
				set( EXCLUDE_FILE TRUE )
				break()
			endif ()
		endforeach ()
		
		if ( NOT ${EXCLUDE_FILE} )
			message( STATUS "\tAdding ${FILE} to ${RC_FILE_NAME}.rc" )
			set( RC_CONTENTS "${RC_CONTENTS}\n${PREFIX}${FILE} ${RCTYPE} \"${DIR_TO_WALK}/${FILE}\"" )
		endif ()
	endforeach ()
	
	file( WRITE ${PROJECT_BINARY_DIR}/${RC_FILE_NAME}.rc "${RC_CONTENTS}" )
endfunction ()

# Wrapper function to generate .rc file for data resources
function ( generate_rc_data DIR FILE_NAME PREFIX )
	generate_rc_file( ${DIR} ${FILE_NAME} ${PREFIX} RCDATA ${ARGN} )
endfunction ()

# Wrapper function to generate .rc file for target
function ( target_rc_data target DIR FILE_NAME PREFIX )
	generate_rc_data( ${DIR} ${FILE_NAME} ${PREFIX} ${ARGN} )
	target_sources( ${target} PRIVATE ${PROJECT_BINARY_DIR}/${FILE_NAME}.rc )
endfunction ()


# Function to copy resources dynamically
function ( copy_resource_dynamic SOURCE_DIR TARGET_DIR )
	set( FULL_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${SOURCE_DIR} )
	set( FULL_TARGET_DIR ${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/${TARGET_DIR} )
	
	file( MAKE_DIRECTORY ${FULL_TARGET_DIR} )
	
	foreach ( GLOB_PATTERN ${ARGN} )
		file( GLOB GLOB_RESULT "${FULL_SOURCE_DIR}/${GLOB_PATTERN}" )
		
		foreach ( FILE ${GLOB_RESULT} )
			file( COPY ${FILE} DESTINATION ${FULL_TARGET_DIR} )
		endforeach ()
	endforeach ()
endfunction ()

# Function to add an icon to an executable
function ( add_icon_for_executable target path_to_ico )
	set( ICON_FILE ${CMAKE_BINARY_DIR}/icons/${target}.rc )
	file( WRITE ${ICON_FILE} "ICON \"${path_to_ico}\"" )
	target_sources( ${target} PRIVATE ${ICON_FILE} )
endfunction ()

set( CHECKSUM )

# Function to set source and include files based on multiple base names
#
# This function searches for source and include files in specified directories
# based on provided base names and extensions. It sets the found files to the
# specified variable and updates the CHECKSUM variable.
#
# Parameters:
# - VAR: The variable to set with the found files.
# - SRC_DIR: The directory to search for source files.
# - INC_DIR: The directory to search for include files.
# - ARGN: The list of base names to search for.
#
# The function sets the following variables in the parent scope:
# - VAR_SRC: List of found source files.
# - VAR_INC: List of found include files.
# - VAR: Combined list of found source and include files.
# - CHECKSUM: Updated list of found files.
function ( set_src_and_include VAR SRC_DIR INC_DIR )
	# Initialize lists for source and include files
	set( SRC_FILES )
	set( INC_FILES )
	set( ${VAR}_t )
	
	# Define possible extensions for source and include files
	set( SRC_EXTENSIONS "cpp;c" )
	set( INC_EXTENSIONS "hpp;h" )
	
	#	message( STATUS "******************** Checking for source and include files in directories: ${SRC_DIR} and ${INC_DIR}" )
	
	# Loop through each base name provided as ARGN
	foreach ( BASE_NAME ${ARGN} )
		message( STATUS "Checking for source and include files with base name: ${BASE_NAME}" )
		# Loop through source extensions and check if files exist
		foreach ( EXT ${SRC_EXTENSIONS} )
			set( SRC_FILE "${SRC_DIR}/${BASE_NAME}.${EXT}" )
			#			message( STATUS "Checking for source file: ${SRC_FILE}" )
			if ( EXISTS ${SRC_FILE} )
				set( SRC_FILES ${SRC_FILES} ${SRC_FILE} )
				#				message( STATUS "Found source file: ${SRC_FILE}" )
			endif ()
		endforeach ()
		
		# Loop through include extensions and check if files exist
		foreach ( EXT ${INC_EXTENSIONS} )
			set( INC_FILE "${INC_DIR}/${BASE_NAME}.${EXT}" )
			#			message( STATUS "Checking for include file: ${INC_FILE}" )
			if ( EXISTS ${INC_FILE} )
				set( INC_FILES ${INC_FILES} ${INC_FILE} )
				#				message( STATUS "Found include file: ${INC_FILE}" )
			endif ()
		endforeach ()
	endforeach ()
	
	# Optionally set the variable with the list of found source files
	if ( SRC_FILES )
		set( ${VAR}_SRC ${SRC_FILES} )
		set( ${VAR}_t ${SRC_FILES} )
	else ()
		message( STATUS "No source files found in directory: ${SRC_DIR}" )
	endif ()
	
	# Optionally set the variable with the list of found include files
	if ( INC_FILES )
		set( ${VAR}_INC ${INC_FILES} )
		set( ${VAR}_t ${${VAR}_t} ${INC_FILES} )
	else ()
		message( STATUS "No include files found in directory: ${INC_DIR}" )
	endif ()
	
	set( ${VAR} ${${VAR}_t} PARENT_SCOPE )
	set( CHECKSUM ${CHECKSUM} ${${VAR}} )
	
	#        message( STATUS "SRC_FILES = ${SRC_FILES}" )
	#        message( STATUS "INC_FILES = ${INC_FILES}" )
	#        message( STATUS "******************** Completed checking. ${VAR}_SRC = ${${VAR}_SRC}, ${VAR}_INC = ${${VAR}_INC}" )
endfunction ()

function ( target_force_include tgt file ) #...
	message( STATUS "${tgt} force include ${file}" )
	target_compile_options( ${tgt} PRIVATE
	                        /FI${file}
	                        )
endfunction ()

# set_src_and_include(SHARED_FILE ${CMAKE_CURRENT_SOURCE_DIR}/src/shared ${CMAKE_CURRENT_SOURCE_DIR}/include/oloproxx-engine
#                    filesystem
#                    )
#message(STATUS "Source files: ${SHARED_FILE_SRC}")
#message(STATUS "Include files: ${SHARED_FILE_INC}")
