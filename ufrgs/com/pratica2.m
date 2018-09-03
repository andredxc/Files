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

% Pegar bits dois a dois
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

% Reshape bits, I and Q
bits = reshape(repmat(bits, [length(t)/length(bits), 1]), [1, length(t)]);
I = reshape(repmat(I, [length(t)/length(I), 1]), [1, length(t)]);
Q = reshape(repmat(Q, [length(t)/length(Q), 1]), [1, length(t)]);
% Plot bits, I and Q
figure, plot(t, bits), ylim([0, 1.5]), title('Input');
figure, plot(t, I), ylim([-3, 3]), title('I');
figure, plot(t, Q), ylim([-3, 3]), title('Q');
% Create modulated wave
modulated = I.*cos(2*pi*Fc*t) - Q.*sin(2*pi*Fc*t);
figure, plot(t, modulated);

% Demodulate received signal






%disp(Q);    
% reshape com repmat
% stem