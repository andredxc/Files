clear
/**
 * Para encontrar pesos wi (ou Ai) da quadratura
 * I = w1*f(x1) + ... + wn*f(xn) com o menor error possivel
 *
 * vetor_nodes: vetor x de nos
 * lim_inicial: limite inicial da integral
 * lim_final: limite final da integral
 * 
 * w: vetor de pesos (retorno)
 */
function w=pesos(vetor_nodes, lim_inicial, lim_final)
    len_nodes = length(vetor_nodes);
    
    // Monta matriz A
    for i=1:len_nodes
        for j=1:len_nodes
            if (i == 1) then
                A(i,j) = i; // 1a linha so' tem 1s
            else
                A(i,j) = vetor_nodes(j)^(i-1);
            end    
        end
    end
    //disp('A:')
    disp(A)
    
    // Monta matriz resultado b
    for i=1:len_nodes
        B(i) = (lim_final^i - lim_inicial^i)/i;
    end
    //disp('B:')
    //disp(B)
    
    // Obtem pesos
    w=inv(A)*B;
endfunction

disp("Questão 6");
disp(pesos([0.1,0.8,1],0,1)); //pegar o valor pedido na questão. Valores são A1,A2, ...
disp("---------");

disp("Questão 7");
disp(pesos([0.1,0.7,1],0,1)); //pegar o valor pedido na questão. Valores são A1 ou w1,A2 ou w2, ...
disp("---------");

disp("Questão 8");
disp(pesos([0,3/5,5/5,2],0,2)); //pegar o valor pedido na questão.
disp("---------");

disp("Questão 9");
disp(pesos([0,6/5,8/5,2],0,2)); //pegar o valor pedido na questão.
disp("---------");

disp("Questão 10");
disp(norm(pesos([0,6/5,8/5,2],0,2))); //pegar o valor pedido na questão.
disp("---------");
