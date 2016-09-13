cmake_minimum_required(VERSION 3.6)

if (NOT __CREATE_LIBRARY__)
    set(__CREATE_LIBRARY__ TRUE)

    set(VERBOSE_LIBRARY FALSE)

    function(create_library)
        set(options)
        set(one_value_args NAME)
        set(multi_value_args SOURCES INCLUDE_DIR LIBRARIES)

        cmake_parse_arguments(_CREATE_LIBRARY "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

        if (_CREATE_LIBRARY_NAME)
            if (VERBOSE_LIBRARY)
                message(STATUS "\tNAME: ${_CREATE_LIBRARY_NAME}")
            endif()
        else()
            message(FATAL_ERROR "\tCREATE_LIBRARY: NAME is required")
        endif()

        if (_CREATE_LIBRARY_SOURCES)
            if (VERBOSE_LIBRARY)
                message(STATUS "\tSOURCES: ${_CREATE_LIBRARY_SOURCES}")
            endif()
        else()
            message(FATAL_ERROR "\tCREATE_LIBRARY: SOURCES is required")
        endif()

        if (_CREATE_LIBRARY_INCLUDE_DIR)
            if (VERBOSE_LIBRARY)
                message(STATUS "\tINCLUDE_DIR: ${_CREATE_LIBRARY_INCLUDE_DIR}")
            endif()
        else()
            message(FATAL_ERROR "\t CREATE_LIBRARY: INCLUDE_DIR is required")
        endif()

        if (_CREATE_LIBRARY_LIBRARIES)
            if (VERBOSE_LIBRARY)
                message(STATUS "\tLIBRARIES: ${_CREATE_LIBRARY_LIBRARIES}")
            endif()
        endif()

        add_library(${_CREATE_LIBRARY_NAME} ${_CREATE_LIBRARY_SOURCES})
        target_link_libraries(${_CREATE_LIBRARY_NAME} ${_CREATE_LIBRARY_LIBRARIES})
        target_include_directories(${_CREATE_LIBRARY_NAME} PUBLIC ${_CREATE_LIBRARY_INCLUDE_DIR})

    endfunction()

    function(create_interface_library)
        set(options)
        set(one_value_args NAME)
        set(multi_value_args INCLUDE_DIR LIBRARIES)

        cmake_parse_arguments(_CREATE_INTERFACE_LIBRARY "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

        if (_CREATE_INTERFACE_LIBRARY_NAME)
            if (VERBOSE_LIBRARY)
                message(STATUS "\tNAME: ${_CREATE_INTERFACE_LIBRARY_NAME}")
            endif()
        else()
            message(FATAL_ERROR "\tCREATE_LIBRARY: NAME is required")
        endif()

        if (_CREATE_INTERFACE_LIBRARY_INCLUDE_DIR)
            if (VERBOSE_LIBRARY)
                message(STATUS "\tINCLUDE_DIR: ${_CREATE_INTERFACE_LIBRARY_INCLUDE_DIR}")
            endif()
        else()
            message(FATAL_ERROR "\t CREATE_LIBRARY: INCLUDE_DIR is required")
        endif()

        if (_CREATE_INTERFACE_LIBRARY_LIBRARIES)
            if (VERBOSE_LIBRARY)
                message(STATUS "\tLIBRARIES: ${_CREATE_INTERFACE_LIBRARY_LIBRARIES}")
            endif()
        endif()

        add_library(${_CREATE_INTERFACE_LIBRARY_NAME} INTERFACE)
        target_link_libraries(${_CREATE_INTERFACE_LIBRARY_NAME} ${_CREATE_INTERFACE_LIBRARY_LIBRARIES})
        target_include_directories(${_CREATE_INTERFACE_LIBRARY_NAME} INTERFACE ${_CREATE_INTERFACE_LIBRARY_INCLUDE_DIR})
    endfunction()

endif()
