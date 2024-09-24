% DENOISEDEMO   Denoise demo
% Compare the denoise performance of wavelet and contourlet transforms
% Note: Noise standard deviation estimation of PDFB (function pdfb_nest) 
% can take a while...
close all
clc
clear all
%% Parameters
pfilt =  'bior6.8';   %'bior6.8 SNR 13.39';  %'coif5' SNR 13.46;   %'9-7; SNR 13.09'
dfilt = 'pkva12';        %'pkva12 SNR 13.45' %'pkva SNR 13.48'
nlevs = [0 4];    % Number of levels for DFB at each pyramidal level
th = 4;                     % lead to 3*sigma threshold denoising
rho = 4;                    % noise level
th_fact=4/3;
File_Path='E:\MS(CS)\Others\Rida_Khalid_FAU\contourlet\dataset\zoneplate.png';

% code_pth=cd;
% DS_path='E:\MS(CS)\Others\Rida_Khalid\contourlet\dataset';
choice=input('Press 1 to show results & 0 to not show the Results... ->  ' ) ;    
if isempty(choice)
    choice = 0;
end
% Test image: the usual suspect...
% cd(DS_path)

im = imread(File_Path);

[bpath,bname,bext]=fileparts(File_Path);
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

%% Contourlet Denoising %%%%%
% Contourlet transform
% % % Pyramidal Directional Filter Bank (or Contourlet) 
%%  Decomposition
tic
coeffs = pdfbdec(nim, pfilt, dfilt, nlevs);

% coeffs_im = pdfbdec(im, pfilt, dfilt, nlevs);

%% Display the coefficients
if choice==1

disp('Displaying the contourlet coefficients...') ; 
imcoeff = showpdfb( coeffs,'auto2','vb','2','6','abs' ) ;
title('Contourlet coefficients');
disp(' ');

% shownsct( coeffs ) ;

%% Plotting Coefiicients

pdfb_nla = cell(1, 4);
range = [0, 0.002];
scale = 1;
for k = 1:4
    pdfb_nla{k} = pdfbrec(pdfb_tr(coeffs, scale, 0, 4^k), pfilt, dfilt);
end

figure(22)
clf;
set(gcf, 'Name', 'Contourlets')
for k = 1:4,
    subplot(2,2,k),
    imagesc(pdfb_nla{k}, range), axis image, axis off
    str = sprintf('M = %d', 4^k);
    title(str);
end
colormap('gray(256)')

%%  Display information
nPixels = prod( size(im) );             % number of pixels
nCoeffs = length(pdfb2vec(coeffs));     % number of PDFB coefficients

disp( sprintf('Number of image pixels is %d', nPixels) ) ;
disp( sprintf('Number of coefficients is %d', nCoeffs) ) ;
nSignif = round(nPixels * 1/64) ;
disp( sprintf( 'It will keep %d significant coefficients', nSignif ) ) ;

%% Truncate to only the nSignif most significant coefficients
nla_coeffs = pdfb_tr(coeffs, 0, 0, nSignif);

disp('Displaying the position of the retained coefficients...') ;
figure
showpdfb( nla_coeffs, nSignif ) ;
title('Retained coefficients');
% input('Press Enter key to continue...' ) ;
disp(' ');
else
end

% Convert the output of the PDFB into a vector form
[c, s] = pdfb2vec(coeffs);

%% Threshold
% Require to estimate the noise standard deviation in the PDFB domain first 
% since PDFB is not an orthogonal transform
nvar = pdfb_nest(size(im,1), size(im, 2), pfilt, dfilt, nlevs);

% cth = th * sigma * sqrt(nvar);

%% started from 1/2 to 9/9 different combinations
%% Inverse Noise
% n_sig = std(nim(:));
% n_sigma = n_sig * rho;
% nim = im - n_sigma / randn(size(nim));
% 

cth = th_fact* th * sigma * sqrt(nvar);

%% Different Threshold 
% M=size(im,1)^2;
% UT=sig*sqrt(2*log(M));
%% Soft and Hard Thresholds
% softC=[c(1:s(1,1)^2), sthresh(c(s(1,1)^2+1:length(c)),UT)];
% hardC=[c(1:s(1,1)^2), hthresh(c(s(1,1)^2+1:length(c)),UT)];

% Slightly different thresholds for the finest scale
fs = s(end, 1);
fssize = sum(prod(s(find(s(:, 1) == fs), 3:4), 2));
cth(end-fssize+1:end) = (4/3) * cth(end-fssize+1:end);

% thrRig = thselect(c,'rigrsure');

c = c .* (abs(c) > cth);

%% Reconstruction
coeffs_recons = vec2pdfb(c, s);

if choice==1
figure('Name','Reconstructed Contourlet Coefficients')
disp('Displaying the Reconstructed contourlet coefficients...') ; 
imcoeff_r = showpdfb( coeffs_recons,'auto2','vb','2','6','abs' ) ;
title('Contourlet Reconstructed contourlet coefficients');
% input('Press Enter key to continue...' ) ;
disp(' ');
else
end

%% Pyramid Directional Filterbank Reconstruction
cim = pdfbrec(coeffs_recons, pfilt, dfilt);
timetaken=toc;
if choice==1
disp(['Time Taken -               ',num2str(timetaken)]);
%%%%% Plot: Only the hat!
range = [0, 1];
figure(3)
subplot(1,3,1), imshow(im); axis image off
set(gca, 'FontSize', 8);
title('Original Image', 'FontSize', 10);

subplot(1,3,2), imshow(nim); axis image off
set(gca, 'FontSize', 8);
title(sprintf('Noisy Image (SNR = %.2f dB)', ...
              SNR(im, nim)), 'FontSize', 10);

subplot(1,3,3), imshow(cim); axis image off
set(gca, 'FontSize', 8);
title(sprintf('Contourlets (SNR = %.3f dB)', ...
              SNR(im, cim)), 'FontSize', 10);

colormap('gray');
else
end
[res_PSNR, res_SNR] = psnr(cim,im);
disp(['SNR -                      ',num2str(res_SNR)]);
res_SNR2=SNR(im, cim);


% imwrite(cim,'denoise.jpg')
%% Performance Evaluation
% Contourlet Based Results
[res_mse,res_mae,res_SSNR,res_PSNR,res_cc,res_FSIM,res_ssim,res_STDV_denoised,res_var_denoised,res_AD,res_MD,res_NAE,res_NK,res_SC]=fun_evaluate_denoising_metrics(im,cim);

%% Plotting Cross Corelation
if choice==1
figure,
c = normxcorr2(im,cim);
surf(c),title('Cross Correlation between Input and Denoised')
shading flat

%% Plotting Histograms
% figure('Name','Histogram')
figure('Name','Input Histogram'),histogram(im),title('Hist of Input Img');
figure('Name','Noisy Histogram'),histogram(nim),title('Hist of Noised Img');
figure('Name','Denoised Histogram'),histogram(cim),title('Hist of Contourlet Based Denoised Img');

figure('Name','Histogram Full')
subplot(131),histogram(im),title('Hist of Input Img');
subplot(132),histogram(nim),title('Hist of Noised Img');
subplot(133),histogram(cim),title('Hist of Contourlet Based Denoised Img');
else
end
results_cell(1,1)=res_SNR;
results_cell(1,2)=res_mse;
results_cell(1,3)=res_mae;
results_cell(1,4)=res_SSNR;
results_cell(1,5)=res_PSNR;
results_cell(1,6)=res_cc;
results_cell(1,7)=res_FSIM;
results_cell(1,8)=res_ssim;
results_cell(1,9)=res_STDV_denoised;
results_cell(1,10)=res_var_denoised;
results_cell(1,11)=res_AD;
results_cell(1,12)=res_MD;
results_cell(1,13)=res_NAE;
results_cell(1,14)=res_NK;
results_cell(1,15)=res_SC;
results_cell(1,16)=timetaken;
results_cell_name{1,1}=bname;




