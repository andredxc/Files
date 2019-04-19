A = [1.000001 2 3; 4 5 6; 7 8 9]

x = [1; 2; 5]

b1 = A*x

b2 = b1 + [10^(-8); 0; 0]

x1 = resolve(A, b1)
x2 = resolve(A, b2)

erro_entrada = norm(b1-b2)/norm(b1)
erro_saida = norm(x1-x2)/norm(x1)

kappa = norm(A,%inf)*norm(inv(A),%inf)

