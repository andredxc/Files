/*
    Lk(Xj) = 1, se k == j
           = 0, se k != j
*/

function y = L(X, x, k)
    
    n = size(x, 1)
    y = 1
    for j = 1:n
        if(k <> j)
            y = y.*(X - x(j))./(x(k) - x(j))
        end
    end
endfunction

x = [1 3 4 6]'
y = sin(x)

n = length(x)

plot(x, y, 'ro-'), xgrid

X = 0.5:0.1:6.5
p = 0
for k = 1:n
    p = p + y(k)*L(X, x, k)
end
plot(X, p, 'b.-')




