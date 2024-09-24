%% Main Function To Use complete Inpainting
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.

mainpath=cd;
datasetpath='D:\Study\MS(CS)\Others\Ammara_Polyp\Datasets\CVC-ClinicDB\Original';
cd(datasetpath)

[filename1,pathname1]=uigetfile('*.*');
%% Back to Path where codes are
cd(mainpath)
rgbImage=imread([pathname1,filename1]);
% figure,
% subplot(331),
imshow(rgbImage),title(' Input Image');

[bpath,bfile,bext]=fileparts(filename1);

filename1=[bfile,'.jpg'];

%%  Call to Specular Refection Detection Module
binaryImage = sp_ref_detection(rgbImage);
%%  Call to Post Processing Module for getting specular ready for inpainting
[binaryImage_new,binary_processed,minused_img]= post_processing(binaryImage);
%%  Call to Inpainting Method
inpaintedImg1=inpainting_setup(rgbImage,binary_processed);
inpaintedImg2=inpainting_setup(rgbImage,binaryImage_new);


% Displaying Outputs
figure,
subplot(331),imshow(rgbImage),title(' Input Image');
subplot(332),imshow(binaryImage),title(' Reflection Detection');
subplot(333),imshow(binary_processed),title(' Post Processed');
subplot(334),imshow(minused_img),title(' Biggest Blob');
subplot(335),imshow(binaryImage_new),title(' Post Processed New');
subplot(336),imshow(inpaintedImg1),title(' Inpainted Image 1');
subplot(338),imshow(inpaintedImg2),title(' Inpainted Image 2');
