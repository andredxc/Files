#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "energia.h"

#define EXEC_PATH "./exemplo2"

int main(){

    rapl_init();

    // Inicializar coisas
    static char *argv[] = {EXEC_PATH, NULL};

    // Inicializacao da biblio
	start_rapl_sysfs();
    clock_t t = clock();

    // Chamar programinha
    pid_t pid = fork();
    if(pid == 0){
        // Processo filho
        execv(EXEC_PATH, argv);
        exit(0);
    }
    else{
        waitpid(pid, 0, 0);
    }
     
    // Finalizar coisas   
    t = clock() - t;
    double energy = end_rapl_sysfs();   // (5) Finalizar a contagem dos contadores de energia
    double tempo = ((double)t)/CLOCKS_PER_SEC; // transforma tempo para segundos
    printf("Tempo de execucao em segundos: %.5f\n", tempo);
    printf("Energia consumida em Joules:   %.5f\n", energy); // (6) imprimir consumo de energia em Joules

	return 0;
}