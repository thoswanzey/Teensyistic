## Teensy 4.0 / 4.1 Build System
Generic build system used as a base for my future projects, only linux suport for now. Tested on Pop!\_OS_.

#### Usage:
1. Set the project name in CMakeLists.txt.
2. Modify the compiler/linker flags in toolchain.cmake as needed.
3. Uncomment the designated Teensy 4.X variables in toolchain.cmake.
4. Run `cmake -B build/` to setup the build system.
5. Run `cd build/ && make` to compile and upload the executable to the teensy.