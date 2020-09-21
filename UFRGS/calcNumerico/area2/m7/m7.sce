clear
// Exercicio 1
//x = [-1 0 1 2]'
//y = [1 2 3 2]'
//X = 0.01
// Exercicio 2
//x = [0 1 2]'
//y = [1 2 3]'
//X = 0.69
// Exercicio 3
x = [0 1]'
y = [1 3]'
X = 0.54
// Exercicio 4
//x = [1 2 3 4 5]'
//y = [0 2 3 2 1]'
//X = 0.23

n = length(x)

plot(x, y, 'ro-'), xgrid

for i = 1:n
    for j = 1:n
        V(i,j) = x(i)^(j-1)
    end
end

a = inv(V)*y

p = 0
for k = 1:n
    p = p + a(k)*X^(k-1)
end

disp(p)

plot(x, p, 'b.-')

// = -0.7 + 2.51*x + - 1.08*x^2 + 0.11*x^3
