//MEXER SÓ NOS VALORES COM //ALTERAR
clear
x=[1 2 3 4 5]' //ALTERAR // 4 pontos -> curva com 4-1 pontos (tinha 4 pontos, botei 2 do meio pq pediu)
y=[0 2 3 2 1]' //ALTERAR
n=length(x); // size(x,1)
//plot(x,y,'ro-'),xgrid // Faz grafico dos pontos
// Monta a matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)= x(i)^(j-1);
    end
end
// a: coefiecientes do polinomio que da forma ao polinomio de interpolacao
a = inv(V)*y //  ao inves de resolver por LU
p = 0// init no polinomio p
X = 0.97 //ALTERAR // Valor de x em 1 ponto pra interpolar
//X = 5:0.1:8 // 0.5, 0.6, ..., 6.5
for k=1:n
  p = p + a(k)*X.^(k-1); // X.: todos pontos
end
// grafico do polinomio de grau n-1 que passa por todos pontos de x
//plot(X,p,'b.-') 
// numero_condicionamento = norm(V,1)*norm(inv(V),1)
// >>>Valor no ponto de interpoolacao e' o p<<<
disp(p)
