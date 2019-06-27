/*
    Heun
    
    ex.
    Seja u'=ut com u(1)=0.1. Aproxime u(2) usando h=0.1 e o método de 
    Heun.
    
    N = qualquer coisa quando h > 0 no codigo

*/

clear
function y = f1(t, u)
    y = sin(u + t)
endfunction
    
N = 10
uInicial = 15
tInicial = 3
tFinal = 4
h = 0

f = f1
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

disp(u)
