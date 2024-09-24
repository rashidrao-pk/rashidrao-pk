% DENOISEDEMO   Denoise demo
% Compare the denoise performance of wavelet and contourlet transforms
% Note: Noise standard deviation estimation of PDFB (function pdfb_nest) 
% can take a while...
close all
clc
clear all
%% Parameters

% pfilt =  'coif5';   %'bior6.8 SNR 13.39';  %'coif5' SNR 13.46;   %'9-7; SNR 13.09'
% dfilt = 'pkva12';        %'pkva12 SNR 13.45' %'pkva SNR 13.48'
% nlevs = [0 4];    % Number of levels for DFB at each pyramidal level
pfilt_all ={'coif1','coif5','bior6.8','9-7','5-3','Burt','pkva','sym2','rbio1.1','fk4','db1'};
dfilt_all={'pkva6','pkva12','pkva8','pkva'};
nlevs_all = {[0 4], [0 0 4 4 5 ],[0 0 3 3 5],[0 0 2 2 5],[0 5],[0 4]};

th = 3;                     % lead to 3*sigma threshold denoising
rho = 3;                    % noise level

im = imread('E:\MS(CS)\Others\Rida_Khalid_FAU\contourlet\dataset\zoneplate.png');
% mandrill.jpg

% cd(code_pth)
if isequal(size(im,3),3)
im = rgb2gray(im);
else
end

pfilt_count=length(pfilt_all);
dfilt_count=length(dfilt_all);
nlevs_count=length(nlevs_all);
total_possibilities=pfilt_count*dfilt_count*nlevs_count;

im = double(im) / 256;

%% Generate noisy image. 
sig = std(im(:));
sigma = sig / rho;
nim = im + sigma * randn(size(im));
loop_count=1;
for iii=1:length(pfilt_all)
    for jjj=1:length(dfilt_all)
        for kkk=1:length(nlevs_all)
pfilt=char(pfilt_all(1,iii));
dfilt=char(pfilt_all(1,jjj));
nlevs=cell2mat(nlevs_all(1,kkk));


 disp(['Combination (',num2str(loop_count),') ', pfilt,' ',dfilt,' (',num2str(nlevs),')']);
loop_count=loop_count+1;
        end
    end
end