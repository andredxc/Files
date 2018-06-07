function y = SNR(img, noisy);

imageChannels = size(img, 3);
img = double(img);
noisy = double(noisy);

% Calcula o SNR para cada um dos canais da imagem
snr = 0;
for curChannel = 1:imageChannels;
    
    curImg = img(:, :, curChannel);
    curNoisy = noisy(:, :, curChannel)
    if(size(snr) == 1)
        snr(1) = 10*log10(std2(curImg)^2/std2(curImg - curNoisy)^2);
        psnr(1) = 10*log10((amplitude^2)/std2(curImg-curNoisy)^2);
    else
        snr(size(snr)+1) = 10*log10(std2(curImg)^2/std2(curImg - curNoisy)^2);
        psnr(size(psnr)+1) = 10*log10((amplitude^2)/std2(curImg-curNoisy)^2);
    end
end

% Retorna a m餩a dos valores
y = mean(snr);