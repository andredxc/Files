/**
 * Coloca em a os coeficientes do polinomio de GRAU ESPECIFICADO EM P que
 * melhor se ajuste aos pares x,y.
 * PARA RETAS     -> p=1
 * PARA PARABOLAS -> p=2...
 */
clear
p = 1 //q1 Ordem do polinomio a ser gerado
p = 1 //q2 Ordem do polinomio a ser gerado
p = 2 //q3 Ordem do polinomio a ser gerado
p = 2 //q4 Ordem do polinomio a ser gerado
p = 3 //q5 Ordem do polinomio a ser gerado

// Pares (x,y)
//x = [0:0.2:1]' //q1 Coordenada x transposta
//x = [0:0.2:1]' //q2 Coordenada x transposta
//x = [1:0.5:12]' //q3 Coordenada x transposta
//x = [1:0.5:12]' //q4 Coordenada x transposta
x = [1:0.5:12]' //q5 Coordenada x transposta

//y = sin(x+5) //q1 Coordenada y transposta
//y = cos(x+6) //q2 Coordenada y transposta
//y = 3*sin(x+10)+x^2 //q3 Coordenada y transposta
//y = 10*sin(x)+x^2 //q4 Coordenada y transposta
y = sin(8+1./x) //q5 Coordenada y transposta

n = size(x,1)
//plot(x,y,'ro-'),xgrid // Plota grafico dos pontos

// Monta matriz simetrica de minimos quadrados
for i=1:p+1 //for (i=1; i<= p+1; i++)
    for j=1:p+1
       M(i,j) = sum(x.^(i+j-2)) // . elemento a elemento
end
// Monta matriz de resultado b
for i=1:p+1
    b(i) = sum(y.*x.^(i-1))
end
// Pegando os coeficientes do polinomio de ajuste
a = inv(M)*b;
// Monta polinomio para plotagem
XX      = 1:0.5:12 // Colocar os mesmos pontos passados por X, ou que pegue todos pontos de X pra deixar o grafico melhor
YY      = 0
residuo = 0
for i=1:p+1
    YY = YY+a(i)*XX.^(i-1); // Polinomio
    residuo = residuo+a(i)*x.^(i-1);
end
residuo = residuo - y;
//plot(XX,YY,'b-');xgrid
t=2;
f=(a(1,1)+a(2,1)*t) // ... +a(n,1)*t^n
//disp(a(1)); //questão 1
//disp(a(2)); //questão 2
//disp(a(3)); //questão 3
//disp(a(1)+(a(2)*3.14)+(a(3)*3.14^2))//questão 4 // Valor do polinomio de ajuste no ponto, polinomio
disp(a(1)+(a(2)*2.1)+(a(3)*2.1^2)+(a(4)*2.1^3))//questão 5 // Valor do polinomio de ajuste no ponto, polinomio
// YY = a(1) + a(2)*XX + a(2)*XX^2 ... a(n)*XX^n
