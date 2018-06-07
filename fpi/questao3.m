function y = questao3()

% -------------------------------Imagem 1
img1 = imread('coloredChips.png');
noisy1 = imnoise(img1, 'gaussian');
noisy1 = imnoise(noisy1, 'salt & pepper');
% alpha = 4 e N = 3
alphaTrimmed1 = alpha_trimmed_filter(noisy1, 4, 3);
[PSNR1, SNR1] = metrics(img1, alphaTrimmed1);
% PSNR - noisy = 16.0718 dB
% PSNR - alphaTrimmed = 27.6858 dB
% SNR - noisy = 3.1173 dB
% SNR - alphaTrimmed = 14.7313 dB

% Laplaciano
[gauImg11, gauFilter11, lapImg11, lapFilter11] = unsharp_masking(alphaTrimmed1, 0.7);
figure, subplot(2,2,1), imshow(lapFilter11), title('lapFilter11');
subplot(2,2,2), imshow(lapImg11), title('lapImg11');
subplot(2,2,3), imshow(gauFilter11), title('gauFilter11');
subplot(2,2,4), imshow(gauImg11), title('gauImg11');

% Gaussiana
[gauImg12, gauFilter12, lapImg12, lapFilter12] = unsharp_masking(alphaTrimmed1, 0.6);
figure, subplot(2,2,1), imshow(lapFilter12), title('lapFilter12');
subplot(2,2,2), imshow(lapImg12), title('lapImg12');
subplot(2,2,3), imshow(gauFilter12), title('gauFilter12');
subplot(2,2,4), imshow(gauImg12), title('gauImg12');


% -------------------------------Imagem 2
img2 = imread('autumn.tif');
noisy2 = imnoise(img2, 'gaussian');
noisy2 = imnoise(noisy2, 'salt & pepper');
% aplha = 4 e N = 3
alphaTrimmed2 = alpha_trimmed_filter(noisy2, 4, 3);
[PSNR2, SNR2] = metrics(img2, noisy2);
% PSNR - noisy = 14.6915 dB
% PSNR - alphaTrimmed = 23.9098 dB
% SNR - noisy = 5.3989 dB
% SNR - alphaTrimmed = 14.6172 dB

% Laplaciano
[gauImg21, gauFilter21, lapImg21, lapFilter21] = unsharp_masking(alphaTrimmed2, 0.8);
figure, subplot(2,2,1), imshow(lapFilter21), title('lapFilter21');
subplot(2,2,2), imshow(lapImg21), title('lapImg21');
subplot(2,2,3), imshow(gauFilter21), title('gauFilter21');
subplot(2,2,4), imshow(gauImg21), title('gauImg21');

% Gaussiana
[gauImg22, gauFilter22, lapImg22, lapFilter22] = unsharp_masking(alphaTrimmed2, 0.7);
figure, subplot(2,2,1), imshow(lapFilter22), title('lapFilter22');
subplot(2,2,2), imshow(lapImg22), title('lapImg22');
subplot(2,2,3), imshow(gauFilter22), title('gauFilter22');
subplot(2,2,4), imshow(gauImg22), title('gauImg22');



