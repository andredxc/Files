/*
    Rieman M9
    n -> numero de intervalos 
    h -> comprimento do intervalo
    a -> intervalo inferior
    b -> intervalo superior
*/ 
function y = f1(x)
    y = exp(x)
endfunction

function y = f2(x)
    y = 1/(5*x)
endfunction

function y = f3(x)
    y = cos(2*x)
endfunction

a = 2
b = 3
n = 45

f = f3
h = (b - a)/n
// h = 0.0025
n = (b - a)/h
x = linspace(a, b, n+1)

S = 0
for i = 1:n
    x1 = x(i)
    
    A1 = 1
    dS = (A1*f(x1))*h
    S = S + dS
end

disp(S)



        
        
