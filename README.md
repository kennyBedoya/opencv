# Sobel
### Conversión de imágenes a escala de grises
#### Introducción
Se realizó la codificación de 5 algoritmos los cuales deben cumplir con el mismo objetivo, para así realizar una comparación de desempeño entre ellos, el objetivo de los algoritmos consta de convertir una imágen a escala de grises. Cada algoritmo se encuentra en una carpeta de código fuente separada para facilitar su compilación y/o ejecución, encontrandonos con el siguiente contenido por carpetas:
- **grises:** implementación secuencial implementada en *C*.
- **grises_cache:** implementación paralela implementada en *Cuda C* haciendo uso de caché.
- **grises_compartida:** implementación paralela implementada en *Cuda C* haciendo uso de memoria compartida.
- **grises_global:** implementación paralela implementada en *Cuda C* haciendo uso de memoria global.
- **grises_paralelo:** implementación paralela implementada en *Cuda C*.

Además una carpeta de nombre *media* en la cual se encuentran las imágenes usadas en la ejecución y en el análisis de tiempos que se presentará a continuación. Dichos algoritmos fueron ejecutados en una GPU Nvidia Gforce GTx 980, la cual fue puesta a disposición para pruebas del curso de computación de alto desempeño, *High Performance Computing (HPC)*, por el semillero de la facultada de ingenierías *Sirius*.

A continuación se muestran las tablas con los datos obtenidos en las pruebas comparativas las cuales usan los siguientes datos:

- **Ts:** tiempo de ejecución del algoritmo secuencial.
- **Tp:** tiempo de ejecución del algoritmo paralelo ingenuo.
- **Tpc:** tiempo de ejecución del algoritmo paralelo haciendo uso de caché.
- **Tpg:** tiempo de ejecución del algoritmo paralelo haciendo uso de memoria global.
- **Tpca:** tiempo de ejecución del algoritmo paralelo haciendo uso de memoria compartida.
- **OpenCV:** tiempo de ejecución del algoritmo de la librería de OpenCV.

A continuación se muestran las tablas con los condesados de promedios de aceleraciones para los algoritmos, los cuales fueron ejecutados con 6 imágenes con las siguientes diferentes resoluciones:

- 600x450
- 720x460
- 960x540
- 1600x1200
- 2048x1280
- 3648x2053
