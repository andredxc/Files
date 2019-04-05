function y = f5(x)
    y = exp(x) - (x^2)/2
endfunction

function y = f7(x)
    y = x^4 - 3 + x
endfunction

function y = f8(x)
    y = 3*x^4 - x^5 + x + 14
endfunction

a = -10
b = 10
f = f8

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


