function decoded = decode_ham(bits, k, n)

% bits -> array containing encoded binary word
% k -> size of the array
% n -> k + p (word length + parity bits)
% decoded -> decoded word

% Parameter check
p = n - k;
if p == 0
    decoded = bits;
    return
elseif  pow2(p-1) > n
    fprintf('p exceeds the limit (2^(p-1) <= n)\n');
    return;
end
decoded = uint8(zeros([1, k]));
parity_check = uint8(zeros([1, p]));
parity_bit_mat = zeros(p, floor(length(bits)/2));

% Recalculate parity and compare
for i = 0:(p-1)
   
    sum_acc = 0;
    parity_bit_list = uint8.empty();
   % Ignore parity bit
    if (bits(pow2(i) == 1))
            sum_acc = sum_acc - 1;
    end
    
    for j = pow2(i):2*pow2(i):length(bits)
        
        %fprintf('i = %d, j = %d\n', i, j);
        %fprintf('Somando indices: ');
        if (j+pow2(i)-1) > length(bits)
            sum_acc = sum_acc + sum(bits(uint8(j):uint8(length(bits))));
            parity_bit_list = [parity_bit_list uint8(j):uint8(length(bits))];
            %disp(uint8(j):uint8(length(bits)));
            %fprintf(' = %d\n', sum_acc);
        else
            sum_acc = sum_acc + sum(bits(uint8(j):uint8(j+pow2(i)-1)));
            parity_bit_list = [parity_bit_list uint8(j):uint8(j+pow2(i)-1)];
            %disp(uint8(j):uint8(j+pow2(i)-1));
            %fprintf(' = %d\n', sum_acc);
        end
    end
    
    fprintf('Sum for p = %d, is = %d (parity equals %d)\n', i, sum_acc, mod(sum_acc, 2));
    if bits(pow2(i)) ~= mod(sum_acc, 2)
        parity_check(i+1) = 1;
    else
        parity_check(i+1) = 0;
    end
    % Insert list into matrix
    parity_bit_mat(i+1, 1:length(parity_bit_list)) = parity_bit_list;
end

% Error correction
related_parity = uint8.empty();
intersec_mat = uint8.empty();
for i = 0:length(parity_check)-1

   if parity_check(i+1) == 1
       % Error detected
       related_parity = i+1;       
       for j = (i+1):length(parity_check)-1
           % Run through the parity matrix to find related parity indexes
           if parity_check(j+1) == 1
               related_parity = [related_parity j+1];
               % Check intersection between parity lists
               intersec_mat = [intersec_mat ];
               intersect(parity_bit_mat());
           else
               continue;
           end
       end
   end
end
