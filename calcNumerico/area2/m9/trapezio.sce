/*
    Trapezio M9
    n -> numero de intervalos 
    h -> comprimento do intervalo
    a -> intervalo inferior
    b -> intervalo superior
    
    Erro na ordem O(n^2) ou O(h^2) com n sendo multiplicado e h sendo 
    dividido
    
    No vídeo aparece que a cada vez que o numero de intervalos dobra o 
    erro cai 4 vezes, certo?
*/ 
clear
function y = f1(x)
    y = cos(7*x)
endfunction

a = 0
b = 1/7
n = 3
h = (b - a)/n   // n numero de intervalos
//h = 0.0625
//n = (b - a)/h
f = f1

x = linspace(a, b, n+1)

S = 0
for i = 1:n
    x1 = x(i)
    x2 = x(i+1)
    
    A1 = 1/2
    A2 = 1/2
    dS = (A1*f(x1) + A2*f(x2))*h
    S = S + dS
end

disp(S)
