#include<stdio.h>
#include<stdlib.h>

void initialize_matrices();
void multiply_matrices();

int main(int argc, char* argv[])
{
    fprintf(stderr, "Comecando exemplo2\n");

    initialize_matrices();

    multiply_matrices();    

    fprintf(stderr, "Terminando exemplo2\n");

	return 0;
}

/*
* Naive matrix multiplication
* Author:  P.J. Drongowski
* Date:    10 June 2013
* Copyright (c) 2013 Paul J. Drongowski
*/

#define MSIZE     1000
float matrix_a[MSIZE][MSIZE] ;
float matrix_b[MSIZE][MSIZE] ;
float matrix_r[MSIZE][MSIZE] ;

void initialize_matrices(){
    int i, j ;
    int n = MSIZE;
	{
        for (i = 0 ; i < MSIZE ; i++) {
            for (j = 0 ; j < MSIZE ; j++) {
                matrix_a[i][j] = (float) rand() / RAND_MAX ;
                matrix_b[i][j] = (float) rand() / RAND_MAX ;
                matrix_r[i][j] = 0.0 ;
            }
        }
    }
}

void multiply_matrices(){
    int i, j, k ;
    int n = MSIZE;
	{
        for (i = 0 ; i < MSIZE ; i++) {
            for (j = 0 ; j < MSIZE ; j++) {
                float sum = 0.0 ;
                for (k = 0 ; k < MSIZE ; k++) {
                    sum = sum + (matrix_a[i][k] * matrix_b[k][j]) ;
                }
                matrix_r[i][j] = sum ;
            }
        }
    }
}
