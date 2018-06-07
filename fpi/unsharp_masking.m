function [gauImg, lapImg, lapFilter] = unsharp_masking(img, k)

% Define o filtro laplaciano usado
laplacianKernel = [0 -1 0; -1 4 -1; 0 -1 0];
   
% Define o filtro gaussiano usado 
gaussianKernel = -[1 4 6 4 1; 4 16 24 16 4; 6 24 -476 24 6; 4 16 24 16 4; 1 4 6 4 1]/256;

img = double(img);
lapImg = zeros(size(img));
lapFilter = zeros(size(img));
gauImg = zeros(size(img));
imageChannels = size(img,3);
for curChannel = 1:imageChannels
    % Interpola um canal por vez
    curImg = img(:, :, curChannel);
    % Laplaciano
    lapImg(:,:,curChannel) = curImg + k*filter2(laplacianKernel,curImg);
    lapFilter(:,:,curChannel) = filter2(laplacianKernel,curImg);
    % Gaussiano
    gauImg(:,:,curChannel) = filter2(gaussianKernel,curImg);
end
lapImg = uint8(lapImg);
lapFilter = uint8(lapFilter);
gauImg = uint8(gauImg);
end