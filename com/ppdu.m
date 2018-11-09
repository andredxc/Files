% function frame = ppdu(rate, data)
clear all;
% Variables
rate = 54; % In Mbits/s
data = logical(randi([0 1], [1,800])); % Data from MAC sublayer

% Parameter check
if size(data, 1) ~= 1
    fprintf('Error, data must be a row vector\n');
    return;
elseif length(data) > 4095
    fprintf('Error, data must have a max length of 4095\n');
    return;
elseif mod(length(data), 8) ~= 0
    fprintf('Error, inconsistent number of octects in data\n');
    return;
end

% Assembling frame
frame = logical(zeros(1, 46+length(data))); % 4+1+12+1+6+16+psdu+6+pad (46+psdu+pad)
dbps = 0; % Number of data bits per symbol
% RATE field (1-4)
switch rate
    case 6
        frame(1:4) = 1101; dbps = 24;
    case 9
        frame(1:4) = 1111; dbps = 36;
    case 12
        frame(1:4) = 0101; dbps = 48;
    case 18
        frame(1:4) = 0111; dbps = 72;
    case 24
        frame(1:4) = 1001; dbps = 96;
    case 36
        frame(1:4) = 1011; dbps = 144;
    case 48
        frame(1:4) = 0001; dbps = 192;
    case 54
        frame(1:4) = 0011; dbps = 216;
    otherwise
        fprintf('Error, rate is invalid');
        return;
end
% Reserved field (5)
% LENGTH field (6-17) with LSB to the left
frame(6:17) = de2bi(length(data)/8, 12);
% Parity (18)
if mod(sum(frame(1:17)), 2) == 0
    frame(18) = 0;
else
    frame(18) = 1;
end
% Tail (19-24)
% SERVICE (25-40)
% PSDU (41-40+8*length(data))
frame(41:40+length(data)) = data;
% Tail (41+8*length(data)-46+8*length(data))
% Pad bits (47+8*length(data)-end)
nSimb = ceil((16 + length(data) + 6)/dbps);
nData = nSimb * dbps;
nPad = nData - (16 + length(data) + 6);
frame(47+length(data):46+length(data)+nPad) = 0;

% end

% Reference 802.11a PDF 
% PPDU structure -> page 7
% dbps -> page 9
% LENGTH bit order -> page 14
% Pad bits -> page 15




    
    
    
