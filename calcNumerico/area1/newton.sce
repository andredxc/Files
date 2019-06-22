// EX 3
function y = f(x)
    y = exp(7*x) + exp(-x) + 7*x
endfunction

function y = fl(x)
    y = 7*exp(7*x) - exp(-x) + 7
endfunction

function y = fll(x)
    y = 49*exp(7*x) + exp(-x)
endfunction

// EX 4
function y = g(x)
    y = sin(x) - 1./x
endfunction

function y = gl(x)
    y = cos(x) + 1./x.^2
endfunction

// EX 5
function y = h(x)
    y = exp(2.*cos(x) - 1) - 1
endfunction

function y = hl(x)
    y = -2.*sin(x).*exp(2.*cos(x) - 1)
endfunction

// EX 6
function y = k(x)
    y = cos(sqrt(x.^2 + 1)) - sin(x)
endfunction

function y = kl(x)
    y = -x.*sin(sqrt(x.^2 + 1))./sqrt(x.^2 + 1) - cos(x)
endfunction

// EX 7
function y = u(x)
    y = exp(5.*x) - 26.*sqrt(x)
endfunction

function y = ul(x)
    y = 5.*exp(5.*x) - 13./sqrt(x)
endfunction

// EX 8
function y = i(x)
    y = x.^7 - 5.*x.^4 + 5
endfunction

function y = il(x)
    y = 7.*x.^6 - 20.*x.^3
endfunction

// Exercicio da prova
function y = f2(x)
    y = exp(2*cos(x)-1) - 1
endfunction
function y = f2l(x)
    y = -2.*sin(x).*exp(2.*cos(x)-1)
endfunction

func = f2
der = f2l

x = -10:0.1:10
clf
plot(x, func(x), 'r.-'); xgrid
plot(x, der(x), 'g.-')


x = -0.1
for n = 1:100
    x = x - func(x)/der (x)
    disp(x)
end
