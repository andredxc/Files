function y = alpha_trimmed_mean_filter(img, alpha, n);

% Verificação dos parâmetros
if alpha >= (n^2)/2
    error('Parameter alpha must be less than %d', (n^2)/2);
end

if mod(alpha, 2) ~= 0
    error('Parameter alpha must be an even number')
end

if mod(n,2) == 0
    error('Parameter n must be an odd number');
end
    
% Aumenta as bordas da imagem
img = double(img);
w = (n-1)/2;
[imageHeight, imageWidth, imageChannels] = size(img);
newImg = zeros(imageHeight+2*w, imageWidth+2*w, imageChannels);

% Copia a imagem original para dentro da nova matriz
newImg((w+1):(imageHeight+w), (w+1):(imageWidth+w), :) = img(:, :, :);
% Duplica as colunas a esquerda da imagem
newImg((w+1):(imageHeight+w), 1:w, :) = img(:, w:-1:1, :);
% Duplica as colunas a direita da imagem
newImg((w+1):(imageHeight+w), (w+imageWidth+1):(2*w+imageWidth), :) = img(:, imageWidth:-1:(imageWidth-w+1), :);
% Duplica as linhas a cima da imagem
newImg(1:w, :, :) = newImg((2*w):-1:(w+1), :, :);
% Duplica as linhas abaixo da imagem
newImg((w+imageHeight+1):(2*w+imageHeight), :, :) = newImg((w+imageHeight):-1:(w+imageHeight-w+1), :, :);

% Percorre a imagem com uma janela nXn
curWindow = zeros(n, n);
y = zeros(imageHeight, imageWidth, imageChannels);
for curChannel = 1:imageChannels
    for curRow = 1:imageHeight
        for curCol = 1:imageWidth
            % Cria a janela atual
            row = curRow + w;
            col = curCol + w;
            curWindow = newImg((row-w):(row+w), (col-w):(col+w), curChannel);
            % Remove os valores extremos
            curWindow = reshape(curWindow, [1, numel(curWindow)]);
            curWindow = sort(curWindow);
            curWindow = curWindow((alpha/2+1):(numel(curWindow)-alpha/2));
            % Calcula o valor da média
            meanValue = mean(curWindow);
            % Atribui o valor ao novo pixel
            y(curRow, curCol, curChannel) = meanValue;
        end
    end
end

y = uint8(y);