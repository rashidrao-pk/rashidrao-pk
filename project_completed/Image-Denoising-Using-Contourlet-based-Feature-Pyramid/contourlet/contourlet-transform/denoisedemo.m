% DENOISEDEMO   Denoise demo
% Compare the denoise performance of wavelet and contourlet transforms
% Note: Noise standard deviation estimation of PDFB (function pdfb_nest) 
% can take a while...
close all
clc
clear all
% Parameters
pfilt =  'coif5';   %'bior6.8 SNR 13.39';  %'coif5' SNR 13.46;   %'9-7; SNR 13.09'
dfilt = 'pkva';        %'pkva12 SNR 13.45' %'pkva SNR 13.48'
nlevs = [0 4];    % Number of levels for DFB at each pyramidal level
th = 3;                     % lead to 3*sigma threshold denoising
rho = 3;                    % noise level

% code_pth=cd;
% DS_path='E:\MS(CS)\Others\Rida_Khalid\contourlet\dataset';

% Test image: the usual suspect...
% cd(DS_path)
im = imread('E:\MS(CS)\Others\Rida_Khalid\contourlet\dataset\mandrill.jpg');
% mandrill.jpg

% cd(code_pth)
if isequal(size(im,3),3)
im = rgb2gray(im);
else
end

% im = imread('barbara.png');
im = double(im) / 256;

%% Generate noisy image. 
sig = std(im(:));
sigma = sig / rho;
nim = im + sigma * randn(size(im));
%% Wavelet Denoising 
% % Wavelet transform using PDFB with zero number of level for DFB
y = pdfbdec(nim, pfilt, dfilt, zeros(length(nlevs), 1));
[c, s] = pdfb2vec(y);

% Threshold (typically 3*sigma)
wth = th * sigma;
c = c .* (abs(c) > wth);

% Reconstruction
y = vec2pdfb(c, s);
wim = pdfbrec(y, pfilt, dfilt);

%% Contourlet Denoising %%%%%
% Contourlet transform
% Pyramidal Directional Filter Bank (or Contourlet) Decomposition
tic
y = pdfbdec(nim, pfilt, dfilt, nlevs);

% Convert the output of the PDFB into a vector form
[c, s] = pdfb2vec(y);

% Threshold
% Require to estimate the noise standard deviation in the PDFB domain first 
% since PDFB is not an orthogonal transform
nvar = pdfb_nest(size(im,1), size(im, 2), pfilt, dfilt, nlevs);

cth = th * sigma * sqrt(nvar);
% cth = (4/3) * th * sigma * sqrt(nvar);

% Slightly different thresholds for the finest scale
fs = s(end, 1);
fssize = sum(prod(s(find(s(:, 1) == fs), 3:4), 2));
cth(end-fssize+1:end) = (4/3) * cth(end-fssize+1:end);

c = c .* (abs(c) > cth);

% Reconstruction
y = vec2pdfb(c, s);
% Pyramid Directional Filterbank Reconstruction
cim = pdfbrec(y, pfilt, dfilt);

%% Hybrid Image

%%  Hybrid Image using simple addition
% fim=wim+cim;
%% Hybrid Image Using Or Operation
% fim=double(wim | cim);
%% Image Fusion using PCA
CCC = cov([wim(:) cim(:)]);
[VVV, DDD] = eig(CCC);
if DDD(1,1) >= DDD(2,2)
  pca = VVV(:,1)./sum(VVV(:,1));
else  
  pca = VVV(:,2)./sum(VVV(:,2));
end
% fusion
fim = pca(1)*wim + pca(2)*cim;

timetaken=toc;
disp(['Time Taken -               ',num2str(timetaken)]);
%%%%% Plot: Only the hat!
range = [0, 1];

subplot(2,3,1), imshow(im); axis image off
set(gca, 'FontSize', 8);
title('Original Image', 'FontSize', 10);

subplot(2,3,2), imshow(nim); axis image off
set(gca, 'FontSize', 8);
title(sprintf('Noisy Image (SNR = %.2f dB)', ...
              SNR(im, nim)), 'FontSize', 10);

subplot(2,3,4), imshow(wim); axis image off
set(gca, 'FontSize', 8);
title(sprintf('Wavelets (SNR = %.3f dB)', ...
              SNR(im, wim)), 'FontSize', 10);

subplot(2,3,5), imshow(cim); axis image off
set(gca, 'FontSize', 8);
title(sprintf('Contourlets (SNR = %.3f dB)', ...
              SNR(im, cim)), 'FontSize', 10);
subplot(2,3,6), imshow(fim); axis image off
set(gca, 'FontSize', 8);
title(sprintf('Hybrid (SNR = %.3f dB)', ...
              SNR(im, fim)), 'FontSize', 10);
colormap('gray');

disp(['SNR -                      ',num2str(SNR(im, cim))]);

% imwrite(cim,'denoise.jpg')
%% Performance Evaluation
% Contourlet Based Results
[mse_c,mae_c,SSNR_c,PSNR_c,cross_core_c,FSIM_c,ssimval_c]=fun_evaluate_denoising_metrics(im,cim);
% Wavlet Based Results
[mse_w,mae_w,SSNR_w,PSNR_w,cross_core_w,FSIM_w,ssimval_w]=fun_evaluate_denoising_metrics(im,wim);
% Fused Results
[mse_f,mae_f,SSNR_f,PSNR_f,cross_core_f,FSIM_f,ssimval_f]=fun_evaluate_denoising_metrics(im,fim);
%imhist(cim);
%% Putting Results into Table
Algo = {'Contourlet';'Wavlet';'Hybrid'};
MSE = [mse_c;mse_w;mse_f];
MAE= [mae_c;mae_w;mae_f];
SNR= [SSNR_c;SSNR_w;SSNR_f];
PSNR= [PSNR_c;PSNR_w;PSNR_f];
Cross_Core = [cross_core_c;cross_core_w;cross_core_f];
FSIM = [FSIM_c;FSIM_w;FSIM_f];
SSIM = [ssimval_c;ssimval_w;ssimval_f];
Table = table(Algo,MSE,MAE,SNR,PSNR,Cross_Core,FSIM,SSIM);
disp(Table)
%% Plotting Histograms
figure(22,'Name','Histogram')
subplot(231),histogram(im),title('Hist of Input Img');
subplot(232),histogram(nim),title('Hist of Noised Img');
subplot(234),histogram(wim),title('Hist of Wavelet Based Denoised Img');
subplot(235),histogram(cim),title('Hist of Contourlet Based Denoised Img');
subplot(236),histogram(fim),title('Hist of Fused Denoised Img');

clear c cth fs nlevs nvar pfilt s sig sigma th wth y dfilt mse_c mse_w mae_c mae_w SSNR_c
clear SSNR_w  PSNR_c PSNR_w cross_core_c cross_core_w FSIM_c FSIM_w ssimval_c ssimval_w
