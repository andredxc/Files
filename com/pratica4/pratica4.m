clear;
close all;

% Constants
nBits = 8; % Number of bits per user
nUsers = 4; % Number of users
bTime = 1; % Bit time

t = 1:10*bTime*nBits*log2(nUsers);

seqCodes = walsh_code(2);
bits = uint8(randi([0 1], [nUsers, nBits]));

% Plotting bits
figure;
plotBits = reshape(repmat(bits(1,:), [length(t)/nBits, 1]), [1, length(t)]);
subplot(2,4,1), plot(t, plotBits), ylim([-0.1, 1.1]), title('Bits de entrada 1');

% Sending bits
for i = 1:nUsers
    for j = 1:nBits
        sent = 
    end
end