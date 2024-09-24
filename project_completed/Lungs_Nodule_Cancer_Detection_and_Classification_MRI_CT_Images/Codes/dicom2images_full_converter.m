%% dicom2images_full_converter
%% u_827e007718b5
%% Lungs Cancer
clear all
close all
clc
workspace;

ccurr_path=cd;
mri_main='F:\Datasets\Lungs\APOLLO-5-LUAD\AP-78LL\07-27-1977-NA-CT CHEST W-O CON-49429';

folder = uigetdir(mri_main,'');
folder_name=split(folder,'\');
folder_name=folder_name{7, 1};

jpeg_dataset= ['E:\MS(CS)\Others\Online\Fiverr\u_827e007718b5_lungs\',folder_name];

mri_dataset_path = fullfile ([mri_main,'\',folder_name]);


S = dir(fullfile(mri_dataset_path,'*.dcm'));
S2=struct2table(S);

total_dicom_images=size(S,1);
 if ~exist(jpeg_dataset, 'dir')
       mkdir(jpeg_dataset)
 else
     disp('Folder ALready Exist');
 end
for i=1:total_dicom_images
image_path=[char(S2.folder(i,1)) '\' char(S2.name(i,1))];
[~,bname,~]=fileparts(char(S2.name(i,1)));

X = dicomread(image_path);
% info=dicominfo(image_path);


jpg_image = uint8(255 * mat2gray(X)); %Convert to uint8 format

jpg_image=imadjust(jpg_image);
imshow(jpg_image),title('Converted Input Img');

cd(jpeg_dataset)
imwrite(jpg_image, [jpeg_dataset '\' bname '.jpg'],'jpg');
end






