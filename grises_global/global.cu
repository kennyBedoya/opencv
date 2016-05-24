#include <cv.h>
#include <highgui.h>
#include <time.h>
#include <cuda.h>

#define RED 2
#define GREEN 1
#define BLUE 0

#define MASK_WIDTH 3

using namespace cv;

__device__ unsigned char clamp(int value){
    if(value < 0)
        value = 0;
    else
        if(value > 255)
            value = 255;
    return (unsigned char)value;
}

__global__ void sobelFilter_global(unsigned char *imageInput, int width, int height, unsigned int maskWidth,\
        char *M,unsigned char *imageOutput){
    unsigned int row = blockIdx.y*blockDim.y+threadIdx.y;
    unsigned int col = blockIdx.x*blockDim.x+threadIdx.x;

    int Pvalue = 0;

    int N_start_point_row = row - (maskWidth/2);
    int N_start_point_col = col - (maskWidth/2);

    for(int i = 0; i < maskWidth; i++){
        for(int j = 0; j < maskWidth; j++ ){
            if((N_start_point_col + j >=0 && N_start_point_col + j < width) \
                    &&(N_start_point_row + i >=0 && N_start_point_row + i < height)){
                Pvalue += imageInput[(N_start_point_row + i)*width+(N_start_point_col + j)] * M[i*maskWidth+j];
            }
        }
    }
    imageOutput[row*width+col] = clamp(Pvalue);
}

__global__ void img2gray(unsigned char *imageInput, int width, int height, unsigned char *imageOutput){
    int row = blockIdx.y*blockDim.y+threadIdx.y;
    int col = blockIdx.x*blockDim.x+threadIdx.x;

    if((row < height) && (col < width)){
        imageOutput[row*width+col] = imageInput[(row*width+col)*3+RED]*0.299 + imageInput[(row*width+col)*3+GREEN]*0.587 \
                                     + imageInput[(row*width+col)*3+BLUE]*0.114;
    }
}

//---------------Función secuencial------------------------
unsigned char *imagenGrises(unsigned char *gray, int height, int width, Mat image){ 
    unsigned char *imagen_salida;
    for(int i=0; i<height; i++){
        for(int j=0; j<width; j++){
        gray[(i*width+j)]= 0.299*image.data[(i*width+j)*3+2] + 0.587*image.data[(i*width+j)*3+1] + 0.114*image.data[(i*width+j)*3];
    }    
    }
    imagen_salida=gray;
    return imagen_salida;
}

int main(int argc, char **argv){
    cudaError_t error = cudaSuccess;
    clock_t start, end, startGPU, endGPU;
    double cpu_time_used, gpu_time_used;
    char h_M[] = {-1,0,1,-2,0,2,-1,0,1}, *d_M;
    char* imageName = argv[1];
    unsigned char *image_aux,*gray;
    unsigned char *h_ImageInput, *d_ImageInput, *d_imageOutput, *h_imageOutput, *d_sobelOutput;
    Mat image;
    image = imread(imageName, 1);

    if(argc !=2 || !image.data){
        printf("No image Data \n");
        return -1;
    }

    Size s = image.size();

    int width = s.width;
    int height = s.height;
    int size = sizeof(unsigned char)*width*height*image.channels();
    int sizeGray = sizeof(unsigned char)*width*height;
    
    //------------Imagenes en escala de grises secuencial----
    Mat image_gray;

    gray = (unsigned char*)malloc(size);
    start = clock();
    for(int i=0; i<height; i++){
        for(int j=0; j<width; j++){
        gray[(i*width+j)]= 0.299*image.data[(i*width+j)*3+2] + 0.587*image.data[(i*width+j)*3+1] + 0.114*image.data[(i*width+j)*3];
    }    
    }
    end=clock();
    image_gray.create(height,width,CV_8UC1);
    image_gray.data=gray;
    //----------------------------------------------

    h_ImageInput = (unsigned char*)malloc(size);
    error = cudaMalloc((void**)&d_ImageInput,size);
    if(error != cudaSuccess){
        printf("Error reservando memoria para d_ImageInput\n");
        exit(-1);
    }

    error = cudaMalloc((void**)&d_M,sizeof(char)*9);
    if(error != cudaSuccess){
        printf("Error reservando memoria para d_M\n");
        exit(-1);
    }

    h_imageOutput = (unsigned char *)malloc(sizeGray);
    error = cudaMalloc((void**)&d_imageOutput,sizeGray);
    if(error != cudaSuccess){
        printf("Error reservando memoria para d_imageOutput\n");
        exit(-1);
    }

    error = cudaMalloc((void**)&d_sobelOutput,sizeGray);
    if(error != cudaSuccess){
        printf("Error reservando memoria para d_sobelOutput\n");
        exit(-1);
    }

    h_ImageInput = image.data;

    startGPU = clock();

    error = cudaMemcpy(d_ImageInput,h_ImageInput,size, cudaMemcpyHostToDevice);
    if(error != cudaSuccess){
        printf("Error copiando los datos de h_ImageInput a d_ImageInput \n");
        exit(-1);
    }

		error = cudaMemcpy(d_M,h_M,sizeof(char)*9,cudaMemcpyHostToDevice);
		if(error != cudaSuccess){
				printf("Error copiando los datos de h_ImageInput a d_ImageInput \n");
				exit(-1);
		}

    int blockSize = 32;
    dim3 dimBlock(blockSize,blockSize,1);
    dim3 dimGrid(ceil(width/float(blockSize)),ceil(height/float(blockSize)),1);
    img2gray<<<dimGrid,dimBlock>>>(d_ImageInput,width,height,d_imageOutput);
    cudaDeviceSynchronize();
    sobelFilter_global<<<dimGrid,dimBlock>>>(d_imageOutput,width,height,3,d_M,d_sobelOutput);
    cudaMemcpy(h_imageOutput,d_sobelOutput,sizeGray,cudaMemcpyDeviceToHost);
    endGPU = clock();

    Mat gray_image;
    gray_image.create(height,width,CV_8UC1);
    gray_image.data = h_imageOutput;

    start = clock();
    Mat gray_image_opencv, grad_x, abs_grad_x;
    cvtColor(image, gray_image_opencv, CV_BGR2GRAY);
    Sobel(gray_image_opencv,grad_x,CV_8UC1,1,0,3,1,0,BORDER_DEFAULT);
    convertScaleAbs(grad_x, abs_grad_x);
    end = clock();


    imwrite("./Sobel_Image.jpg",gray_image);

    //namedWindow(imageName, WINDOW_NORMAL);
    //namedWindow("Gray Image CUDA secuencial", WINDOW_NORMAL);
    //namedWindow("Gray Image SOBEL global", WINDOW_NORMAL);
    //namedWindow("Sobel Image OpenCV", WINDOW_NORMAL);

    //imshow(imageName,image);
    //imshow("Gray Image CUDA secuencial", image_gray);
    //imshow("Gray Image SOBEL global", gray_image);
    //imshow("Sobel Image OpenCV",abs_grad_x);
    waitKey(0);

    //free(h_ImageInput);    
    gpu_time_used = ((double) (endGPU - startGPU)) / CLOCKS_PER_SEC;
    printf("Tiempo Algoritmo sobel global: %.10f\n",gpu_time_used);
    cpu_time_used = ((double) (end - start)) /CLOCKS_PER_SEC;
    printf("Tiempo Algoritmo secuencial: %.10f\n",cpu_time_used);
    printf("La aceleración obtenida es de %.10fX\n",cpu_time_used/gpu_time_used);

    cudaFree(d_ImageInput);
    cudaFree(d_imageOutput);
    cudaFree(d_M);
    cudaFree(d_sobelOutput);
    return 0;
}
