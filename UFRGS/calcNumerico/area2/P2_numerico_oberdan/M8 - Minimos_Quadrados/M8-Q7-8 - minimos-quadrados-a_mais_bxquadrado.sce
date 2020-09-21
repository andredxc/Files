//a+bx^2
clear
//x=0:0.1:2.5 //q7
x=0:0.1:2.5 //q8
//y=cos(x)+19; //q7
y=cos(x)+8; //q8
n=size(x,1);

p=2;
M=[sum(x.^0)   sum(x.^2)
   sum(x.^2)   sum(x.^4)]
   
b=[sum(y)
   sum(y.*x.^2)]
   
a=inv(M)*b;

XX=0:0.1:1; // aqui coloca o valor do ponto que ele pede
YY=a(1)+a(2)*XX^2;

//disp(a(2)) //q7
disp(a(1)+a(2)) //q8

//plot(XX,YY,'b')
//plot(x,y,'r*');xgrid
