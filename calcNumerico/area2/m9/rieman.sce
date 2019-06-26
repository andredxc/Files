/*
    Rieman M9
    n -> numero de intervalos 
    h -> comprimento do intervalo
    a -> intervalo inferior
    b -> intervalo superior
*/ 

function y = f3(x)
    y = x^2 + exp(x)
endfunction

a = 0
b = 2
//n = 100
//h = (b - a)/n

h = 0.0078125
n = (b - a)/h
f = f3
x = linspace(a, b, n+1)

S = 0
for i = 1:n
    x1 = x(i)
    
    A1 = 1
    dS = (A1*f(x1))*h
    S = S + dS
end

disp(S)



        
        
