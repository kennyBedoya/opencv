#include <cv.h>
#include <highgui.h>

using namespace cv;

int main( int argc, char** argv )
{
 char* imageName = argv[1];

 Mat image;
 image = imread( imageName, 1 );

 if( argc != 2 || !image.data )
 {
   printf( " No image data \n " );
   return -1;
 }

 
 //con la libreria de openCV
 //cvtColor( image, gray_image, CV_BGR2GRAY );

 //secuencial
 Size tam = image.size();

 int width = tam.width;
 int height = tam.height;

 unsigned char *data_image;
 int tam_i = sizeof(unsigned char)*width*height;
 data_image = (unsigned char*)malloc(tam_i); 

 

 //data_image = image.clone();
//Mat gray_image = image.clone();
 
for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            data_image[i*width+j] = image.data[(i*width+j)*3+2]*0.299 + image.data[(i*width+j)*3+1]*0.587 \
                                     + image.data[(i*width+j)*3]*0.114;
        }
}

 Mat gray_image;
 gray_image.create(height, width, CV_8UC1);
 gray_image.data = data_image;
//fin secuencial

 imwrite( "../../images/Gray_Image.jpg", gray_image );

 namedWindow( imageName, CV_WINDOW_AUTOSIZE); //CV_WINDOW_AUTOSIZE
 namedWindow( "Gray image", CV_WINDOW_AUTOSIZE);

 imshow( imageName, image );
 imshow( "Gray image", gray_image );

 waitKey(0);

//free(data_image);

 return 0;
}
