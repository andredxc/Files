format(25)

x = [3 4]'
y = 3 ./ x

n = length(x)
plot(x, y, 'ro-'); xgrid

// Matriz de Vandermonde
for i = 1:n
        V(i,j) = x(i)^(j - 1)
    end
end

//Interpolação
X = 3 + (28 / 100) // Ponto para fazer a intepolação

a = inv(V) * y
p = 0
for k = 1:n
    p = p + a(k) * X.^(k - 1)
end

plot(X, p, 'b.-'); xgrid
disp(p, "P = ")


