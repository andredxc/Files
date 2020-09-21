clear;
close all;

% Constantes
nBits = 8; % Numero de bits por usuario
nUsers = 4; % Numero de usuarios
bTime = 1; % Bit time
sampFreq = 80; % Frequencia de amostragem
% Constantes derivadas
sampPeriod = 1/sampFreq;
t = 0:sampPeriod:(nBits*bTime-sampPeriod);
NFFT = 2^nextpow2(length(t));
f = sampFreq/2*linspace(-1,1,NFFT);

% TRANSMISSOR ---------------------------------------------------------------
bits = 2*randi(2, [nUsers,nBits])-3;
% Matriz de Walsh gerada pelo algoritmo visto em aula
seqCodes = [1 1 1 1; 1 -1 1 -1; 1 1 -1 -1; 1 -1 -1 1];
seqLength = size(seqCodes, 2);

% Aplicando a sequencia de cada usuario nos respectivos dados
spreadBits = zeros(nUsers, nBits*seqLength);
for i = 1:nUsers
    userBuffer = logical.empty();
    for j = 1:nBits
        bitBuffer = bits(i,j).*seqCodes(i,:);
        userBuffer = [userBuffer bitBuffer];
    end
    spreadBits(i,:) = userBuffer;
end

% Plotando bits de entrada no transmissor
figure;
plotData = reshape(repmat(bits(1,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,1), plot(t, plotData), ylim([-1.1, 1.1]), title('Bits de entrada 1');
plotData = reshape(repmat(bits(2,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,2), plot(t, plotData), ylim([-1.1, 1.1]), title('Bits de entrada 2');
plotData = reshape(repmat(bits(3,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,3), plot(t, plotData), ylim([-1.1, 1.1]), title('Bits de entrada 3');
plotData = reshape(repmat(bits(4,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,4), plot(t, plotData), ylim([-1.1, 1.1]), title('Bits de entrada 4');
% Plotando sequencias de bits espalhadas
plotData = reshape(repmat(spreadBits(1,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]);
subplot(2,4,5), plot(t, plotData), ylim([-1.1, 1.1]), title('Entrada 1 espalhada');
plotData = reshape(repmat(spreadBits(2,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]);
subplot(2,4,6), plot(t, plotData), ylim([-1.1, 1.1]), title('Entrada 2 espalhada');
plotData = reshape(repmat(spreadBits(3,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]);
subplot(2,4,7), plot(t, plotData), ylim([-1.1, 1.1]), title('Entrada 3 espalhada');
plotData = reshape(repmat(spreadBits(4,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]);
subplot(2,4,8), plot(t, plotData), ylim([-1.1, 1.1]), title('Entrada 4 espalhada');
% Plotando spectro de frequencias 
figure;
bits_freq = fftshift(fft(reshape(repmat(bits(2,:), [length(t)/nBits, 1]), [1, length(t)]), NFFT));
subplot(2,1,1), plot(f, real(bits_freq)), title('Spectro de frequencia dos bits de entrada 2');
bits_freq2 = fftshift(fft(reshape(repmat(spreadBits(2,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]), NFFT));
subplot(2,1,2), plot(f, real(bits_freq2)), title('Spectro de frequencia dos bits de entrada 2 espalhados');
% Soma os bits espalhados linha a linha como simulaçao dos efeitos do meio
sent = sum(spreadBits);

% RECEPTOR ---------------------------------------------------------------
received = zeros(nUsers, nBits);
% Aplicando a sequencia de cada usuario no vetor de dados recebido
for i = 1:nUsers
    for j = 1:seqLength:(nBits*seqLength)-1
        bitBuffer = sent(j:j+seqLength-1) .* seqCodes(i,:);
        if sum(bitBuffer) > 0
            % Recebeu +1
            received(i,1+floor(j/seqLength)) = 1;
        else
            % Recebeu -1
            received(i,1+floor(j/seqLength)) = -1;
        end
    end
end

% Plotando bits recebidos
figure
plotData = reshape(repmat(received(1,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(1,4,1), plot(t, plotData), ylim([-1.1, 1.1]), title('Bits de entrada 1 no receptor');
plotData = reshape(repmat(received(2,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(1,4,2), plot(t, plotData), ylim([-1.1, 1.1]), title('Bits de entrada 2 no receptor');
plotData = reshape(repmat(received(3,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(1,4,3), plot(t, plotData), ylim([-1.1, 1.1]), title('Bits de entrada 3 no receptor');
plotData = reshape(repmat(received(4,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(1,4,4), plot(t, plotData), ylim([-1.1, 1.1]), title('Bits de entrada 4 no receptor');




