# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.3

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/judge_hpccourse/kenny/opencv/prueba

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/judge_hpccourse/kenny/opencv/prueba/build

# Include any dependencies generated for this target.
include CMakeFiles/mostrar.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/mostrar.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/mostrar.dir/flags.make

CMakeFiles/mostrar.dir/mostrar.cc.o: CMakeFiles/mostrar.dir/flags.make
CMakeFiles/mostrar.dir/mostrar.cc.o: ../mostrar.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/judge_hpccourse/kenny/opencv/prueba/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/mostrar.dir/mostrar.cc.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/mostrar.dir/mostrar.cc.o -c /home/judge_hpccourse/kenny/opencv/prueba/mostrar.cc

CMakeFiles/mostrar.dir/mostrar.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/mostrar.dir/mostrar.cc.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/judge_hpccourse/kenny/opencv/prueba/mostrar.cc > CMakeFiles/mostrar.dir/mostrar.cc.i

CMakeFiles/mostrar.dir/mostrar.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/mostrar.dir/mostrar.cc.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/judge_hpccourse/kenny/opencv/prueba/mostrar.cc -o CMakeFiles/mostrar.dir/mostrar.cc.s

CMakeFiles/mostrar.dir/mostrar.cc.o.requires:

.PHONY : CMakeFiles/mostrar.dir/mostrar.cc.o.requires

CMakeFiles/mostrar.dir/mostrar.cc.o.provides: CMakeFiles/mostrar.dir/mostrar.cc.o.requires
	$(MAKE) -f CMakeFiles/mostrar.dir/build.make CMakeFiles/mostrar.dir/mostrar.cc.o.provides.build
.PHONY : CMakeFiles/mostrar.dir/mostrar.cc.o.provides

CMakeFiles/mostrar.dir/mostrar.cc.o.provides.build: CMakeFiles/mostrar.dir/mostrar.cc.o


# Object files for target mostrar
mostrar_OBJECTS = \
"CMakeFiles/mostrar.dir/mostrar.cc.o"

# External object files for target mostrar
mostrar_EXTERNAL_OBJECTS =

mostrar: CMakeFiles/mostrar.dir/mostrar.cc.o
mostrar: CMakeFiles/mostrar.dir/build.make
mostrar: /usr/local/lib/libopencv_videostab.so.2.4.9
mostrar: /usr/local/lib/libopencv_ts.a
mostrar: /usr/local/lib/libopencv_superres.so.2.4.9
mostrar: /usr/local/lib/libopencv_stitching.so.2.4.9
mostrar: /usr/local/lib/libopencv_contrib.so.2.4.9
mostrar: /usr/lib/x86_64-linux-gnu/libGLU.so
mostrar: /usr/lib/x86_64-linux-gnu/libGL.so
mostrar: /usr/lib/x86_64-linux-gnu/libSM.so
mostrar: /usr/lib/x86_64-linux-gnu/libICE.so
mostrar: /usr/lib/x86_64-linux-gnu/libX11.so
mostrar: /usr/lib/x86_64-linux-gnu/libXext.so
mostrar: /usr/local/lib/libopencv_nonfree.so.2.4.9
mostrar: /usr/local/lib/libopencv_ocl.so.2.4.9
mostrar: /usr/local/lib/libopencv_gpu.so.2.4.9
mostrar: /usr/local/lib/libopencv_photo.so.2.4.9
mostrar: /usr/local/lib/libopencv_objdetect.so.2.4.9
mostrar: /usr/local/lib/libopencv_legacy.so.2.4.9
mostrar: /usr/local/lib/libopencv_video.so.2.4.9
mostrar: /usr/local/lib/libopencv_ml.so.2.4.9
mostrar: /usr/local/lib/libopencv_calib3d.so.2.4.9
mostrar: /usr/local/lib/libopencv_features2d.so.2.4.9
mostrar: /usr/local/lib/libopencv_highgui.so.2.4.9
mostrar: /usr/local/lib/libopencv_imgproc.so.2.4.9
mostrar: /usr/local/lib/libopencv_flann.so.2.4.9
mostrar: /usr/local/lib/libopencv_core.so.2.4.9
mostrar: CMakeFiles/mostrar.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/judge_hpccourse/kenny/opencv/prueba/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable mostrar"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mostrar.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/mostrar.dir/build: mostrar

.PHONY : CMakeFiles/mostrar.dir/build

CMakeFiles/mostrar.dir/requires: CMakeFiles/mostrar.dir/mostrar.cc.o.requires

.PHONY : CMakeFiles/mostrar.dir/requires

CMakeFiles/mostrar.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/mostrar.dir/cmake_clean.cmake
.PHONY : CMakeFiles/mostrar.dir/clean

CMakeFiles/mostrar.dir/depend:
	cd /home/judge_hpccourse/kenny/opencv/prueba/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/judge_hpccourse/kenny/opencv/prueba /home/judge_hpccourse/kenny/opencv/prueba /home/judge_hpccourse/kenny/opencv/prueba/build /home/judge_hpccourse/kenny/opencv/prueba/build /home/judge_hpccourse/kenny/opencv/prueba/build/CMakeFiles/mostrar.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/mostrar.dir/depend

