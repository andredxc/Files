Q1 - Encontre os coeficientes [c_1, c_2, c_3] do método de passo múltiplo u_{n+1}= u_n + h [c_1 f_n + c_2 f_{n-1}+c_3 f_{n-2}]. Forneça como resposta c_1.

x(1) = 0; // 0 e' do c1*fn+0
x(2) = -1; // -1 e' do c2*fn-1
x(3) = -2; // -2 e' do c3*fn-2

b(1) = 1;
b(2) = 1/2;
b(3) = 1/3;

for i=1:3
    M(1,i) = 1;
    M(2,i) = x(i);
    M(3,i) = x(i)^2;
end

c = inv(M)*b;
S = c(1)^2 + c(2)^2 + c(3)^2;
disp(c(1))


Q2 - Encontre os coeficientes [c_1, c_2, c_3] do método de passo múltiplo u_{n+1}= u_n + h [c_1 f_{n+1} + c_2 f_{n-1}+c_3 f_{n-2}]. Forneça como resposta c_2.

clear
x(1) = 1; // 1 e' do c1*fn+1
x(2) = -1; // -1 e' do c2*fn-1
x(3) = -2; // -2 e' do c3*fn-2

b(1) = 1;
b(2) = 1/2;
b(3) = 1/3;

for i=1:3
    M(1,i) = 1;
    M(2,i) = x(i);
    M(3,i) = x(i)^2;
end

c = inv(M)*b;
S = c(1)^2 + c(2)^2 + c(3)^2;

disp(c(2))

Q3 - Encontre os coeficientes [c_1, c_2, c_3] do método de passo múltiplo u_{n+1}= u_n + h [c_1 f_{n+1} + c_2 f_{n-1}+c_3 f_{n-2}]. Forneça como resposta c_3.

clear
x(1) = 1; // 1 e' do c1*fn+1
x(2) = -1; // -1 e' do c2*fn-1
x(3) = -2; // -2 e' do c3*fn-2

b(1) = 1;
b(2) = 1/2;
b(3) = 1/3;

for i=1:3
    M(1,i) = 1;
    M(2,i) = x(i);
    M(3,i) = x(i)^2;
end

c = inv(M)*b;
S = c(1)^2 + c(2)^2 + c(3)^2;

disp(c(3))


Q4 - Encontre os coeficientes [c_1, c_2, c_3] do método de passo múltiplo u_{n+1}= u_n + h [c_1 f_{n+1} + c_2 f_{n-1}+c_3 f_{n-2}]. Forneça como resposta \|c\|_2.


clear
x(1) = 1; // 1 e' do c1*fn+1
x(2) = -1; // -1 e' do c2*fn-1
x(3) = -2; // -2 e' do c3*fn-2

b(1) = 1;
b(2) = 1/2;
b(3) = 1/3;

for i=1:3
    M(1,i) = 1;
    M(2,i) = x(i);
    M(3,i) = x(i)^2;
end

c = inv(M)*b;
S = c(1)^2 + c(2)^2 + c(3)^2;

disp(norm(c))



Q5 - Encontre os coeficientes [c_1, c_2, c_3] do método de passo múltiplo u_{n+1}= u_{n-1} + h [c_1 f_{n+1} + c_2 f_{n}+c_3 f_{n-1}]. Forneça como resposta c_1.

clear
x(1) = 1;
x(2) = 0;
x(3) = -1;

b(1) = 2;
b(2) = 0;
b(3) = 2/3;

for i=1:3
    M(1,i)=1;
    M(2,i)=x(i);
    M(3,i)=x(i)^2;
end

c = inv(M)*b;
S = c(1)^2 + c(2)^2 + c(3)^2;

olha_ai = c(1)/2
disp(olha_ai)

Q6 - Encontre os coeficientes [c_1, c_2, c_3] do método de passo múltiplo u_{n+1}= u_{n-1} + h [c_1 f_{n+1} + c_2 f_{n}+c_3 f_{n-1}]. Forneça como resposta max(c).

clear
x(1) = 1;
x(2) = 0;
x(3) = -1;

b(1) = 2;
b(2) = 0;
b(3) = 2/3;

for i=1:3
    M(1,i)=1;
    M(2,i)=x(i);
    M(3,i)=x(i)^2;
end

c = inv(M)*b;
S = c(1)^2 + c(2)^2 + c(3)^2;

olha_ai = max(c)/2
disp(olha_ai)
