cmake_minimum_required(VERSION 2.8)
project( EscalaGrisesParalelo )
find_package( OpenCV REQUIRED )
add_executable( grises_p grises_p.cu )
target_link_libraries( grises_p ${OpenCV_LIBS} )

