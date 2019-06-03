function S = trapezio(a, b, n)
    
    f = f2
    h = (b - a)/n   // n numero de intervalos
//    h = 0.5
//    n = (b - a)/h
    h = 0.1
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
endfunction

function y = f1(x)
    y = exp(x)
endfunction

function y = f2(x)
    y = cos(x/5)
endfunction

function y = f3(x)
    y = x^3 - 3*x
endfunction
        
        
