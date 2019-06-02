function y = f(t, u)
    y = sin(u + t)
endfunction

function [ultimo] = euler(N)
    
    cor = 'ro-'
    u(1) = 2    //CI
    t(1) = 0
    T = 3   //tempo final
    h = (T - t(1))/N
    
    for n = 1:N
        t(n+1) = t(n) + h
        u(n+1) = u(n) + h*f(t(n), u(n))
    end
    
    ultimo = u(N+1)
    plot(t, u, cor)
    xgrid

endfunction
