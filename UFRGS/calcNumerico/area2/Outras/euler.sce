function y = f0(t, u)
    y = sin(u + t)
endfunction

function y = f1(t, u)
    y = u*t
endfunction

function y = fm1(t, u)
    y = 10 - t^2
endfunction

function y = fm2(t, u)
    y = 12 - t^2
endfunction

function y = fm5(t, u)
    y = sin(u + t + 5)
endfunction

function y = fm6(t, u)
    y = cos(u + 11)
endfunction

function [u] = euler(N, uInicial, tInicial, tFinal, h)
    
    f = fm6
    cor = 'ro-'
    u(1) = uInicial
    t(1) = tInicial
    T = tFinal
    
    if h > 0 then
        N = (T - t(1))/h
    else
        h = (T - t(1))/N
    end
    
    for n = 1:N
        t(n+1) = t(n) + h
        u(n+1) = u(n) + h*f(t(n), u(n))
    end
    
    ultimo = u(N+1)
    plot(t, u, cor)
    xgrid

endfunction
