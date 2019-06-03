function S = rieman(a, b, n)
    
    f = f2
//    h = (b - a)/n   // n numero de intervalos
    h = 0.0025
    n = (b - a)/h
    x = linspace(a, b, n+1)

    S = 0
    for i = 1:n
        x1 = x(i)
        
        A1 = 1
        dS = (A1*f(x1))*h
        S = S + dS
    end
endfunction

function y = f1(x)
    y = exp(x)
endfunction

function y = f2(x)
    y = 1/(5*x)
endfunction

        
        
