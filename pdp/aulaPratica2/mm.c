#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#define MAX_THREADS 16
#define OUTPUT_FILE "./mm_out.txt"


void mm_omp(double *A, double *B, double *C, int n){

	// Define o bloco abaixo como paralelo
	#pragma omp parallel
	{
		int i, j, k;
		// Executa o for paralelamente
		#pragma omp for
		for (i = 0; i < n; i++) {
			for (j = 0; j < n; j++) {
				double dot = 0;
				for (k = 0; k < n; k++) {
					dot += A[i*n+k]*B[k*n+j];
				}
				C[i*n+j] = dot;
			}
		}
	}
}

void run_benchmark(int n){
	// Executa toda a multiplicacao para um tamanho n x n de matrix

	int i;
	double *A, *B, *C, dtime;
	FILE *file;

	file = fopen(OUTPUT_FILE, "a+");

	if(!file){
		fprintf(stderr, "Could not open file %s\n", OUTPUT_FILE);
		return;
	}

	fprintf(file, "Running matrix multiplication with n = %d\n", n);
	fprintf(stderr, "Running matrix multiplication with n = %d\n", n);

	A = (double*)malloc(sizeof(double)*n*n);
	B = (double*)malloc(sizeof(double)*n*n);
	C = (double*)malloc(sizeof(double)*n*n);
	for(i=0; i<n*n; i++) { A[i] = rand()/RAND_MAX; B[i] = rand()/RAND_MAX;}

	for(i = 1; i <= MAX_THREADS; i++){
		omp_set_num_threads(i);
		fprintf(stderr, "Running on %d threads\n", i);

		dtime = omp_get_wtime();
		mm_omp(A,B,C, n);
		dtime = omp_get_wtime() - dtime;

		fprintf(file, "%d threads: Computed in %.4g seconds\n", i, dtime);
	}

	free(A);
	free(B);
	free(C);
	fclose(file);
}


int main(){

	run_benchmark(750);
	run_benchmark(1000);
    return 0;
}
