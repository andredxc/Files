// Numero de condicionamento da funcao (em x = tanto)
    // Colocar f(x)
    // Calcular fl(x) derivada
    // Trocar o valor de x

function y = f(x)
    y = cos(2*x+1)
endfunction

function y = fl(x)
    y = -2*sin(2*x+1)
endfunction

function y = f2(x)
    y = exp(x)
endfunction

function y = f2l(x)
    y = exp(x)
endfunction

function y = f3(x)
    y = sin(x)
endfunction

function y = f3l(x)
    y = cos(x)
endfunction

function y = f4(x)
    y = sin(4*x)
endfunction

function y = f4l(x)
    y = 4*cos(4*x)
endfunction


// ---------------------------------------
x = 10

//k = abs(x*derivative(x)/func(x))
k = abs(x*f4l(x)/f4(x))

//k = abs(x.*f2(x)./f2l(x))
disp(k)
return

// Outra coisa nada a ver -----------------------------------------------

A = [1.000001 2 3; 4 5 6; 7 8 9]

x = [1; 2; 5]

b1 = A*x

b2 = b1 + [10^(-8); 0; 0]

x1 = resolve(A, b1)
x2 = resolve(A, b2)

erro_entrada = norm(b1-b2)/norm(b1)
erro_saida = norm(x1-x2)/norm(x1)

kappa = norm(A,%inf)*norm(inv(A),%inf)

