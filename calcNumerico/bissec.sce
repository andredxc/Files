// Encontrar a raiz de funcoes
    // Colocar f(x)
    // Encontrar os valores limite do intervalo que contem a raiz desejada
        // Por isso o plot
// Encontrar pontos de intersecao
    // Igualar as duas raizes, uma das variaveis vai sumir
    // Procurar raizes da igualdade resultante


function y = f5(x)
    y = exp(x) - (x^2)/2
endfunction

function y = f7(x)
    y = x^4 - 3 + x
endfunction

function y = f8(x)
    y = 3*x^4 - x^5 + x + 14
endfunction

function z = f9(x)
    z = sqrt(5*x) - exp(-x^2)
endfunction

// Achando o zero da funcao
a = -10
b = 10
f = f9

x = -10:0.1:10
clf
plot(x, f(x))
xgrid

for i = 1:100
    m = (a + b)/2
    if (f(a)*f(m) < 0) then
        b = m
    else
        a = m
    end
    disp([a, b])
end

disp([m])

// Achando o ponto de interseccao entre funcoes
a = -10
b = 10
f = f9

x = -10:0.1:10
clf
plot(x, f(x))
xgrid

for i = 1:100
    m = (a + b)/2
    if (f(a)*f(m) < 0) then
        b = m
    else
        a = m
    end
    disp([a, b])
end

disp([m])
