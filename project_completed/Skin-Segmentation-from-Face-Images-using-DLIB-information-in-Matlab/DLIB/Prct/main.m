close all
clear all
clc
cd D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\input
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');

img=imread([pathname,filename]); 
img=imresize(img,[256 256]);

R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);
[Lab_L,Lab_a,Lab_b] = RGB2Lab_S(R,G,B)

imshow(img);
salMat=saliencyMeasure({Lab_L,Lab_a,Lab_b});

binary1=im2bw(salMat,0.3);
% figure, imshow(binary1);
I = rgb2ycbcr(img);
channel1Min = 50.000;
channel1Max = 200.000;
% Define thresholds for channel 2 based on histogram settings
channel2Min = 50.000;
channel2Max = 200.000;
% Define thresholds for channel 3 based on histogram settings
channel3Min = 50.000;
channel3Max = 200.000;
% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;
% Initialize output masked image based on input image.
maskedRGBImage = img;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
se = strel('disk',6);
BW2 = imclose(BW,se);
BW3=bwareaopen(BW,20);
% figure,imshow(BW3);
fused1=BW3+binary1;
% figure,imshow(fused1);
fused2=fused1.*BW3;
% figure,imshow(fused2);
fused3=bwareaopen(fused2,100);
imshow(fused3);
maskedRGBImage = img;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~fused3,[1 1 3])) = 0;

subplot(231),imshow(img);
subplot(231),imshow([Lab_L,Lab_a,Lab_b]);
subplot(233),imshow(salMat);
subplot(234),imshow(binary1);
subplot(235),imshow(BW);
subplot(236),imshow(maskedRGBImage);

