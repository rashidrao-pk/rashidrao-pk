clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.

outputFolder='D:\Study\MS(CS)\Others\Ammara_Polyp\Datasets\Other_Dataset\CVC-ColonDB';
rootFolder = fullfile(outputFolder, 'CVC-ColonDB');
results_path='D:\Study\MS(CS)\Others\Ammara_Polyp\Datasets\Other_Dataset\CVC-ColonDB\Inpainting_Res';
allfoldernames= struct2table(dir(rootFolder));
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
clear i
categories=new;
allfoldernames= struct2table(dir(rootFolder));
imds1 = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
[r c]=size(imds1.Files);
mainpath=cd;
for i=1:r
    a(i,1)=imds1.Files(i,1);
    aa=cell2mat(a(i,1));
    rgbImage = imread(aa);

[bpath,bname,bext]=fileparts(aa);
filename1=[bname,'.jpg'];
cd(mainpath);
% figure,subplot(221),imshow(rgbImage),title(' Input Image');
%%  Call to Specular Refection Detection Module
binaryImage = sp_ref_detection(rgbImage);
%%  Call to Post Processing Module for getting specular ready for inpainting
[binaryImage_new,binary_processed,minused_img]= post_processing(binaryImage);
%%  Call to Inpainting Method
inpaintedImg1=inpainting_setup(rgbImage,binary_processed);
inpaintedImg2=inpainting_setup(rgbImage,binaryImage_new);


% Displaying Outputs
% subplot(331),imshow(rgbImage),title(' Input Image');
% subplot(332),imshow(binaryImage),title(' Reflection Detection');
% subplot(333),imshow(binary_processed),title(' Reflection Detection');
% subplot(334),imshow(minused_img),title(' Biggest Blob');
% subplot(335),imshow(binaryImage_new),title(' Post Processed Binary Image ');
% subplot(336),imshow(inpaintedImg1),title(' Inpainted Image 1');
% subplot(338),imshow(inpaintedImg2),title(' Inpainted Image 2');

% 
% 
%% Saving Inpainted Image 
cd(results_path)
cd Inptd_1
imwrite(inpaintedImg1,['In_',filename1],'jpg');

cd(results_path)
cd Inptd_2
imwrite(inpaintedImg2,['In_',filename1],'jpg');

cd(results_path)
cd reflection
imwrite(binaryImage,['Ref_',filename1],'jpg');

cd(results_path)
cd post_processed
imwrite(binaryImage_new,['post_',filename1],'jpg');

close all
subplot(321),imshow(rgbImage),title('Input Image');
subplot(322),imshow(binaryImage),title('Specular Reflection Detection');
subplot(323),imshow(binaryImage_new),title('Post Processed');
subplot(324),imshow(minused_img),title('Largest Area Than 2000');
subplot(325),imshow(inpaintedImg1),title('Inpainted Image 1');
subplot(326),imshow(inpaintedImg2),title('Inpainted Image 2');

cd(results_path)
cd complete
fff=['Full_',filename1];
saveas(gcf,fff)
disp(['Done File-> ',filename1]);
% 
%% Results Evaluation
% [peaksnr, snr] = psnr(inpaintedImg1,rgbImage);
% fprintf('\n The Peak-SNR value is %0.2f', peaksnr);
% fprintf('\n The SNR value is %0.2f \n', snr);
end