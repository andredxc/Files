/*
    Metodo de Euler
    
    ex.
    Seja u'=ut com u(1)=0.1. Aproxime u(2) usando h=0.1 e o método de 
    Euler.
    
    N = 0
    uInicial = 0.1
    tInicial = 1
    tFinal = 2
    h = 0.1
    y = -ut
    
    R: 0.3860892
*/


clear
function y = f1(t, u)
    y = sin(t + 1)
endfunction
    
N = 100
uInicial = 13
tInicial = 13
tFinal = 17
h = 0.4
    
f = f1
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

disp(u)
