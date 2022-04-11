cmake_minimum_required(VERSION 3.18.4)

set(BAREMETAL_ARM_TOOLCHAIN_PATH /usr/bin)
set(CMAKE_TOOLCHAIN_FILE toolchain.cmake)

project(teensyistic LANGUAGES C CXX)

set( CMAKE_VERBOSE_MAKEFILE on )
set(TEENSY_DIR "driver/teensy4")
set(TEENSY_DIR_MAKEFILE "${TEENSY_DIR}/Makefile")


# Extra cleanup
file(GLOB OBJECT_FILES
  "${TEENSY_DIR}/*.o"
)

file(GLOB MAKE_DEPENDENCIES
  "${TEENSY_DIR}/*.d"
)

set_property(DIRECTORY PROPERTY ADDITIONAL_CLEAN_FILES
                         "${OBJECT_FILES}"
                         "${MAKE_DEPENDENCIES}"
                         "${TEENSY_DIR}/main.elf"
                         "${TEENSY_DIR}/main.hex")


# Specify our source files
file(GLOB SRC
  "src/*.cpp"
  "${TEENSY_DIR}/*.cpp"
)

include_directories("${TEENSY_DIR}"
    "src")

add_executable(teensyistic ${SRC})

# add_custom_target(run ALL COMMAND make -C ../${TEENSY_DIR} -f Makefile TARGET=main)
