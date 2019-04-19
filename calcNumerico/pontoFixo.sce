function y = f(x)
    y = x
endfunction

function y  = g(x)
    y = sin(7*x)
endfunction

function y = h(x)
    y = x^8 - 6*x^4 - 3*x + 2
endfunction

// Plot
x = -2:0.1:2
clf
plot(x, f(x), 'r.-'); xgrid
plot(x, h(x), 'b.-')

// Ponto fixo
x = 1
for j = 1:200
    x = g(x)
//    disp(x, 'Current value')
    disp(['f(x) = ' f(x)])
end


