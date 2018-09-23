function y = encode_ham(bits, k, n)

% bits -> array containing binary word
% k -> size of the array
% n -> k + p (word length + parity bits)
% y -> encoded word

% Parameter check
p = n - k;
if  pow(p) > n
    fprintf('p exceds the limit (2^p <= n)');
    return;
end
encoded = zeros([1, n]);

% AJUSTAR PARA P=0
% Compute parities
for i = 1:p
   
    encoded(pow(i)) = 
    
end

j = 1;
for i = 1:length(endoded)

    if i <= pow(p) && mod(log2(i), 1) == 0 
        % Compute parity
        sum = sum(bits(p^1:p:length(bits)));
    else
        % Copy number from input
        encoded(i) = bits(j);
        j = j + 1;
    end

end


