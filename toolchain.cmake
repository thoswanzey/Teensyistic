set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)

# Without that flag CMake is not able to pass test compilation check
set(CMAKE_TRY_COMPILE_TARGET_TYPE   STATIC_LIBRARY)

set(CMAKE_AR                        ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-ar${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_ASM_COMPILER              ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_C_COMPILER                ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-gcc${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_CXX_COMPILER              ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-g++${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_LINKER                    ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-ld${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_OBJCOPY                   ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-objcopy${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_RANLIB                    ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-ranlib${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_SIZE                      ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-size${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")
set(CMAKE_STRIP                     ${BAREMETAL_ARM_TOOLCHAIN_PATH}/arm-none-eabi-strip${CMAKE_EXECUTABLE_SUFFIX} CACHE INTERNAL "")

set(LINKER_SCRIPT_DIR ${CMAKE_SOURCE_DIR}/driver/teensy4)
# Use these lines for Teensy 4.0
set(MCU "IMXRT1062")
set(MCU_LD "${LINKER_SCRIPT_DIR}/imxrt1062.ld")
set(MCU_DEF "ARDUINO_TEENSY40")

# Use these lines for Teensy 4.1
# set(MCU "IMXRT1062")
# set(MCU_LD "${LINKER_SCRIPT_DIR}/imxrt1062_t41.ld")
# set(MCU_DEF "ARDUINO_TEENSY41")

# USB Type configuration:
#   -DUSB_SERIAL
#   -DUSB_DUAL_SERIAL
#   -DUSB_TRIPLE_SERIAL
#   -DUSB_KEYBOARDONLY
#   -DUSB_TOUCHSCREEN
#   -DUSB_HID_TOUCHSCREEN
#   -DUSB_HID
#   -DUSB_SERIAL_HID
#   -DUSB_MIDI
#   -DUSB_MIDI4
#   -DUSB_MIDI16
#   -DUSB_MIDI_SERIAL
#   -DUSB_MIDI4_SERIAL
#   -DUSB_MIDI16_SERIAL
#   -DUSB_AUDIO
#   -DUSB_MIDI_AUDIO_SERIAL
#   -DUSB_MIDI16_AUDIO_SERIAL
#   -DUSB_MTPDISK
#   -DUSB_RAWHID
#   -DUSB_FLIGHTSIM
#   -DUSB_FLIGHTSIM_JOYSTICK

set(TEENSY_OPTIONS              "-DF_CPU=600000000 -DUSB_SERIAL -DLAYOUT_US_ENGLISH -DUSING_MAKEFILE -D__${MCU}__ -DARDUINO=10813 -DTEENSYDUINO=154 -D${MCU_DEF}")
set(CPU_OPTIONS                 "-mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16 -mthumb")
set(LIBRARY_PATH    ${CMAKE_SOURCE_DIR}/driver/tools/arm/lib)

set(CMAKE_C_FLAGS               "-Wall -g -O2 ${CPU_OPTIONS} -MMD ${TEENSY_OPTIONS} -I. -ffunction-sections -fdata-sections")
set(CMAKE_CXX_FLAGS             "${CMAKE_C_FLAGS} -std=gnu++14 -felide-constructors -fno-exceptions -fpermissive -fno-rtti -Wno-error=narrowing")

set(CMAKE_C_FLAGS_DEBUG         "-Og -g" CACHE INTERNAL "")
set(CMAKE_C_FLAGS_RELEASE       "-Og -DNDEBUG" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_DEBUG       "${CMAKE_C_FLAGS_DEBUG}" CACHE INTERNAL "")
set(CMAKE_CXX_FLAGS_RELEASE     "${CMAKE_C_FLAGS_RELEASE}" CACHE INTERNAL "")

set(CMAKE_EXE_LINKER_FLAGS      "-Os -Wl,--gc-sections,--relax ${CPU_OPTIONS} -T${MCU_LD} -L${LIBRARY_PATH} -L${LIBRARY_PATH}/arm_cortexM7lfsp_math -lm -lstdc++")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM     NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY     ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE     ONLY)

# Optionally reduce compiler sanity check when cross-compiling.
set(CMAKE_TRY_COMPILE_TARGET_TYPE         STATIC_LIBRARY)
