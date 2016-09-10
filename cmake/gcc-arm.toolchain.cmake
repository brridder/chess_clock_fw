include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_VERSION 1)

set(GCC_ARM_TC_ROOT /usr/local)

if(WIN32)
    set(GCC_ARM_TC_ROOT "${GCC_ARM_TC_ROOT}-win32")
endif()

set(CMAKE_FIND_ROOT_PATH ${GCC_ARM_TC_ROOT}/)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)


set(CMAKE_C_COMPILER ${GCC_ARM_TC_ROOT}/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${GCC_ARM_TC_ROOT}/bin/arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER ${GCC_ARM_TC_ROOT}/bin/arm-none-eabi-gcc)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

function(add_binary BIN_FILE TARGET_ELF)
    set(OBJCOPY ${GCC_ARM_TC_ROOT}/bin/arm-none-eabi-objcopy)
    set(BIN_FILE ${CMAKE_CURRENT_BINARY_DIR}/${BIN_FILE})
    add_custom_command(OUTPUT ${BIN_FILE}
                       COMMAND ${OBJCOPY} -O binary ${TARGET_ELF} ${BIN_FILE}
                       DEPENDS ${TARGET_ELF}
                       COMMENT "objcopy ${BIN_FILE} from ${TARGET_ELF}")
    add_custom_target(ADD_BINARY_${TARGET_ELF} ALL DEPENDS ${BIN_FILE})
endfunction()

function(add_hex HEX_FILE TARGET_ELF)
    set(OBJCOPY ${GCC_ARM_TC_ROOT}/bin/arm-none-eabi-objcopy)
    set(HEX_FILE ${CMAKE_CURRENT_BINARY_DIR}/${HEX_FILE})
    add_custom_command(OUTPUT ${HEX_FILE}
                       COMMAND ${OBJCOPY} -O ihex ${TARGET_ELF} ${HEX_FILE}
                       DEPENDS ${TARGET_ELF}
                       COMMENT "objcopy ${HEX_FILE} from ${TARGET_ELF}")
   add_custom_target(ADD_HEX_${TARGET_ELF} ALL DEPENDS ${HEX_FILE})
endfunction()
