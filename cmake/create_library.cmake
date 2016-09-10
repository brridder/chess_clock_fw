cmake_minimum_required(VERSION 3.6)


if (NOT __CREATE_LIBRARY__)
    set(__CREATE_LIBRARY__ TRUE)

    function(create_library)
        set(options)
        set(one_value_args NAME)
        set(multi_value_args SOURCES INCLUDE_DIR LIBRARIES)

        cmake_parse_arguments(_CREATE_LIBRARY "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

        if (_CREATE_LIBRARY_NAME)
            #message(STATUS "\tNAME: ${_CREATE_LIBRARY_NAME}")
        else()
            message(FATAL_ERROR "\tCREATE_LIBRARY: NAME is required")
        endif()

        if (_CREATE_LIBRARY_SOURCES)
            #message(STATUS "\tSOURCES: ${_CREATE_LIBRARY_SOURCES}")
        else()
            message(FATAL_ERROR "\tCREATE_LIBRARY: SOURCES is required")
        endif()

        if (_CREATE_LIBRARY_INCLUDE_DIR)
            #message(STATUS "\tINCLUDE_DIR: ${_CREATE_LIBRARY_INCLUDE_DIR}")
        else()
            message(FATAL_ERROR "\t CREATE_LIBRARY: INCLUDE_DIR is required")
        endif()

        if (_CREATE_LIBRARY_LIBRARIES)
            #message(STATUS "\tLIBRARIES: ${_CREATE_LIBRARY_LIBRARIES}")
        endif()

        add_library(${_CREATE_LIBRARY_NAME} ${_CREATE_LIBRARY_SOURCES})
        target_link_libraries(${_CREATE_LIBRARY_NAME} ${_CREATE_LIBRARY_LIBRARIES})
        target_include_directories(${_CREATE_LIBRARY_NAME} PUBLIC ${_CREATE_LIBRARY_INCLUDE_DIR})

    endfunction()
endif()
