function y = f(t, u)
    y = sin(u + t)
endfunction

function y = f2(t, u)
    y = u*t
endfunction

function y = fm3(t, u)
    y = 11 - t^2
endfunction

function y = fm4(t, u)
    y = 8 - t^2
endfunction

function y = fm7(t, u)
    y = cos(u + 10)
endfunction

function y = fm8(t, u)
    y = cos(u + t)
endfunction

function [u] = heun(N, uInicial, tInicial, tFinal, h)
    
    f = fm8
    cor = 'xo-'
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
        util = u(n) + h*f(t(n), u(n))
        F1 = f(t(n), u(n))
        F2 = f(t(n+1), util)
        u(n+1) = u(n) + (h/2)*(F1 + F2)
    end
    
    ultimo = u(N+1)
    plot(t, u, cor)
    xgrid

endfunction
