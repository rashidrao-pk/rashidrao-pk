%% Demo Loop All Results All Images

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
nlevs = [0 2];    % Number of levels for DFB at each pyramidal level
th = 4;                     % lead to 3*sigma threshold denoising
rho = 4;                    % noise level
th_fact=4/3;
codes_path=cd;
Results_Path='E:\MS(CS)\Others\Rida_Khalid_FAU\Results';
Results=[Results_Path '\32 Visual + Stats'];
if ~exist(Results, 'dir') 
    mkdir(Results) 
end
% im = imread('E:\MS(CS)\Others\Rida_Khalid_FAU\contourlet\dataset\zoneplate.png');

ds=imageDatastore('E:\MS(CS)\Others\Rida_Khalid_FAU\contourlet\dataset');
results_table=table();
results_table1=table();
results_table2=table();

for DS_iter=1:length(ds.Files)
[bpath,bname,bext]=fileparts(ds.Files{DS_iter, 1});

Results_sep=[Results '/' bname];

if ~exist(Results_sep, 'dir') 
    mkdir(Results_sep) 
end

% mandrill.jpg
im=imread(ds.Files{DS_iter, 1});
% cd(code_pth)
if isequal(size(im,3),3)
im = rgb2gray(im);
else
end

% im = imread('barbara.png');
im = double(im) / 256;

cd(Results_sep)
imwrite(im,'Results_1_Input_Image.png')
cd(codes_path)

%% Generate noisy image. 
sig = std(im(:));
sigma = sig / rho;
nim = im + sigma * randn(size(im));
% nim=imnoise(im,'gaussian');

cd(Results_sep)
imwrite(nim,'Results_2_Noisy_Image.png')
cd(codes_path)

%% Contourlet Denoising %%%%%
% Contourlet transform
% % % Pyramidal Directional Filter Bank (or Contourlet) 
%%  Decomposition
tic
coeffs = pdfbdec(nim, pfilt, dfilt, nlevs);

% coeffs_im = pdfbdec(im, pfilt, dfilt, nlevs);

%% Display the coefficients
disp('Displaying the contourlet coefficients...') ; 
imcoeff = showpdfb( coeffs,'auto2','hb','4','6','ab' ) ;
title('Contourlet coefficients');
disp('abs')
cd(Results_sep)
saveas(gcf,'Coefficients_Contourlet_abs.png')
cd(codes_path)
disp('abs')
close all

imcoeff = showpdfb( coeffs,'auto2','hb','4','6','real',4) ;
title('Contourlet coefficients');
disp('real')
cd(Results_sep)
saveas(gcf,'Coefficients_Contourlet_real.png')
cd(codes_path)
close all
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
for k = 1:4
    subplot(2,2,k),
    imagesc(pdfb_nla{k}, range), axis image, axis off
    str = sprintf('M = %d', 4^k);
    title(str);
end
colormap('gray(256)')

cd(Results_sep)
saveas(gcf,'Coefficients_Finest.png')
cd(codes_path)

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
% cd(Results_sep)
% saveas(gcf,'coefficients_Retained.png')
% cd(codes_path)
close all

% Convert the output of the PDFB into a vector form
[cc, s] = pdfb2vec(coeffs);

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
cth_old = 4 * sigma * sqrt(nvar);

cth = th * sigma * sqrt(nvar);

%% Different Threshold 
M=size(im,1)^2;
UT=sig*sqrt(2*log(M));
softC=[cc(1:s(1,1)^2), sthresh(cc(s(1,1)^2+1:length(cc)),UT)];
hardC=[cc(1:s(1,1)^2), hthresh(cc(s(1,1)^2+1:length(cc)),UT)];

fs = s(end, 1);
fssize = sum(prod(s(find(s(:, 1) == fs), 3:4), 2));

fact=(std(im(:))+std(nim(:))+mean(nim(:)))+median(cth);

cth(end-fssize+1:end) =  fact * cth(end-fssize+1:end);


c = cc .* (abs(cc) > cth);

c_n = cc .* (abs(cc) < cth);

c1 = cc .* (abs(cc) > softC);

c2 = cc .* (abs(cc) > hardC);

f1=c';
f1=unique(f1);
f1_1=size(f1,1);

%% Implemented Baysian Threshold , Not working in this sanerio
bayesC=baysian_threshold(cc,s);

%% Plotting  THRESHOLD

%% Reconstruction
coeffs_recons = vec2pdfb(c, s);
coeffs_recons_1 = vec2pdfb(c1, s);
coeffs_recons_2 = vec2pdfb(c2, s);
noise_recons=vec2pdfb(c_n, s);
figure('Name','Reconstructed Contourlet Coefficients')
disp('Displaying the Reconstructed contourlet coefficients...') ; 
imcoeff_r = showpdfb( coeffs_recons,'auto2','hb','4','6','abs' ) ;
title('Contourlet Reconstructed contourlet coefficients abs');
% input('Press Enter key to continue...' ) ;
cd(Results_sep)
saveas(gcf,'Coefficients_Reconstructed_abs.png');
cd(codes_path)
imcoeff = showpdfb( coeffs_recons,'auto2','hb','4','6','real',4) ;
title('Contourlet Reconstructed contourlet coefficients real');
cd(Results_sep)
saveas(gcf,'Coefficients_Reconstructed_real.png')
cd(codes_path)



%% Pyramid Directional Filterbank Reconstruction
cim = pdfbrec(coeffs_recons, pfilt, dfilt);
cim1 = pdfbrec(coeffs_recons_1, pfilt, dfilt);
cim2 = pdfbrec(coeffs_recons_2, pfilt, dfilt);

c_n_im = pdfbrec(noise_recons, pfilt, dfilt);
cd(Results_sep)
imwrite(cim,'Results_3_Denoised.png')
imwrite(c_n_im,'Results_4 Noise Removed.png')
cd(codes_path)
timetaken=toc;

[res_PSNR, res_SNR] = psnr(cim,im);
[res_PSNR1, res_SNR1] = psnr(cim1,im);
[res_PSNR2, res_SNR2] = psnr(cim2,im);

figure(3)
% subplot(2,3,1), imshow(im); axis image off
% set(gca, 'FontSize', 8);
% title('Original Image', 'FontSize', 6);
% 
% subplot(2,3,2), imshow(nim); axis image off
% set(gca, 'FontSize', 8);
% title('Noisy Image ', 'FontSize', 6);

subplot(1,3,1), imshow(cim); axis image off
set(gca, 'FontSize', 6);
title(sprintf('Proposed Threshold (SNR = %.3f dB)',res_SNR), 'FontSize', 6);


subplot(1,3,2), imshow(cim1); axis image off
set(gca, 'FontSize', 6);
title(sprintf('Threshold 1(SNR = %.3f dB)',res_SNR1), 'FontSize', 6);

subplot(1,3,3), imshow(cim2); axis image off
set(gca, 'FontSize', 6);
title(sprintf('Threshold 2(SNR = %.3f dB)',res_SNR2), 'FontSize', 6);
colormap('gray');
cd(Results_sep)
saveas(gcf,'Results_Full.png')
imwrite(cim,'denoise_proposed.jpg')
imwrite(cim1,'denoise_Th1.jpg')
imwrite(cim2,'denoise_Th2.jpg')
cd(codes_path)
%% Performance Evaluation
% Contourlet Based Results
[res_mse,res_mae,res_SSNR,res_PSNRnew,res_cc,res_FSIM,res_ssim,res_STDV_denoised,res_var_denoised,res_AD,res_MD,res_NAE,res_NK,res_SC]=fun_evaluate_denoising_metrics(im,cim);
[res_mse1,res_mae1,res_SSNR1,res_PSNRnew1,res_cc1,res_FSIM1,res_ssim1,res_STDV_denoised1,res_var_denoised1,res_AD1,res_MD1,res_NAE1,res_NK1,res_SC1]=fun_evaluate_denoising_metrics(im,cim1);
[res_mse2,res_mae2,res_SSNR2,res_PSNRnew2,res_cc2,res_FSIM2,res_ssim2,res_STDV_denoised2,res_var_denoised2,res_AD2,res_MD2,res_NAE2,res_NK2,res_SC2]=fun_evaluate_denoising_metrics(im,cim2);

results_cell(DS_iter,1)=res_SNR;
results_cell(DS_iter,2)=res_mse;
results_cell(DS_iter,3)=res_mae;
results_cell(DS_iter,4)=res_SSNR;
results_cell(DS_iter,5)=res_PSNR;
results_cell(DS_iter,6)=res_cc;
results_cell(DS_iter,7)=res_FSIM;
results_cell(DS_iter,8)=res_ssim;
results_cell(DS_iter,9)=res_STDV_denoised;
results_cell(DS_iter,10)=res_var_denoised;
results_cell(DS_iter,11)=res_AD;
results_cell(DS_iter,12)=res_MD;
results_cell(DS_iter,13)=res_NAE;
results_cell(DS_iter,14)=res_NK;
results_cell(DS_iter,15)=res_SC;
results_cell(DS_iter,16)=timetaken;
results_cell_name{DS_iter,1}=bname;

%% Results 2
results_cell1(DS_iter,1)=res_SNR1;
results_cell1(DS_iter,2)=res_mse1;
results_cell1(DS_iter,3)=res_mae1;
results_cell1(DS_iter,4)=res_SSNR1;
results_cell1(DS_iter,5)=res_PSNR1;
results_cell1(DS_iter,6)=res_cc1;
results_cell1(DS_iter,7)=res_FSIM1;
results_cell1(DS_iter,8)=res_ssim1;
results_cell1(DS_iter,9)=res_STDV_denoised1;
results_cell1(DS_iter,10)=res_var_denoised1;
results_cell1(DS_iter,11)=res_AD1;
results_cell1(DS_iter,12)=res_MD1;
results_cell1(DS_iter,13)=res_NAE1;
results_cell1(DS_iter,14)=res_NK1;
results_cell1(DS_iter,15)=res_SC1;

%% Results 3
results_cell2(DS_iter,1)=res_SNR2;
results_cell2(DS_iter,2)=res_mse2;
results_cell2(DS_iter,3)=res_mae2;
results_cell2(DS_iter,4)=res_SSNR2;
results_cell2(DS_iter,5)=res_PSNR2;
results_cell2(DS_iter,6)=res_cc2;
results_cell2(DS_iter,7)=res_FSIM2;
results_cell2(DS_iter,8)=res_ssim2;
results_cell2(DS_iter,9)=res_STDV_denoised2;
results_cell2(DS_iter,10)=res_var_denoised2;
results_cell2(DS_iter,11)=res_AD2;
results_cell2(DS_iter,12)=res_MD2;
results_cell2(DS_iter,13)=res_NAE2;
results_cell2(DS_iter,14)=res_NK2;
results_cell2(DS_iter,15)=res_SC2;


%% Plotting Cross Corelation
figure,
c = normxcorr2(im,cim);
surf(c),title('Cross Correlation between Input and Denoised')
shading flat

cd(Results_sep)
saveas(gcf,'SURF_PLot.png')
cd(codes_path)


%% Plotting Histograms
% figure('Name','Histogram')
figure('Name','Input Histogram'),histogram(im),title('Hist of Input Img');
cd(Results_sep)
saveas(gcf,sprintf('Histogram 1 Input.png',DS_iter));
cd(codes_path)

figure('Name','Noisy Histogram'),histogram(nim),title('Hist of Noised Img');
cd(Results_sep)
saveas(gcf,sprintf('Histogram 2 Noisy.png',DS_iter));
cd(codes_path)

figure('Name','Denoised Histogram'),histogram(cim),title('Hist of Contourlet Based Denoised Img');
cd(Results_sep)
saveas(gcf,sprintf('Histogram 3 Denoised.png',DS_iter));
cd(codes_path)
close all
end


results_table.SNR=results_cell(:,1);
results_table.MSE=results_cell(:,2);
results_table.MAE=results_cell(:,3);
results_table.SSNR=results_cell(:,4);
results_table.PSNR=results_cell(:,5);
results_table.CrossCore=results_cell(:,6);
results_table.FSIM=results_cell(:,7);
results_table.SSIM_Value=results_cell(:,8);
results_table.StandarDeviation=results_cell(:,9);
results_table.Variance=results_cell(:,10);
results_table.AD=results_cell(:,11);
results_table.MD=results_cell(:,12);
results_table.NAE=results_cell(:,13);
results_table.NK=results_cell(:,14);
results_table.SC=results_cell(:,15);


%% Results 2
results_table1.SNR=results_cell1(:,1);
results_table1.MSE=results_cell1(:,2);
results_table1.MAE=results_cell1(:,3);
results_table1.SSNR=results_cell1(:,4);
results_table1.PSNR=results_cell1(:,5);
results_table1.CrossCore=results_cell1(:,6);
results_table1.FSIM=results_cell1(:,7);
results_table1.SSIM_Value=results_cell1(:,8);
results_table1.StandarDeviation=results_cell1(:,9);
results_table1.Variance=results_cell1(:,10);
results_table1.AD=results_cell1(:,11);
results_table1.MD=results_cell1(:,12);
results_table1.NAE=results_cell1(:,13);
results_table1.NK=results_cell1(:,14);
results_table1.SC=results_cell1(:,15);

%% Results 3
results_table2.SNR=results_cell2(:,1);
results_table2.MSE=results_cell2(:,2);
results_table2.MAE=results_cell2(:,3);
results_table2.SSNR=results_cell2(:,4);
results_table2.PSNR=results_cell2(:,5);
results_table2.CrossCore=results_cell2(:,6);
results_table2.FSIM=results_cell2(:,7);
results_table2.SSIM_Value=results_cell2(:,8);
results_table2.StandarDeviation=results_cell2(:,9);
results_table2.Variance=results_cell2(:,10);
results_table2.AD=results_cell2(:,11);
results_table2.MD=results_cell2(:,12);
results_table2.NAE=results_cell2(:,13);
results_table2.NK=results_cell2(:,14);
results_table2.SC=results_cell2(:,15);


cd(Results)
filename1 = 'All_Results_.xlsx';
writetable(results_table,filename1,'Sheet','Results','Range','B1')
writetable(results_table1,filename1,'Sheet','Results1','Range','B1')
writetable(results_table2,filename1,'Sheet','Results2','Range','B1')

results_table.TimeTaken=results_cell(:,9);
results_table.Combination=results_cell(:,10);