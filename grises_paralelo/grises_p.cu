#include <cv.h>
#include <highgui.h>
#include <time.h>
#include <cuda.h>

using namespace cv;

//kernel
__global__ void image_gray(unsigned char *image_in, int width, int height, unsigned char *image_out){
int row = blockIdx.y*blockDim.y+threadIdx.y;
int col = blockIdx.x*blockDim.x+threadIdx.x;

if((row < height) && (col < width)){
  image_out[row*width+col] = image_in[(row*width+col)*3+ 2]*0.299 + image_in[(row*width+col)*3+ 1]*0.587 + image_in[(row*width+col)*3+0]*0.114;
  }
}

int main( int argc, char** argv ){

 clock_t start, end, startGPU, endGPU;
 double cpu_time_used, gpu_time_used;
 
 //imagen de entrada
 char* imageName = argv[1];

 Mat image;
 image = imread( imageName, 1 );

 if( argc != 2 || !image.data )
 {
   printf( " No image data \n " );
   return -1;
 }

 //tamano imagen recibida
 Size tam = image.size();

 int width = tam.width;
 int height = tam.height;

 //reservar memoria
 unsigned char *data_image, *d_data_image,*image_output, *d_image_output;

 int tam_i = sizeof(unsigned char)*width*height*image.channels();
 int tam_gray = sizeof(unsigned char)*width*height;

 data_image = (unsigned char*)malloc(tam_i);
 cudaMalloc((void**)&d_data_image,tam_i);

 image_output = (unsigned char*)malloc(tam_gray);
 cudaMalloc((void**)&d_image_output,tam_gray);

data_image = image.data;

//pasando al device
startGPU = clock();
cudaMemcpy(d_data_image,image.data,tam_i, cudaMemcpyHostToDevice);


 int blockSize = 32;
 dim3 dimBlock(blockSize,blockSize,1);
 dim3 dimGrid(ceil(width/float(blockSize)),ceil(height/float(blockSize)),1);
 image_gray<<<dimGrid,dimBlock>>>(d_data_image,width,height,d_image_output);
 cudaDeviceSynchronize();

 //pasando al host
 cudaMemcpy(image_output,d_image_output,tam_gray,cudaMemcpyDeviceToHost);
 endGPU = clock();
 
 start = clock();
 Mat gray_image_opencv;
 cvtColor(image, gray_image_opencv, CV_BGR2GRAY);
 end = clock();

 //creando imagenes
 Mat gray_image;
 gray_image.create(height, width, CV_8UC1);
 gray_image.data = image_output;

 //mostrar imagenes
 imwrite( "../../images/Gray_Image.jpg", gray_image );

 namedWindow( imageName, CV_WINDOW_AUTOSIZE); //CV_WINDOW_AUTOSIZE
 namedWindow( "Gray image CUDA", CV_WINDOW_AUTOSIZE);
 namedWindow("Gray image OpenCV", CV_WINDOW_AUTOSIZE);

 imshow( imageName, image );
 imshow( "Gray image CUDA", gray_image );
 imshow ("Gray image OpenCV", gray_image_opencv);

 waitKey(0);
 
 gpu_time_used = ((double) (endGPU - startGPU)) / CLOCKS_PER_SEC;
 printf("Tiempo Algoritmo Paralelo: %.10f\n",gpu_time_used);
 cpu_time_used = ((double) (end - start)) /CLOCKS_PER_SEC;
 printf("Tiempo Algoritmo OpenCV: %.10f\n",cpu_time_used);

 cudaFree(d_data_image);
 cudaFree(d_image_output);

 return 0;

}

