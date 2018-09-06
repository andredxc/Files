function y = pratica2()

clear;
close all;
%Constantes definidas pelo usuario
Fs=100; %frequencia de amostragem
Tb=1; %tempo de um bit
Nb=8; %numero de bits
Fc = 10; %frequencia da portadora
I = [];
Q = [];
phi = pi/4;
%Constantes derivadas
Ts=1/Fs; %periodo de amostragem
t=0:Ts:(Nb*Tb-Ts); %vetor do tempo
L = length(t); %comprimento do vetor tempo
NFFT = 2^nextpow2(L); %numero de pontos a serem utilizados na FFT
f = Fs/2*linspace(-1,1,NFFT); %vetor frequencia (para sinais no dominio frequencia)

             %---------- TRANSMISSOR ----------%
bits = randi([0 1], [1, Nb]); 
for index = (1:2:Nb)

    if bits(index) == 0 && bits(index+1) == 0
        curI = cos(phi);
        curQ = sin(phi);
        
    elseif bits(index) == 0 && bits(index+1) == 1
        curI = -cos(phi);
        curQ = sin(phi);
        
    elseif bits(index) == 1 && bits(index+1) == 1
        curI = -cos(phi);
        curQ = -sin(phi);  
        
    elseif bits(index) == 1 && bits(index+1) == 0
        curI = cos(phi);
        curQ = -sin(phi);
    end
    
    I = [I, curI];
    Q = [Q, curQ];
end
% Montando vetores de bits, I e Q com tamanho adequado para que sejam
% plotados
bits = reshape(repmat(bits, [length(t)/length(bits), 1]), [1, length(t)]);
I = reshape(repmat(I, [length(t)/length(I), 1]), [1, length(t)]);
Q = reshape(repmat(Q, [length(t)/length(Q), 1]), [1, length(t)]);
% Plotando dados do transmissor
figure;
subplot(3,1,1), plot(t, bits), ylim([0, 1.5]), title('Bits de entrada');
subplot(3,1,2), plot(t, I), ylim([-3, 3]), title('Componente I no transmissor');
subplot(3,1,3), plot(t, Q), ylim([-3, 3]), title('Componente Q no transmissor');
% Gerando a onda modulada
modulated = I.*cos(2*pi*Fc*t) - Q.*sin(2*pi*Fc*t);
figure, plot(t, modulated), xlim([0, 4]), title('Sinal modulado');

              %---------- RECEPTOR ----------%
% Demodulacao das componentes I e Q
iComponent = modulated.*cos(2*pi*Fc*t);
qComponent = modulated.*(-sin(2*pi* Fc*t));

% Plotando I e Q no dominio tempo antes da filtragem
figure;
subplot(4,1,1), plot(t, iComponent), title('I no receptor antes da filtragem (tempo)');
subplot(4,1,2), plot(t, qComponent), title('Q no receptor antes da filtragem (tempo)');

% Plotando I e Q no dominio frequencia antes da filtragem
iComponent_freq = fftshift(fft(iComponent, NFFT));
qComponent_freq = fftshift(fft(qComponent, NFFT));
subplot(4,1,3), plot(f, real(iComponent_freq)), title('I no receptor antes da filtragem (frequencia)');
subplot(4,1,4), plot(f, real(qComponent_freq)), title('Q no receptor antes da filtragem (frequencia)');

% Filtrando I e Q no dominio frequencia com base na frequencia Fc
filterOffset = floor(NFFT/Fc);
iComponent_freq(1: floor(NFFT/2) - filterOffset) = 0;
iComponent_freq(floor(NFFT/2) + filterOffset: length(iComponent_freq)) = 0;
qComponent_freq(1: floor(NFFT/2) - filterOffset) = 0;    
qComponent_freq(floor(NFFT/2) + filterOffset: length(qComponent_freq)) = 0;

% Plotando I e Q no dominio frequencia apos a filtragem
figure;
subplot(4,1,3), plot(f, real(iComponent_freq)), title('I no receptor apos a filtragem (frequencia)');
subplot(4,1,4), plot(f, real(qComponent_freq)), title('Q no receptor apos a filtragem (frequencia)');

% Obtendo e plotando I e Q no dominio tempo apos a filtragem
iComponent = ifft(ifftshift(iComponent_freq));
qComponent = ifft(ifftshift(qComponent_freq));
iComponent_trimmed = iComponent(1:length(t));
qComponent_trimmed = qComponent(1:length(t));
subplot(4,1,1), plot(t, real(iComponent_trimmed)), title('I no receptor apos a filtragem (tempo)');
subplot(4,1,2), plot(t, real(qComponent_trimmed)), title('Q no receptor apos a filtragem (tempo)');