function y = ofdm(mod_i, mod_q)

% mod_i -> array das componentes I
% mod_q -> array das componentes Q

freq_spacing = (20/64)*power(10,6); % 20/64 MHz
starting_freq = 2.421*power(10,9); % 2.421 GHz
num_subcarriers = 48;
subcarriers = zeros([1,num_subcarriers]);

% Verifica os parametros
if length(mod_i) ~= length(mod_q)
    fprintf('Erro, os parametros mod_i e mod_q tem tamanhos diferentes\n');
    return;
elseif length(mod_i) ~= num_subcarriers
    fprintf('Erro, o tamanho dos parametros mod_i e mod_q excede o numero de subportadoras')
    return;
end

% Modula as components nas subportadoras
count = 1;
for i = 1:num_subcarriers

    if(count > length(mod_i))
        % Chegou ao fim dos dados
        break;
    end
    
    % Modula o dado
    subcarrier(count) = mod_i(count)*cos(2*pi*(starting_freq+count*freq_spacing)*t) - mod_q(count)*sin(2*pi*(starting_freq+count*freq_spacing)*t);
    count = count + 1;
    
    
end


% Quando o numero de bits e menor que o numero de subportadoras

% Quando o numero de bits e maior que o numero de subportadoras

