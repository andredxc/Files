function y = f(x)
    y = x^(1/3)
endfunction

function y = fl(x)
    y = 1/(3*x^(2/3))
endfunction

function y = g(x)
    y = exp(x^2)
endfunction

function y = gl(x)
    y = 2*exp(x^2)*x
endfunction

function y = h(x)
    y = cos(x)
endfunction

function y = hl(x)
    y = -sin(x)
endfunction

x = 1
func = h(x)
derivative = hl(x)

k = abs(x*func(x)/derivative(x))
disp(k)
disp(k*10^(-4))
return



A = [1.000001 2 3; 4 5 6; 7 8 9]

x = [1; 2; 5]

b1 = A*x

b2 = b1 + [10^(-8); 0; 0]

x1 = resolve(A, b1)
x2 = resolve(A, b2)-

erro_entrada = norm(b1-b2)/norm(b1)
erro_saida = norm(x1-x2)/norm(x1)

kappa = norm(A,%inf)*norm(inv(A),%inf)

