/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nnos vetores abaixo
 * Quando limitar o numero de pontos a serem usados, USAR SOMENTE OS 
 * PONTOS MAIS PROXIMOS
 */
clear
x=[-2 -1 0 1 2]'
// Quando y for uma funcao, cuidar com o sinal de trasnposta (')
y=exp(x)
// x para interpolar
X=0.5
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)
