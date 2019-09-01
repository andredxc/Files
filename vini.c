# include <stdio.h>

int main(){

    float num;

    printf("Ind: ");
    scanf("%f", &num);

    if (num > 0.3 && num <= 0.4){
        printf("1\n");
    }
    else if(num > 0.4 && num <= 0.5){
        printf("2\n");
    }
    else if(num > 0.5){
        printf("3\n");
    }
    else{
        printf("NADA\n");
    }

    return 0;
}
