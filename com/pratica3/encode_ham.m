function encoded = encode_ham(bits, k, n)

% bits -> array containing binary word
% k -> size of the array
% n -> k + p (word length + parity bits)
% encoded -> encoded word

% Parameter check
p = n - k;
if p == 0
    encoded = bits;
    return
elseif  pow2(p-1) > n
    fprintf('p exceeds the limit (2^(p-1) <= n)\n');
    return;
end
encoded = uint8(zeros([1, n]));

% Copia os bits de entrada para o vetor encoded de saida
j = 1;
for i = 1:length(encoded)

    if i <= pow2(p-1) && mod(log2(i), 1) == 0 
        % Faz nada, gambiarra, vou mudar depois 
    else
        % Copia da entrada para a saida
        encoded(i) = bits(j);
        j = j + 1;
    end

end

% Computa a paridade
for i = 0:(p-1)
   
    sum_acc = 0;
    for j = pow2(i):2*pow2(i):length(encoded)
        
        %fprintf('i = %d, j = %d\n', i, j);
        %fprintf('Somando indices: ');
        if (j+pow2(i)-1) > length(encoded)
            sum_acc = sum_acc + sum(encoded(uint8(j):uint8(length(encoded))));
            %disp(uint8(j):uint8(length(encoded)));
            %fprintf(' = %d\n', sum_acc);
        else
            sum_acc = sum_acc + sum(encoded(uint8(j):uint8(j+pow2(i)-1)));
            %disp(uint8(j):uint8(j+pow2(i)-1));
            %fprintf(' = %d\n', sum_acc);
        end
    end
    fprintf('Sum for p = %d, is = %d (parity equals %d)\n', i, sum_acc, mod(sum_acc, 2));
    encoded(pow2(i)) = mod(sum_acc, 2);
end


