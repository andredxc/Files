function y = pratica2()

clear;
close all;
%Constantes definidas pelo usuário
Fs=100; %frequência de amostragem
Tb=1; %tempo de um bit
Nb=8; %número de bits
Fc = 10; %frequência da portadora
I = [];
Q = [];
%Constantes derivadas
Ts=1/Fs; %período de amostragem
t=0:Ts:(Nb*Tb-Ts); %vetor do tempo
L = length(t); %comprimento do vetor tempo
NFFT = 2^nextpow2(L); %número de pontos a serem utilizados na FFT
f = Fs/2*linspace(-1,1,NFFT); %vetor frequência (para sinais no domínio frequência)

%--- TRANSMISSOR ---%
bits = randi([0 1], [1, 8]); 
bits2 = reshape(bits,2,4);
for curBits = bits2(:,1:size(bits2,2))

    if curBits == [0;0]
        curI = sqrt(2)/2;
        curQ = sqrt(2)/2;

    elseif curBits == [0;1]
        curI = -sqrt(2)/2;
        curQ = sqrt(2)/2;

    elseif curBits == [1;1]
        curI = -sqrt(2)/2;
        curQ = -sqrt(2)/2;  

    elseif curBits == [1;0]
        curI = sqrt(2)/2;
        curQ = -sqrt(2)/2;
    end
    
    I = [I, curI];
    Q = [Q, curQ];
end

bits = reshape(repmat(bits, [length(t)/length(bits), 1]), [1, length(t)]);
I = reshape(repmat(I, [length(t)/length(I), 1]), [1, length(t)]);
Q = reshape(repmat(Q, [length(t)/length(Q), 1]), [1, length(t)]);
% Plotando dados do receptor
figure;
subplot(3,1,1), plot(t, bits), ylim([0, 1.5]), title('Bits de entrada');
subplot(3,1,2), plot(t, I), ylim([-3, 3]), title('Componente I no transmissor');
subplot(3,1,3), plot(t, Q), ylim([-3, 3]), title('Componente Q no transmissor');
% Gerando a onda modulada
modulated = I.*cos(2*pi*Fc*t) - Q.*sin(2*pi*Fc*t);
figure, plot(t, modulated), xlim([0, 4]), title('Sinal modulado resultante');

%--- RECEPTOR ---%
% Demodulação do sinal
iComponent = modulated.*cos(2*pi*Fc*t);
qComponent = modulated.*(-sin(2*pi* Fc*t));

subplot(4,1,1), plot(t, iComponent), title('Componente I no receptor antes da filtragem');
subplot(4,1,2), plot(t, qComponent), title('Componente Q no receptor antes da filtragem');
iComponent_trans = fftshift(fft(iComponent, NFFT));
qComponent_trans = fftshift(fft(qComponent, NFFT));

% Fs/NFFT -> step
% Fc/(Fs/NFFT) -> número de células correspondente ao intervalo Fc
% Filtros
iComponent_trans(1:length(iComponent_trans)/2-Fc/(Fs/NFFT)) = 0;    
iComponent_trans(length(iComponent_trans)/2+Fc/(Fs/NFFT):length(f)) = 0;
qComponent_trans(1:length(qComponent_trans)/2-Fc/(Fs/NFFT)) = 0;    
qComponent_trans(length(qComponent_trans)/2+Fc/(Fs/NFFT):length(f)) = 0;
% Obtendo I e Q após a filtragem
iComponent = ifft(ifftshift(iComponent_trans), length(t));
qComponent = ifft(ifftshift(qComponent_trans), length(t));
subplot(4,1,3), plot(t, iComponent), title('Componente I no receptor depois da filtragem');
subplot(4,1,4), plot(t, qComponent), title('Componente Q no receptor depois da filtragem');







%disp(Q);    
% reshape com repmat
% stem