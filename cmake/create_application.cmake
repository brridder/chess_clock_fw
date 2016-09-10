cmake_minimum_required(VERSION 3.6)

if(NOT __CREATE_APPLICATION__)
    set(__CREATE_APPLICATION__ TRUE)

    function(create_application)
        set(options)
        set(one_value_args NAME LINKER_SCRIPT)
        set(multi_value_args SOURCES INCLUDE_DIR LIBRARIES)

        cmake_parse_arguments(_CREATE_APPLICATION "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

        get_property(_BUILD_TARGET CACHE "BUILD_TARGET" PROPERTY VALUE SET)
        get_property(_BUILD_HOST CACHE "BUILD_HOST" PROPERTY VALUE SET)
        message(STATUS "APPLICATION")
        if (_CREATE_APPLICATION_NAME)
            message(STATUS "\tNAME: ${_CREATE_APPLICATION_NAME}")
        else()
            message(FATAL_ERROR "CREATE_APPLICATION: NAME is required")
        endif()

        if (_CREATE_APPLICATION_LINKER_SCRIPT)
            message(STATUS "\tLINKER_SCRIPT: ${_CREATE_APPLICATION_LINKER_SCRIPT}")
        else()
            message(FATAL_ERROR "CREATE_APPLICATION: LINKER_SCRIPT is required")
        endif()

        if (_CREATE_APPLICATION_INCLUDE_DIR)
            message(STATUS "\tINCLUDE_DIRS: ${_CREATE_APPLICATION_INCLUDE_DIR}")
        else()
            set(_CREATE_APPLICATION_INCLUDE_DIR "")
        endif()

        if (_CREATE_APPLICATION_LIBRARIES)
            message(STATUS "\tLIBRARIES: ${_CREATE_APPLICATION_LIBRARIES}")
        endif()

        if (_CREATE_APPLICATION_SOURCES)
            message(STATUS "\tSOURCES: ${_CREATE_APPLICATION_SOURCES}")
        else()
            message(FATAL_ERROR "\tCREATE_APPLICATION: SOURCES are required")
        endif()

        # NAME setup

        set(APPLICATION_NAME ${_CREATE_APPLICATION_NAME})

        if (BUILD_TARGET)
            set(APPLICATION_NAME ${APPLICATION_NAME}.elf)
        endif()

        add_executable(${APPLICATION_NAME} ${_CREATE_APPLICATION_SOURCES})
        target_include_directories(${APPLICATION_NAME} PUBLIC ${_CREATE_APPLICATION_INCLUDE_DIR})
        target_link_libraries(${APPLICATION_NAME} ${_CREATE_APPLICATION_LIBRARIES})

        list(APPEND FILES "")
        if(BUILD_TARGET)
            set(MAP_LOCATION ${PROJECT_BINARY_DIR}/apps/${_CREATE_APPLICATION_NAME}/${_CREATE_APPLICATION_NAME}.map)
            set_target_properties(${APPLICATION_NAME} PROPERTIES LINK_FLAGS " -Wl,-T,${_CREATE_APPLICATION_LINKER_SCRIPT} -Xlinker -Map=${MAP_LOCATION}")
            add_binary(${_CREATE_APPLICATION_NAME}.bin ${APPLICATION_NAME})
            add_hex(${_CREATE_APPLICATION_NAME}.hex ${APPLICATION_NAME})

            set(EXTENSIONS hex elf map bin)
            foreach(EXTENSION ${EXTENSIONS})
                list(APPEND FILES "${CMAKE_CURRENT_BINARY_DIR}/${_CREATE_APPLICATION_NAME}.${EXTENSION}")
            endforeach()
        else()
            list(APPEND FILES "${CMAKE_CURRENT_BINARY_DIR}/${APPLICATION_NAME}")
        endif()

        set(INSTALL_PATH ${CMAKE_INSTALL_PREFIX})
        message(STATUS "\tINSTALL_PATH=${INSTALL_PATH}")
        message(STATUS "\tINSTALL_FILES${FILES}")

        install(FILES ${FILES} DESTINATION ${INSTALL_PATH} PERMISSIONS OWNER_EXECUTE OWNER_READ)

    endfunction()

endif()
