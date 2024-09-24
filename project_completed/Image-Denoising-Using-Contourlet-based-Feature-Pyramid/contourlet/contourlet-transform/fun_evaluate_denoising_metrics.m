function [mse,mae,SSNR,PSNR,cross_core,FSIM,ssimval,STDV_denoised,var_denoised,AD,MD,NAE,NK,SC] = fun_evaluate_denoising_metrics(input,denoisy)
%% CREDITS %%
% This Code development took struggles of many hours
% Kindly cite us or refer us if use this code
% Credits : Rashid Rao (Rashidcui@ciitwah.edu.pk)
% Comsats University Islamabad, Wah Campus
% https://scholar.google.com.pk/citations?user=F5u_Z5MAAAAJ&hl=en
%%
%% MSE Mean squared error         -----     MSE
input=double(input);
denoisy=double(denoisy);
mse=0;
for i=1:length(input)
mse=mse+(denoisy(i)-input(i))^2;
end
mse=mse/length(input);
% fprintf('mean squared error         %0.3f\n',mse);
%MAE 
%% Mean absolute error  ------              MAE
mae=0;
for i=1:length(input)
mae=mae+abs(denoisy(i)-input(i));
end
mae=mae/length(input);
% fprintf('Mean Absolute Error        %0.3f\n',mae);
%SNR and PSNR 
%% signal to noise ratio                    SNR
num=0;
den=0;
for i=1:length(input)
den=den+(denoisy(i)-input(i))^2;
end
for i=1:length (input)
num=num+input(i)^2;
end
SSNR = 20*log10(sqrt(num)/sqrt(den));

%% Cross correlation    ------               CC
cc = corrcoef(denoisy,input);
cross_core = cc(1,2);
% fprintf('Cross Correlation          %0.3f\n',cross_core);

%% Feature Similarity Index                 (FSIM)
[FSIM, FSIMc] = fun_FeatureSIM(input, denoisy);
% fprintf('Feature Similarity Index   %0.3f\n',FSIM);

%% Structural Similarity                    (SSIM)
[ssimval,ssimmap] = ssim(input,denoisy);
% fprintf('Structural Similarity      %0.3f\n',ssimval);

%% Standard Deviation                       SD
STDV_denoised = std2(denoisy);
%% Variance
var_denoised = var(denoisy(:));
%%
origImg = double(input);
distImg = double(denoisy);
[M N] = size(origImg);
error = origImg - distImg;
%% Average Difference -------               AD
AD = sum(sum(error)) / (M * N);
%% Maximum Difference   -------             MD
MD = max(max(error));
%% Normalized Absolute Error   -------      NAE
NAE = sum(sum(abs(error))) / sum(sum(origImg));
%% Normalized Cross Corelation  -----       NCC
NK = sum(sum(origImg .* distImg)) / sum(sum(origImg .* origImg));
%% peak signal to noise ratio   -------     PSNR
MSE = sum(sum(error .* error)) / (M * N);
if(MSE > 0)
    PSNR = 10*log(255*255/MSE) / log(10);
else
    PSNR = 99;
end
%% StructuralContent    --------    SC
SC = sum(sum(origImg .* origImg)) / sum(sum(distImg .* distImg));
end