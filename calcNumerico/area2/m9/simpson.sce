/*
    Simpson M9
    n -> numero de intervalos 
    h -> comprimento do intervalo
    a -> intervalo inferior
    b -> intervalo superior
    
        Erro na ordem O(n^4) ou O(h^4) com n sendo multiplicado e h sendo 
    dividido
*/ 
clear
function y = f1(x)
    y = sin(cos(2*x))
endfunction

a = 2
b = 3
n = 100
h = (b - a)/n
//h = 0.5
//n = (b - a)/h
f = f1

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



