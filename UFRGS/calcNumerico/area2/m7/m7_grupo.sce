clear
/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nnos vetores abaixo
 */
x=[-1 0 1 2]'
y=[1 2 3 2]'
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y

X=0.01 // x para interpolar
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)

// --------------------------------------------- Q2
clear
/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nos vetores abaixo
 */
x=[0 1 2]'
y=[1 2 3]'
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y

X=0.05 // x para interpolar
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)

// --------------------------------------------- Q3

clear
/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nos vetores abaixo
 */
x=[0 1]'
y=[1 3]'
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y

X=0.25 // x para interpolar
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)

// --------------------------------------------- Q4
clear
/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nos vetores abaixo
 */
x=[1 2 3 4 5]'
y=[0 2 3 2 1]'
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y

X=0.97 // x para interpolar
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)

// --------------------------------------------- Q5
clear
/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nos vetores abaixo
 */
x=[74:77]'
y=cos(x)
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y

X=74+1.5 // x para interpolar
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)

// --------------------------------------------- Q6
clear
/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nos vetores abaixo
 */
x=[93:96]'
y=cos(x)
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y

X=93+1.6 // x para interpolar
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)

// --------------------------------------------- Q7
clear
/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nos vetores abaixo
 */
x=[1 2 3 4]'
y=3./x
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y

X=2+6/100 // x para interpolar
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)

// --------------------------------------------- Q8
clear
/**
 * Se diz pra extrapolar/interpolar em menos pontos,
 * só meter menos pontos nos vetores abaixo
 */
x=[3 4]'
y=3./x
n=length(x)
plot(x,y,'ro-'),xgrid

// Monta matriz de Vandermonde
for i=1:n
    for j=1:n
        V(i,j)=x(i)^(j-1)
    end
end

a=inv(V)*y

X=3+89/100 // x para interpolar
// Caso desejar descobrir apenas um ponto, X=valor que deseja interpolar
// Chamar "p" no scilab ao final da execucao
p=0
for k=1:n
    p=p+a(k)*X.^(k-1) //Monta o polinomio
end
plot(X,p,'b.-')

disp(p)
