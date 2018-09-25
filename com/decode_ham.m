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

% Recalculate parity and compare
for i = 0:(p-1)
   
    sum_acc = 0;
    for j = (pow2(i)+2*pow2(i)):2*pow2(i):length(bits)
        
        %fprintf('i = %d, j = %d\n', i, j);
        %fprintf('Somando indices: ');
        if (j+pow2(i)-1) > length(bits)
            sum_acc = sum_acc + sum(bits(uint8(j):uint8(length(bits))));
            %disp(uint8(j):uint8(length(encoded)));
            %fprintf(' = %d\n', sum_acc);
        else
            sum_acc = sum_acc + sum(bits(uint8(j):uint8(j+pow2(i)-1)));
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
end

% Error correction
for i = 0:length(parity_check)-1

   if parity_check(i+1) == 1
       % Error detected
       for j = 0:length(parity_check)-1
           
           if j ~= i && parity_check(j+1) == 1
               
           end
       end
   end
end
