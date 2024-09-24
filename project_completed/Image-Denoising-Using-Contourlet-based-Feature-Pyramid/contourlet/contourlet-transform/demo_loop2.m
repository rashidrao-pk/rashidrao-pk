% DENOISEDEMO   Denoise demo
% Compare the denoise performance of wavelet and contourlet transforms
% Note: Noise standard deviation estimation of PDFB (function pdfb_nest) 
% can take a while...
close all
clc
clear all
%% Parameters

fprintf('Code Started at  %s\n', datestr(now,'HH:MM:SS'))
% pfilt =  'coif5';   %'bior6.8 SNR 13.39';  %'coif5' SNR 13.46;   %'9-7; SNR 13.09'
% dfilt = 'pkva12';        %'pkva12 SNR 13.45' %'pkva SNR 13.48'
% nlevs = [0 4];    % Number of levels for DFB at each pyramidal level

Results_path='E:\MS(CS)\Others\Rida_Khalid_FAU\Results\Level_Based\PFILT';


if ~exist(Results_path, 'dir') 
    mkdir(Results_path) 
end

pfilt_all ={'coif1','bior6.8','9-7','5-3','Burt','pkva','sym2','rbio1.1','fk4','db1'};

dfilt_all={'pkva6','pkva12','pkva8'};

nlevs_all = {[0 4], [0 0 4 4 5 ],[0 0 3 3 5],[0 0 2 2 5],[0 5],[0 4]};

threshold_all={'7/9','4/3','2/3','0.7'};

th = 3;                     % lead to 3*sigma threshold denoising
rho = 3;                    % noise level
image_path='E:\MS(CS)\Others\Rida_Khalid_FAU\contourlet\dataset\1.jpg';
[bpath,bname,bext]=fileparts(image_path);

im = imread(image_path);
% mandrill.jpg

% cd(code_pth)
if isequal(size(im,3),3)
im = rgb2gray(im);
else
end

pfilt_count=length(pfilt_all);
dfilt_count=length(dfilt_all);
nlevs_count=length(nlevs_all);
threshold_count=length(threshold_all);
total_possibilities=pfilt_count*dfilt_count*nlevs_count*threshold_count

im = double(im) / 256;

%% Generate noisy image. 
sig = std(im(:));
sigma = sig / rho;
nim = im + sigma * randn(size(im));

% sig=100; 
% V=(sig/256)^2;
% 
% nim=imnoise(im,'gaussian',0,V)



DS_iter=1;

for iii=1:length(pfilt_all)
    for jjj=1:length(dfilt_all)
        for kkk=1:length(nlevs_all)
            for lll=1:length(threshold_all)
                
            pfilt=char(pfilt_all(1,iii));
            dfilt=char(dfilt_all(1,jjj));
            nlevs=cell2mat(nlevs_all(1,kkk));
            threshold=cell2mat(threshold_all(1,lll));
%  disp(['Combination (',num2str(loop_count),') ', pfilt,' ',dfilt,' (',num2str(nlevs),')']);

%% Contourlet Denoising %%%%%
% Contourlet transform
% % % Pyramidal Directional Filter Bank (or Contourlet) 
%%  Decomposition
tic
coeffs = pdfbdec(nim, pfilt, dfilt, nlevs);

% coeffs_im = pdfbdec(im, pfilt, dfilt, nlevs);

%% Display the coefficients
% disp('Displaying the contourlet coefficients...') ; 
% imcoeff = showpdfb( coeffs,'auto2','vb','2','6','abs' ) ;
% title('Contourlet coefficients');
% % input('Press Enter key to continue...' ) ;
% disp(' ');

% shownsct( coeffs ) ;

%% Plotting Coefiicients

% pdfb_nla = cell(1, 4);
% range = [0, 0.002];
% scale = 1;
% for k = 1:4
%     pdfb_nla{k} = pdfbrec(pdfb_tr(coeffs, scale, 0, 4^k), pfilt, dfilt);
% end

% figure(22)
% clf;
% set(gcf, 'Name', 'Contourlets')
% for k = 1:4,
%     subplot(2,2,k),
%     imagesc(pdfb_nla{k}, range), axis image, axis off
%     str = sprintf('M = %d', 4^k);
%     title(str);
% end
% colormap('gray(256)')

%%  Display information
% nPixels = prod( size(im) );             % number of pixels
% nCoeffs = length(pdfb2vec(coeffs));     % number of PDFB coefficients
% 
% disp( sprintf('Number of image pixels is %d', nPixels) ) ;
% disp( sprintf('Number of coefficients is %d', nCoeffs) ) ;
% nSignif = round(nPixels * 1/64) ;
% disp( sprintf( 'It will keep %d significant coefficients', nSignif ) ) ;

%% Truncate to only the nSignif most significant coefficients
% nla_coeffs = pdfb_tr(coeffs, 0, 0, nSignif);
% 
% disp('Displaying the position of the retained coefficients...') ;
% figure
% showpdfb( nla_coeffs, nSignif ) ;
% title('Retained coefficients');
% input('Press Enter key to continue...' ) ;
% disp(' ');



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
cth = threshold* th * sigma * sqrt(nvar);
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

% figure('Name','Reconstructed Contourlet Coefficients')
% disp('Displaying the Reconstructed contourlet coefficients...') ; 
% imcoeff_r = showpdfb( coeffs_recons,'auto2','vb','2','6','abs' ) ;
% title('Contourlet Reconstructed contourlet coefficients');
% % input('Press Enter key to continue...' ) ;
% disp(' ');

%% Pyramid Directional Filterbank Reconstruction
cim = pdfbrec(coeffs_recons, pfilt, dfilt);
timetaken=toc;
% disp(['Time Taken -               ',num2str(timetaken)]);
% %%%%% Plot: Only the hat!
% range = [0, 1];
% figure(3)
% subplot(1,3,1), imshow(im); axis image off
% set(gca, 'FontSize', 8);
% title('Original Image', 'FontSize', 10);
% 
% subplot(1,3,2), imshow(nim); axis image off
% set(gca, 'FontSize', 8);
% title(sprintf('Noisy Image (SNR = %.2f dB)', ...
%               SNR(im, nim)), 'FontSize', 10);
% 
% subplot(1,3,3), imshow(cim); axis image off
% set(gca, 'FontSize', 8);
% title(sprintf('Contourlets (SNR = %.3f dB)', ...
%               SNR(im, cim)), 'FontSize', 10);
% 
% colormap('gray');

res_SNR=SNR(im, cim);
% res_SNR=SNR_new(cim);

% disp(['SNR -                      ',num2str(res_SNR)]);

% imwrite(cim,'denoise.jpg')
%% Performance Evaluation
% Contourlet Based Results
[res_mse,res_mae,res_SSNR,res_PSNR,res_cross_core,res_FSIM,res_ssimval,res_STDV_denoised,res_var_denoised,res_AD,res_MD,res_NAE,res_NCC,res_SC]=fun_evaluate_denoising_metrics(im,cim);
[res_PSNR, res_SNR] = psnr(cim,im);


results_cell(DS_iter,1)=res_SNR;
results_cell(DS_iter,2)=res_mse;
results_cell(DS_iter,3)=res_mae;
results_cell(DS_iter,4)=res_SSNR;
results_cell(DS_iter,5)=res_PSNR;
results_cell(DS_iter,6)=res_cross_core;
results_cell(DS_iter,7)=res_FSIM;
results_cell(DS_iter,8)=res_ssimval;
results_cell(DS_iter,9)=res_STDV_denoised;
results_cell(DS_iter,10)=res_var_denoised;
results_cell(DS_iter,11)=res_AD;
results_cell(DS_iter,12)=res_MD;
results_cell(DS_iter,13)=res_NAE;
results_cell(DS_iter,14)=res_NCC;
results_cell(DS_iter,15)=res_SC;
results_cell(DS_iter,16)=timetaken;
results_cell_name{DS_iter,1}=bname;
%% Plotting Histograms
% figure('Name','Histogram')
% subplot(131),histogram(im),title('Hist of Input Img');
% subplot(132),histogram(nim),title('Hist of Noised Img');
% subplot(133),histogram(cim),title('Hist of Contourlet Based Denoised Img');
disp(['Combination (',num2str(DS_iter),') ', pfilt,' ',dfilt,' (',num2str(nlevs),') Th->',num2str(threshold) ,'', ' --SNR->', num2str(res_SNR)]);
results_desc_cell{DS_iter,1}=DS_iter;
results_desc_cell{DS_iter,2}=pfilt;
results_desc_cell{DS_iter,3}=dfilt;
results_desc_cell{DS_iter,4}=nlevs;
results_desc_cell{DS_iter,5}=threshold;

DS_iter=DS_iter+1;
            end
   end
    end
end
fprintf('Code Ended at  %s\n', datestr(now,'HH:MM:SS'))

results_table=table();
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


results_desc_table=table();
results_desc_table.Combination=results_desc_cell(:,1);
results_desc_table.PFILT=results_desc_cell(:,2);
results_desc_table.DFILT=results_desc_cell(:,3);
results_desc_table.No_Of_Levels=results_desc_cell(:,4);
results_desc_table.Threshold=results_desc_cell(:,5);

cd(Results_path)
filename1 = [bname, '_Results_.xlsx'];

writetable(results_table,filename1,'Sheet','Results','Range','D1')
writetable(results_desc_table,filename1,'Sheet','Results_Description','Range','D1')
