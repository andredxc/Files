function y = PSNR(img, noisy);

[imageHeiht, imageWidth, imageChannels] = size(img);
img = double(img);
noisy = double(noisy);

% Calcula o PSNR para cada um dos canais da imagem
psnr = 0;
for curChannel = 1:imageChannels;
    
    curImg = img(:, :, curChannel);
    curNoisy = noisy(:, :, curChannel)
    imgMax = max(max(curImg));
    imgMin = min(min(curImg));
    amplitude = imgMax - imgMin;
    if(size(psnr) == 1)
        psnr(1) = 10*log10((amplitude^2)/std2(curImg-curNoisy)^2);
    else
        psnr(size(psnr)+1) = 10*log10((amplitude^2)/std2(curImg-curNoisy)^2);
    end
end

% Retorna a media dos valores
y = mean(psnr);


    
   
    