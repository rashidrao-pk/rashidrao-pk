
clc; close all; clear all; clear
addpath(genpath('./'));
%%
filename = '1.bmp';
L = imresize(im2double(imread(filename)),1);
%% New Techinque
L2=L;
% L2=main_dehase(L);
% L2 = histeq(L2);
 L2 = imadjust(L2,stretchlim(L2),[]);
 adeq1 = adapthisteq(L2(:,:,1));
 adeq2 = adapthisteq(L2(:,:,2));
 adeq3 = adapthisteq(L2(:,:,3));
%  
adeq1=wiener2(L2(:,:,1),[10 10]);
adeq2=wiener2(L2(:,:,2),[10 10]);
adeq3=wiener2(L2(:,:,3),[10 10]);

 adeq= cat(3, adeq1, adeq2, adeq3);
 adeq = imsharpen(adeq,'Radius',2,'Amount',1);
  L2 = adeq;
 %% Deconv Module
%  opts=get_opts();
%  [blur, deblur, kernel, opts] = ms_blind_deconv(adeq, opts);
%  figure(1),subplot(221),imshow(L);
%  figure(1),subplot(222),imshow(adeq);
%  figure(1),subplot(223),imshow(deblur);
%  figure(1),subplot(224),imshow(adeq);
 %%
 

 
 
%--------------------------------------------------------------
post = false; % Denoising?

para.lambda = .15; % Trade-off coefficient
% Although this parameter can perform well in a relatively large range, 
% it should be tuned for different solvers and weighting strategies due to 
% their difference in value scale. 

% Typically, lambda for exact solver < for sped-up solver
% and using Strategy III < II < I
% ---> lambda = 0.15 is fine for SPED-UP SOLVER + STRATEGY III 
% ......


para.sigma = 2; % Sigma for Strategy III
para.gamma = 0.7; %  Gamma Transformation on Illumination Map
para.solver = 1; % 1: Sped-up Solver; 2: Exact Solver
para.strategy = 3;% 1: Strategy I; 2: II; 3: III

%---------------------------------------------------------------
tic
[I, T_ini,T_ref] = LIME(L,para);
toc
[L_row,L_col,L_chan]=size(L);
L2=imresize(L2,[L_row,L_col]);
final=New_PSNR(L);
final1=New_PSNR(I);

tic
[I2, T_ini2,T_ref2] = LIME(L2,para);
toc
% I2=hsv2rgb(I2);

final2=New_PSNR(I2);

figure(1);subplot(221),imshow(L);title(['Input  ', num2str(final(1,1))]);
figure(1);subplot(223),imshow(I);title(['Lime  ', num2str(final1(1,1))]);
figure(1);subplot(224),imshow(I2);title(['Lime New  ', num2str(final2(1,1))]);
%%
C = cov([I(:) I2(:)]);
[V, D] = eig(C);
if D(1,1) >= D(2,2)
  pca = V(:,1)./sum(V(:,1));
else  
  pca = V(:,2)./sum(V(:,2));
end

% fusion
imf = pca(1)*I + pca(2)*I2;
%%
final3=New_PSNR(imf);

figure(1);subplot(222), imshow(imf,[]); title(['Fused  ', num2str(final3(1,1))]);
%%
Comparison=table();
Comparison.LIME=final1(1,1);
Comparison.LIME_Enhanced=final2(1,1);
Comparison.LIME_Fused=final3(1,1);

final1(1,1)
final2(1,1)
%% Post Processing
if post
YUV = rgb2ycbcr(I);
Y = YUV(:,:,1);

sigma_BM3D = 10;
[~, Y_d] = BM3D(Y,Y,sigma_BM3D,'lc',0);

I_d = ycbcr2rgb(cat(3,Y_d,YUV(:,:,2:3)));
I_f = (I).*repmat(T_ref,[1,1,3])+I_d.*repmat(1-T_ref,[1,1,3]);

figure(2);imshow(I_d);title('Denoised ');
figure(3);imshow(I_f);title('Recomposed');
end
