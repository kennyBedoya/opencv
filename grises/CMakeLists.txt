cmake_minimum_required(VERSION 2.8)
project( EscalaGrises )
find_package( OpenCV REQUIRED )
add_executable( grises grises.cc )
target_link_libraries( grises ${OpenCV_LIBS} )

