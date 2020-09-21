// 
//Q1 - Encontre a reta y=a_1+a_2 x que melhor se ajusta aos pontos com coordenadas 
//x=[0,0.2,0.4,0.6,0.8,1] e y=sin(x+5). Forneça como respostas o coeficente a_1.

//Coeficiente A = (1) --- B = (2)

clear
x = [0:0.1:1]'
y = sin(x)
n = size(x,1)

M=[n        sum(x)
   sum(x)  sum(x.^2)]

b=[sum(y)
   sum(x.*y)]

a=inv(M)*b

// Gera um grafico
XX = 0:0.1:10
YY = a(1) + a(2)*XX
plot(XX, YY, 'b')
plot(x, y, 'r*'); xgrid

disp(a)
