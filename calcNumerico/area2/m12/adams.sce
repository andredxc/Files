// Q1 - Encontre os coeficientes [c_1, c_2, c_3] do método de passo múltiplo u_{n+1}= u_n + h [c_1 f_n + c_2 f_{n-1}+c_3 f_{n-2}]. Forneça como resposta c_1.

x(1) = 1; // 0 e' do c1*fn+0
x(2) = 0; // -1 e' do c2*fn-1
x(3) = -1; // -2 e' do c3*fn-2
// x(4) = -3

// para u_n como o primeiro termo do lado direito
b(1) = 1;
b(2) = 1/2;
b(3) = 1/3;
// b(4) = 1/4;

// para u_{n-1} como o primeiro termo do lado direito
b(1) = 2;
b(2) = 0;
b(3) = 2/3;
// b(4) = 

for i=1:3
    M(1,i) = 1;
    M(2,i) = x(i);
    M(3,i) = x(i)^2;
    // M(4,i) = x(i)^3;
end

c = inv(M)*b;
S = c(1)^2 + c(2)^2 + c(3)^2;

// Para u_{n-1} como o primeiro termo do lado direito, dividir os c por dois
//ex: quando pede max(c), fazer max(c)/2
//ex: quando pede norm(c), fazer norm(c) SEM DIVIDIR MESMO
//ex: quando pede c(1) ou c(2) ..., fazer c(1)/2

disp(c(1));
disp(c(2));
disp(c(3));
