cmake_minimum_required(VERSION 3.6)

SET(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG} -DDEBUG")
SET(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE} -DNDEBUG")
SET(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -D__STARTUP_CLEAR_BSS -g -mcpu=cortex-m0plus -Wall -mfloat-abi=soft")
SET(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS}  -mthumb -fno-common -ffunction-sections -fdata-sections")
SET(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -ffreestanding -fno-builtin -mapcs -std=gnu99")
SET(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -D__NO_SYSTEM_INIT")


SET(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -DDEBUG -g -O0")
SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -DNDEBUG -Os")
SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DCPU_MKL46Z256VLL4 -DFRDM_KL46Z -DFREEDOM -mcpu=cortex-m0plus -Wall -Werror -mfloat-abi=soft")
SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mthumb -MMD -MP -fno-common -ffunction-sections -fdata-sections -ffreestanding -fno-builtin")
SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mapcs -std=gnu99")

SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -g")
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mcpu=cortex-m0plus -Wall -mfloat-abi=soft --specs=nosys.specs")
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fno-common -ffunction-sections -fdata-sections -ffreestanding")
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fno-builtin -mthumb -mapcs -Xlinker --gc-sections -Xlinker -static")
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Xlinker -z -Xlinker muldefs")
