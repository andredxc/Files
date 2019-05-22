x = [1 3 4 6]'
y = sin(x)

n = length(x)

plot(x, y, 'ro-'), xgrid

for i = 1:n
    for j = 1:n
        V(i,j) = x(i)^(j-1)
    end
end

a = inv(V)*y

X = 0.5:0.1:6.5
p = 0
for k = 1:n
    p = p + a(k)*X^(k-1)
end
plot(X, p, 'b.-')

// = -0.7 + 2.51*x + - 1.08*x^2 + 0.11*x^3
