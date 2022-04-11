cmake_minimum_required(VERSION 3.18.4)

set(BAREMETAL_ARM_TOOLCHAIN_PATH /usr/bin)
set(CMAKE_TOOLCHAIN_FILE toolchain.cmake)

project(teensyistic LANGUAGES C CXX)

set( CMAKE_VERBOSE_MAKEFILE on )
set(TEENSY_DIR "driver/teensy4")
set(TEENSY_DIR_MAKEFILE "${TEENSY_DIR}/Makefile")


# Specify our source files
file(GLOB SRC
  "src/*.cpp"
  "src/*.c"
  "${TEENSY_DIR}/*.cpp"
  "${TEENSY_DIR}/*.c"
)

list(APPEND sources
  ${SRC}
)

include_directories(
    "${TEENSY_DIR}"
    "src"
)

set_property(DIRECTORY PROPERTY ADDITIONAL_CLEAN_FILES
  "teensyistic.hex"
)

add_executable(teensyistic.elf ${sources})

add_custom_command(TARGET teensyistic.elf
  POST_BUILD
  COMMAND ${CMAKE_SIZE} ARGS teensyistic.elf
)

add_custom_command(TARGET teensyistic.elf
  POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} ARGS -O ihex -R .eeprom teensyistic.elf teensyistic.hex
)
