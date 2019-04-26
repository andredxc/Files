// Encontrar a raiz de funcoes
    // Colocar f(x)
    // Encontrar os valores limite do intervalo que contem a raiz desejada
        // Por isso o plot
    // Ir encurtando o intervalo para vizualizar a funcao melhor
// Encontrar pontos de intersecao
    // Igualar as duas raizes, uma das variaveis vai sumir
    // Procurar raizes da igualdade resultante

function y = f1(x)
    y = x^3 - abs(x) + 6
endfunction

function y = f2(x)
    y = cos(sqrt(x^2-1))
endfunction

function y = f3(x)
    y = x^7 - 9*x^4 + 9
endfunction

function y = f4(x)
    y = sin(exp(-x.^2)-x.^2)./(x-0.5)
endfunction

function y = f5(x)
    y = (x^3)/12 + x^2 - 1
endfunction

// Achando o zero da funcao
a = -1
b = 2
f = f5

x = a:0.01:b
clf
plot(x, f(x))
xgrid

// Cuidar com o numero de iteracoes
// Ex. x1 = (a+b)/2 entao x5 tem for entre 1:5
for i = 1:100
    m = (a + b)/2
    if (f(a)*f(m) < 0) then
        b = m
    else
        a = m
    end
    disp([i a b m])
end

