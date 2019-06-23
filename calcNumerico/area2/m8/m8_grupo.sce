/* Q1 - Encontre a reta y=a_1+a_2 x que melhor se ajusta aos pontos com coordenadas x=[0,0.2,0.4,0.6,0.8,1] e y=sin(x+5). Forneça como respostas o coeficente a_1. */
//Coeficiente A = (1) --- B = (2)

clear
x=[0 0.2 0.4 0.6 0.8 1]';
y=sin(x+5);
n=size(x,1);

M=[n        sum(x)
    sum(x)  sum(x.^2)]

b=[sum(y)
    sum(x.*y)]

a=inv(M)*b

disp(a(1))

/*Q2 - Dados os pontos x=0:0.2:1 e y=cos(x+20), encontre a reta y=ax+b que melhor se ajusta a esses pontos. Forneça como resposta o coeficiente a? */
//Coeficiente A = (2) --- B = (1)
clear
x=[0:0.2:1]';
y=cos(x+20);
n=size(x,1);

M=[n        sum(x)
    sum(x)  sum(x.^2)]

b=[sum(y)
    sum(x.*y)]

a=inv(M)*b;

disp(a(2))

/*Q3 - Dados os pontos x=1:0.5:12 e y=3*sin(x+20)+x^2, encontre o polinômio de grau 2 que melhor se ajusta a esses pontos. Forneça como resposta o coeficiente de x^2. */

clear
x=1:0.5:12;
y=3*sin(x+20)+x^2;
n=size(x,1);

p=2;
for i=1:p+1
    for j=1:p+1
        M(i,j)=sum(x.^(i+j-2))
    end
end
for i=1:p+1
    b(i)=sum(y.*x.^(i-1))
end

a=inv(M)*b;

//coeficiente vai ser a ordem do polinomio, (1)x0 (2)x1 (3)x2
disp(a(3))


/*Q4 - Dados os pontos x=1:0.5:12 e y=11*sin(x)+x^2, encontre a parábola p(x) que que melhor se ajusta a esses pontos. Forneça como resposta p(3.14). */

clear
x=1:0.5:12;
y=11*sin(x)+x^2;
n=size(x,1);

p=2;
for i=1:p+1
    for j=1:p+1
        M(i,j)=sum(x.^(i+j-2))
    end
end
for i=1:p+1
    b(i)=sum(y.*x.^(i-1))
end

a=inv(M)*b

disp(a(1)+a(2)*3.14 + a(3)*3.14^2)

/*Q5 - Dados os pontos x=1:0.1:4 e y=sin(20+1/x), encontre o polinômio p(x) de grau 3 que melhor se ajusta a esses pontos. Calcule p(2.1). */

clear
x=1:0.1:4;
y=sin(20+1./x);
n=size(x,1);

p=3;
for i=1:p+1
    for j=1:p+1
        M(i,j)=sum(x.^(i+j-2))
    end
end
for i=1:p+1
    b(i)=sum(y.*x.^(i-1))
end

a=inv(M)*b;

disp(a(1)+a(2)*2.1 + a(3)*2.1^2 + a(4)*2.1^3)

/*
Q6 - Qual reta no formato y=kx melhor se ajusta aos pontos com coordenadas x=-2:0.1:2 e y=ex p(x/12)-1? Forneça como resposta k.
*/

x=[-2:0.1:2]'
y=exp(x/12)-1
A=[x^1]
k=(A'*A)\(A'*y)

disp(k)

/*
Q7 - Qual parábola do tipo y=a+bx^2 melhor se ajusta aos pontos com coordenadas x=0:0.1:2.5 e y=cos(x)+19. Forneça o coeficiente b.
*/

//a+bx^2
clear
x=0:0.1:2.5
y=cos(x)+19;
n=size(x,1);
p=2;
M=[sum(x.^0)   sum(x.^2)
   sum(x.^2)   sum(x.^4)]
b=[sum(y)
   sum(y.*x.^2)]
a=inv(M)*b;

disp(a(2))

/*
Q8 - Qual parábola do tipo y(x)=a+bx^2 melhor se ajusta aos pontos com coordenadas x=0:0.1:2.5 e y=cos(x)+8. Forneça y(1).
*/

//a+bx^2
clear
x=0:0.1:2.5
y=cos(x)+8;
n=size(x,1);
p=2;
M=[sum(x.^0)   sum(x.^2)
   sum(x.^2)   sum(x.^4)]
b=[sum(y)
   sum(y.*x.^2)]
a=inv(M)*b;

disp(a(1)+a(2)*1^2) //ou só a(1) + a(2)
