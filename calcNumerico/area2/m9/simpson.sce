/*
    Simpson M9
    n -> numero de intervalos 
    h -> comprimento do intervalo
    a -> intervalo inferior
    b -> intervalo superior
*/ 
function y = f1(x)
    y = exp(x)
endfunction

function y = f2(x)
    y = sin(x + 19)
endfunction

function y = f3(x)
    y = cos(x) + cos(3*x)
endfunction

function y = f4(x)
    y = cos(4*x + 5)
endfunction

a = 0
b = 3
//n = 1
//h = (b - a)/n
h = 0.5
n = (b - a)/h
f = f2

x = linspace(a, b, n+1)

S = 0
for i = 1:n
    x1 = x(i)
    x2 = x1 + h/2
    x3 = x(i+1)
    
    A1 = 1/6
    A2 = 4/6
    A3 = 1/6
    dS = (A1*f(x1) + A2*f(x2) + A3*f(x3))*h
    S = S + dS
end

disp(S)



