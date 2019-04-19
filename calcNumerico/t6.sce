// Questao 8
A8 = [2 1 0 0 0 0 0 0
     1 2 1 0 0 0 0 0
     0 1 2 1 0 0 0 0
     0 0 1 2 1 0 0 0
     0 0 0 1 2 1 0 0
     0 0 0 0 1 2 1 0
     0 0 0 0 0 1 2 1
     0 0 0 0 0 0 1 2]

b8 = [1 1 1 1 1 1 1 1]'
x18 = [0 0 0 0 0 0 0 0]'

//[x8, deltax8] = gauss_seidel(A8, b8, x18, 10^(-4), 25)
//disp(norm(x8,%inf))

// Questao 9
A9 = A8
b9 = b8
x19 = x18

[x9, deltax9] = jacobi(A9, b9, x19, 10^(-3), 100)
disp(norm(b9-A9*x9, 2)) // Norma 2 do residuo

// Questao 10
A10 = A9
b10 = b9
x110 = x19

//[x10, deltax10] = gauss_seidel_diff(A10, b10, x110, 10^(-20), 240)

