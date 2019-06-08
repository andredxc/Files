#include <stdio.h>
#include <stdlib.h>

#define MATRIX_SIZE 3

int det(int A[MATRIX_SIZE][MATRIX_SIZE], int n)
{
    int Minor[MATRIX_SIZE][MATRIX_SIZE];
    int i,j,k,c1,c2;
    int determinant;
    int O=1;

    determinant = 0;
    if(n == 2)
    {
        determinant = A[0][0]*A[1][1]-A[0][1]*A[1][0];
        return determinant;
    }
    else
    {
        for(i = 0 ; i < n ; i++)
        {
            c1 = 0, c2 = 0;
            for(j = 0 ; j < n ; j++)
            {
                for(k = 0 ; k < n ; k++)
                {
                    if(j != 0 && k != i)
                    {
                        Minor[c1][c2] = A[j][k];
                        c2++;
                        if(c2>n-2)
                        {
                            c1++;
                            c2=0;
                        }
                    }
                }
            }
            determinant = determinant + O*(A[0][i]*det(Minor,n-1));
            O=-1*O;
        }
    }
    return determinant;
}

int main()
{
    //MATRIX_SIZE 3, det=18
    int A[MATRIX_SIZE][MATRIX_SIZE] = {
        {-2, 2, -3},
        {-1, 1, 3},
        {2, 0, -1}
    };
    // B, Det = 49
    int B[MATRIX_SIZE][MATRIX_SIZE] = {
        {2, -3, 1},
        {2, 0, -1},
        {1, 4, 5}
    };
    // C, Det = -15
    int C[MATRIX_SIZE][MATRIX_SIZE] = {
        {1, 3, 2},
        {-3, -1, -3},
        {2, 3, 1}
    };
    // D, Det = -40
    int D[MATRIX_SIZE][MATRIX_SIZE] = {
        {-5, 0, -1},
        {1, 2, -1},
        {-3, 4, 1}
    };



    //MATRIX_SIZE 5, det=2480
    /*
    int A[MATRIX_SIZE][MATRIX_SIZE] = {
        {0, 6, -2, -1, 5},
        {0, 0, 0, -9, -7},
        {0, 15, 35, 0, 0},
        {0, -1, -11, -2, 1},
        {-2, -2, 3, 0, -2}
    };
    */
    int n,res, i;
    n=MATRIX_SIZE;

    for(i = 0; i < 200; i++){
        switch(i%4){
            case 0:
                res = det(A,n);
                break;
            case 1:
                res = det(B,n);
                break;
            case 2:
                res = det(C,n);
                break;
            case 3:
                res = det(D,n);
                break;
        }
    }

    return res;
}
