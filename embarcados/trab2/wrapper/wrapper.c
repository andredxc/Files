#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>
#include "energia.h"

int main(int argc, char *argv[]){

    struct timeval t1, t2;
    double elapsedTime;

    if(argc <= 1 || argc > 2){
        fprintf(stderr, "Usage: ./wrapped \"<application>\"\n");
        return -1;
    }

    rapl_init();

    // Inicializacao da biblio
	start_rapl_sysfs();

    // Inicializar tempo
    gettimeofday(&t1, NULL);

    // Chamar o programa
    system(argv[1]);
     
    // Finalizar coisas   
    gettimeofday(&t2, NULL);
    elapsedTime = (t2.tv_sec - t1.tv_sec) * 1000;        // Sec to ms
    elapsedTime += (t2.tv_usec - t1.tv_usec) / 1000;     // us to ms

    double energy = end_rapl_sysfs();   // (5) Finalizar a contagem dos contadores de energia
    printf("Tempo de execucao em milisegundos: %.5f\n", elapsedTime);
    printf("Energia consumida em Joules:   %.5f\n", energy); // (6) imprimir consumo de energia em Joules

	return 0;
}