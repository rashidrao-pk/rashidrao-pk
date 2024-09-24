clear all; close all; clc;

I=imread('tire.tif');
I = imresize(I,[512 512]);

img_blocks = mat2cell(I,[64 64 64 64 64 64 64 64],[64 64 64 64 64 64 64 64]);
new_blocks = img_blocks;
for col=1:8
    for row=1:8
        new_blocks{row,col} = histeq(img_blocks{row,col});
    end
end
% cell 2 mat
newImg = cell2mat(new_blocks);
figure
subplot(1,3,1), imshow(I), title('original');
subplot(1,3,2), imshow(newImg), title('new Image');
% [B64,hgram64]   = imhistmatch(double(newImg),double(I),64); 
a = reshape(newImg,[],1);

subplot(1,3,3), imshow(a), title('new Image');

