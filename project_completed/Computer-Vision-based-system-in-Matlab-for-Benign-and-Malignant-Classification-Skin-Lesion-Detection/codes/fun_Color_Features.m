% clear all;
% clc;
% [filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
% I = imread([pathname,filename]);
function Final_Color= fun_Color_Features(I)
% Extract RGB Channel
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
%Transform RGB to HSV
IHSV= rgb2hsv(I);
%Extract HSV Channel
H= IHSV(:,:,1);
S=IHSV(:,:,2);
V=IHSV(:,:,3);
%Lab ccolor space transformation
ILab= rgb2lab(I);
%Extract LAB Channel
L=ILab(:,:,1);
a=ILab(:,:,2);
b=ILab(:,:,3);
% YCBCR Color Space transformation
YCBCR = rgb2ycbcr(I);
%Extract YcbCr Channel
Y = YCBCR(:,:,1);
cb = YCBCR(:,:,2);
cr = YCBCR(:,:,3);
% Extract Statistical features for RGB
% 1] MEAN
meanR=mean2(R);
meanG=mean2(G);
meanB=mean2(B);
% 2] Standard Deviation
stdR=std2(R);
stdG=std2(G);
stdB=std2(B);
% 3] Entropy
entropyR=entropy(R);
entropyG=entropy(G);
entropyB=entropy(B);
% 4] Skewness
skewnessR=skewness(im2double(R(:)));
skewnessG=skewness(im2double(G(:)));
skewnessB=skewness(im2double(B(:)));
% SVD
% SvdR=svd(R);
% SvdG=svd(G);
% SvdB=svd(B);
% SVD_V=SVD_V(1,:);
% SVD_H=SVD_H(1,:);
% SVD_S=SVD_S(1,:);
% Extract Statistical features for HSV
% 1] MEAN
meanH=mean2(H);
meanS=mean2(S);
meanV=mean2(V);
% 2] Standard Deviation
stdH=std2(H);
stdS=std2(S);
stdV=std2(V);
% 3] Entropy
entropyH=entropy(H);
entropyS=entropy(S);
entropyV=entropy(V);
% 4] Skewness
skewnessH=skewness(im2double(H(:)));
skewnessS=skewness(im2double(S(:)));
skewnessV=skewness(im2double(V(:)));

% SvdH=svd(H);
% SvdS=svd(S);
% SvdV=svd(V);
% Extract Statistical features for Lab
% 1] MEAN
meanL=mean2(L);
meana=mean2(a);
meanb=mean2(b);
% 2] Standard Deviation
stdL=std2(L);
stda=std2(a);
stdb=std2(b);
% 3] Entropy
entropyL=entropy(L);
entropya=entropy(a);
entropyb=entropy(b);
% 4] Skewness
skewnessL=skewness(im2double(L(:)));
skewnessa=skewness(im2double(a(:)));
skewnessb=skewness(im2double(b(:)));
% Extract Statistical features for YcbCr
% 1] MEAN
meanY=mean2(Y);
meancb=mean2(cb);
meancr=mean2(cr);
% 2] Standard Deviation
stdY=std2(Y);
stdcb=std2(cb);
stdcr=std2(cr);
% 3] Entropy
entropyY=entropy(Y);
entropycb=entropy(cb);
entropycr=entropy(cr);
% 4] Skewness
skewnessY=skewness(im2double(Y(:)));
skewnesscb=skewness(im2double(cb(:)));
skewnesscr=skewness(im2double(cr(:)));
%Feature Vector
Color_Feature_Set = [meanR meanG meanB meanH meanS meanV meanL meana meanb meanY meancb meancr stdR stdG stdB stdH stdS stdV stdL stda stdb stdY stdcb stdcr entropyR entropyG entropyB entropyH entropyS entropyV entropyL entropya entropyb entropyY entropycb entropycr skewnessR skewnessG skewnessB skewnessH skewnessS skewnessV skewnessL skewnessa skewnessb skewnessY skewnesscb skewnesscr];
Final_Color = [Color_Feature_Set];
% plot(Final_Color);
end