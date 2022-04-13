cmake_minimum_required(VERSION 3.18.4)

# Set compiler path, include toolchain parameters
set(BAREMETAL_ARM_TOOLCHAIN_PATH /usr/bin)
set(CMAKE_TOOLCHAIN_FILE toolchain.cmake)

project(teensyistic LANGUAGES C CXX)

# Common directories
set(SRC_FILES "${CMAKE_SOURCE_DIR}/src")
set(BUILD_FILES "${CMAKE_SOURCE_DIR}/build")
set(TEENSY_DRIVER_DIR "${CMAKE_SOURCE_DIR}/driver/teensy4")


# Specify our source files
file(GLOB ${CMAKE_PROJECT_NAME}_src
  "${SRC_FILES}/*.cpp"
  "${SRC_FILES}/*.c"
  "${TEENSY_DRIVER_DIR}/*.cpp"
  "${TEENSY_DRIVER_DIR}/*.c"
)

include_directories(
    "${TEENSY_DRIVER_DIR}"
    "${SRC_FILES}"
)

# Clean up the hex file we created
set_property(DIRECTORY PROPERTY ADDITIONAL_CLEAN_FILES
  "${BUILD_DIR}/${CMAKE_PROJECT_NAME}.hex"
)

# Compile the elf
add_executable(${CMAKE_PROJECT_NAME}.elf ${${CMAKE_PROJECT_NAME}_src})

# Print executable size
add_custom_command(TARGET ${CMAKE_PROJECT_NAME}.elf
  POST_BUILD
  COMMAND ${CMAKE_SIZE} ARGS ${CMAKE_PROJECT_NAME}.elf
)

# Create the hex file
add_custom_command(TARGET ${CMAKE_PROJECT_NAME}.elf
  POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} ARGS -O ihex -R .eeprom ${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.hex
)

# Upload the hex file to the teensy
add_custom_command(TARGET ${CMAKE_PROJECT_NAME}.elf
  POST_BUILD
  COMMAND ${CMAKE_SOURCE_DIR}/tools/teensy_post_compile ARGS -file=${BUILD_DIR}/${CMAKE_PROJECT_NAME} -path=${CMAKE_SOURCE_DIR}/build -tools=${CMAKE_SOURCE_DIR}/tools
)

# Reboot teensy
add_custom_command(TARGET ${CMAKE_PROJECT_NAME}.elf
  POST_BUILD
  COMMAND ${CMAKE_SOURCE_DIR}/tools/teensy_reboot
)
