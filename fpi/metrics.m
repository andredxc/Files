function [PSNR, SNR] = metrics(img, noisy)

imageChannels = size(img, 3);
img = double(img);
noisy = double(noisy);

% Calcula o SNR e o PSNR para cada um dos canais da imagem
SNR = 0;
PSNR = 0;
for curChannel = 1:imageChannels
    
    curImg = img(:, :, curChannel);
    curNoisy = noisy(:, :, curChannel);
    
    imgMax = max(max(curImg));
    imgMin = min(min(curImg));
    amplitude = imgMax - imgMin;
    
    if curChannel == 1
        SNR(1) = 10*log10(std2(curImg)^2/std2(curImg - curNoisy)^2);
        PSNR(1) = 10*log10((amplitude^2)/std2(curImg-curNoisy)^2);
    else
        SNR(size(SNR)+1) = 10*log10(std2(curImg)^2/std2(curImg - curNoisy)^2);
        PSNR(size(PSNR)+1) = 10*log10((amplitude^2)/std2(curImg-curNoisy)^2);
    end
end

% Retorna as medias dos valores
SNR = mean(SNR);
PSNR = mean(PSNR);
end