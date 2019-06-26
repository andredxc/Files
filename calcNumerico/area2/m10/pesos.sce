/*
ex.
Sejam os nós x=[0, 0.6, 1]. Encontre os pesos A_i da quadratura 
I=A_1f(x_1)+A_2f(x_2)+A_3f(x_3) tal que o erro seja o menor possível 
para aproximar a integral de f no intervalo 0 a 1. 

R: [8/36, 25/36, 3/36]
*/

clear
vetor_nodes = [-0.5, 0, 0.5]
lim_inicial = -1
lim_final = 1
    
len_nodes = length(vetor_nodes)

// Monta matriz A
for i = 1:len_nodes
    for j = 1:len_nodes
        if i == 1 then
            A(i,j) = i  // Primeira linha so tem 1s
        else
            A(i,j) = vetor_nodes(j)^(i-1)
        end
    end
end

// Monta matriz resultado B
for i = 1:len_nodes
    B(i) = (lim_final^i - lim_inicial^i)/i
end

// Obtem pesos
w = inv(A)*B
disp(w)

