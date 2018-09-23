clear all;
close all;

num_b = 3000000; %quantidade de bits simulados
bits = complex(2*randi(2, 1, num_b)-3, 0); %vetor complexo com parte real {-1, 1} e parte imaginaria = 0

Eb_N0_dB = 0:1:10; %faixa de Eb/N0 a ser simulada (em dB)
Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %Eb/N0 linearizado
Eb = 1; %energia por simbolo e constante (1^2 = (-1)^2 = 1), 1 bit por simbolo (caso geral: energia media por simbolo / bits por simbolo)
NP = Eb ./ (Eb_N0_lin); %potencia do ruido
NA = sqrt(NP); %amplitude e a raiz quadrada da potencia

ber = zeros(size(Eb_N0_lin)); %pre-allocates BER vector
    
for i = 1:length(Eb_N0_lin)
    n = NA(i)*complex(randn(1, num_b), randn(1, num_b))*sqrt(0.5); %vetor de ruido com desvio padrao igual a amplitude do ruido
    r = bits + n; % canal AWNG
    demod = sign(real(r)); % sinal da parte real determina o valor do bit
    ber(i) = sum(bits ~= demod) / num_b; % conta erros e calcula o BER
end

ber_theoretical = 0.5*erfc(sqrt(Eb_N0_lin)); %BER teorico

semilogy(Eb_N0_dB, ber, Eb_N0_dB, ber_theoretical, 'LineWidth', 2);
grid on;
title('Taxa de erros para BPSK');
legend('Medido', 'Teorico');
ylabel('BER');
xlabel('Eb/N0 (dB)');