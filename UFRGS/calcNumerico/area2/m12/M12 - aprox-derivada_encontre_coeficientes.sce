// Os x sao os pontos onde a f(x) e' calculada 
// Fx(xn) = [C1Fn-1 + C2Fn+0 + C3Fn+1] / H
//               ^     ^   ^        ^


//M12-q7-q8
n = 2; // indice do coeficiente que multiplica o Fn
xc = 0.0 // Numero que multiplica h e soma com xn
x(1) = -1;
x(2) = 0 
x(3) = 2;
//x(4) = ...

//M12-q9-q10
//n = 1; // indice do coeficiente que multiplica o Fn
//xc = 0
//x(1) = 0;
//x(2) = x(n)+1/3;
//x(3) = 2;
//x(4) = ...

// Daqui pra baixo nao muda pra esse padrao de aprox de derivada
b(1) = 0;
b(2) = 1;
b(3) = 2*xc;
// b(4)=3*x(n)^2

for i=1:3
    M(1,i) = 1;
    M(2,i) = x(i);
    M(3,i) = x(i)^2;
//    M(4,i)=x(i)^3
end

c = inv(M)*b;
S = c(1)^2 + c(2)^2 + c(3)^2; // +c(4)^2

disp(c)

//disp(c(1)); 
//disp(c(2));
//disp(c(1));
//disp(c(2));
