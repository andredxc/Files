function y = f0(t, u)
    y = u*t
endfunction

function y = f0t(t, u)
    y = (u*t)*t + u
endfunction

function y = f0tt(t, u)
    y = ((u*t)*t + u)*t + (u*t) + (u*t)
endfunction

function [u] = taylor(N, uInicial, tInicial, tFinal, h)
    
    f = f0
    ft = f0t
    ftt = f0tt
    
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
        F = f(t(n), u(n))
        Ft = ft(t(n), u(n))
        Ftt = ftt(t(n), u(n))
        
        // Ordem 2
        u(n+1) = u(n) + h*F + (h^2/2)*Ft + (h^3/6)*Ft
        // Se fosse taylor de ordem 3
        u(n+1) = u(n+1) + (h^3/6)*Ftt
    end
    
    ultimo = u(N+1)
    plot(t, u, cor)
    xgrid

endfunction

