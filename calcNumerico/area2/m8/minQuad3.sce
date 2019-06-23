// Para o formato kx
//clear
//x=[0:0.1:1]'
//y=sin(x)
//A=[x.^1]
//k=(A'*A)\(A'*y)
//disp(k)
//return

// Para o formato a + bx^2
//x = [0:0.1:1]'
//y = cos(x)
//M=[sum(x.^0)   sum(x.^2)
//   sum(x.^2)   sum(x.^4)]
//b=[sum(y)
//   sum(y.*x.^2)]
//a=inv(M)*b;
//disp(a)
//return

clear
x = [0 1 2 3 5 7 8 10]'
y = [8 5 4 2 1 2 4 7]'
n = size(x, 1)

p = 3
for i = 1:p+1
    for j = 1:p+1
        M(i,j) = sum(x.^(i+j-2))
    end
end

for i = 1:p+1
    b(i) = sum(y.*x.^(i-1))
end

a = inv(M)*b
disp(a)

// Calculo do polinomio
if p == 2 then
    u = a(1) + a(2)*x.^1 + a(3)*x.^2
elseif p == 3 then
    u = a(1) + a(2)*x.^1 + a(3)*x.^2 + a(4)*x.^3
end



// Grafico
XX = 0:0.1:10
YY = 0
residuo = 0
for i = 1:p+1
    YY = YY + a(i)*XX.^(i-1)
    residuo = residuo + a(i)*x.^(i-1)
end
residuo = residuo - y

//disp(residuo)

plot(XX, YY, 'b')
plot(x, y, 'r*'); xgrid

// 
