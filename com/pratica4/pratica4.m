clear;
close all;

% Constants
nBits = 8; % Number of bits per user
nUsers = 4; % Number of users
bTime = 1; % Bit time
sampFreq = 100; %frequencia de amostragem

sampPeriod = 1/sampFreq;
t = 0:sampPeriod:(nBits*bTime-sampPeriod);
% t = 1:100*bTime*nBits*log2(nUsers);
NFFT = 2^nextpow2(length(t));
f = sampFreq/2*linspace(-1,1,NFFT);

% seqCodes = walsh_code(nUsers);
seqCodes = [0 0 0 0; 0 1 0 1; 0 0 1 1; 0 1 1 0];
seqLength = size(seqCodes, 2);
% bits = uint8(randi([0 1], [nUsers, nBits]));
bits = [1 0 1 0 0 1 0 1; 1 0 0 0 1 0 1 1; 1 1 1 1 1 1 0 1; 0 0 0 0 1 1 0 0];

% Apply chipping code for every user
sent = zeros(nUsers, nBits*seqLength);
for i = 1:nUsers
    userBuffer = logical.empty();
    for j = 1:nBits
        bitBuffer = xor(bits(i,j), seqCodes(i,:));
        userBuffer = [userBuffer bitBuffer];
    end
    sent(i,:) = userBuffer;
end

% Plot original bit signals
figure;
plotData = reshape(repmat(bits(1,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,1), plot(t, plotData), ylim([-0.1, 1.1]), title('Bits de entrada 1');
plotData = reshape(repmat(bits(2,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,2), plot(t, plotData), ylim([-0.1, 1.1]), title('Bits de entrada 2');
plotData = reshape(repmat(bits(3,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,3), plot(t, plotData), ylim([-0.1, 1.1]), title('Bits de entrada 3');
plotData = reshape(repmat(bits(4,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,4), plot(t, plotData), ylim([-0.1, 1.1]), title('Bits de entrada 4');
% Plot spread-spectrum signal
plotData = reshape(repmat(sent(1,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]);
subplot(2,4,5), plot(t, plotData), ylim([-0.1, 1.1]), title('Entrada 1 espalhada');
plotData = reshape(repmat(sent(2,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]);
subplot(2,4,6), plot(t, plotData), ylim([-0.1, 1.1]), title('Entrada 2 espalhada');
plotData = reshape(repmat(sent(3,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]);
subplot(2,4,7), plot(t, plotData), ylim([-0.1, 1.1]), title('Entrada 3 espalhada');
plotData = reshape(repmat(sent(4,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]);
subplot(2,4,8), plot(t, plotData), ylim([-0.1, 1.1]), title('Entrada 4 espalhada');

figure;
bits_freq = fftshift(fft(reshape(repmat(bits(2,:), [length(t)/nBits, 1]), [1, length(t)]), NFFT));
subplot(2,1,1), plot(f, real(bits_freq)), title('Spectro de frequencia dos bits de entrada 2');
bits_freq2 = fftshift(fft(reshape(repmat(sent(2,:), [length(t)/(nBits*seqLength), 1]), [1, length(t)]), NFFT));
subplot(2,1,2), plot(f, real(bits_freq2)), title('Spectro de frequencia dos bits de entrada 2 espalhados');


