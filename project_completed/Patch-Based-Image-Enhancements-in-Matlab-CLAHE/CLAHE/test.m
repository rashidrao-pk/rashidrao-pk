clear all; close all; clc;

I=imread('tire.tif');
I = imresize(I,[256 256]);
[XRes,YRes]=size(I);
Min=0;
Max=255;
NrX=1;
NrY=1;
NrBins=128;
Cliplimit=2;
NrBins=max(NrBins,128);
XSize = round(XRes/NrX);
YSize = round(YRes/NrY);
NrPixels = XSize*YSize;
CEImage = zeros(XRes,YRes);


% img_blocks = mat2cell(I,[64 64 64 64 64 64 64 64],[64 64 64 64 64 64 64 64]);
img_blocks = mat2cell(I,[64 64 64 64],[64 64 64 64]);

new_blocks = img_blocks;


for col=1:4
 for row=1:4
  new_blocks{row,col} = histeq(img_blocks{row,col});
  new_blocks2{row,col} = fun_interpolate(img_blocks{row,col},XRes,YRes,Min,Max,NrX,NrY,NrBins,Cliplimit);
 end
end
% cell 2 mat
newImg = cell2mat(new_blocks);
newImg2 = cell2mat(new_blocks2);

figure
subplot(1,3,1), imshow(I), title('original');
% subplot(1,3,2), imshow(newImg), title('new Image');
% [B64,hgram64]   = imhistmatch(double(newImg),double(I),64); 
% % a = interpolate(newImg,[],1);

subplot(1,3,3), imshow(uint8(newImg2)), title('new Image');

