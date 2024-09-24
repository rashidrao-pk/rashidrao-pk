% %  Clear All exisitng Workspace Variable (if any)
% %  closing all opened figure (if any)
% %  clearing all line in the command window and showing workspace tab if
% not existing 
clear all; clc; close all; workspace;
% Getting System Type
system= fun_checking_system;

% %  Inputting Dataset Path
Current_Path=cd;
cd ..
cd lesionimages
Dataset_Root=cd;
Dataset_Path = fullfile(Dataset_Root, 'lesionimages');

Segmentation_Accuracy_limit=80;
   
if ~exist([Dataset_Root,'\Results'], 'dir')
        mkdir([Dataset_Root,'\Results']);
        mkdir([Dataset_Root,'\Results\benign']);
        mkdir([Dataset_Root,'\Results\malignant']);
end
if ~exist([cd,'\Results\segmentation_flow'], 'dir')
        mkdir([cd,'\segmentation_flow']);
end
Save_Path=fullfile(Dataset_Root, 'Results');

txt_file_failed=[fullfile(Dataset_Root), '\000_FailCases.txt'];
txt_file_success=[fullfile(Dataset_Root), '\000_Segmented.txt'];
        if exist(txt_file_failed, 'file')==2
        delete(txt_file_failed);
        end
        if exist(txt_file_success, 'file')==2
        delete(txt_file_success);
        end
        GroundTruth_Desc = readtable(fullfile(Dataset_Root,'groundtruth.txt'), 'ReadVariableNames', false);
%
Resized_Img_Size=[256,256];
% Creating Image Datastore which will hold all images in the provided path
imds_Lesion_Images = imageDatastore(fullfile(Dataset_Path));
GroundTruth_Path = fullfile(Dataset_Root, 'masks');
imds_GTruth_Image = imageDatastore(fullfile(GroundTruth_Path));
%  Calculating the Length of the folder (Total images in each folder)
[rows_lesn col_lesn]=size(imds_Lesion_Images.Files);

for ii=1:rows_lesn
    a(ii,1)=imds_Lesion_Images.Files(ii,1);
    aa=cell2mat(a(ii,1));
    img1=imread(aa);
    %% Pre-Processing Phase
    % Image resize to make all images uniform            
    img1=imresize(img1,Resized_Img_Size);
    % Contrast Enhacment using strecth limit function
    img3 = imadjust(img1,stretchlim(img1),[]);
%   Converting RGB image to Y,Cb,Cr ColorSpace to get good results for segmentation
    img4=rgb2ycbcr(img3);
    %%  Saliancy Based Segmenttation
    cd(Current_Path)
    seg_stock = fun_saliency_map(img3);
    %% Post Processing to Refine Segmented Image
    seg=imclearborder(seg_stock,8);
    seg = bwareaopen(seg, 20);
    windowSize = 1;
    kernel = ones(windowSize) / windowSize ^ 2;
    Smoothed_Img = conv2(single(seg), kernel, 'same');
    seg = Smoothed_Img > 0.56; % Rethreshold
    % Filling Holes if any
    seg=imfill(seg,'holes');
    se = strel('disk',3);
    seg = imdilate(seg,se);
    
    %%% Cutting RGB using Binary Image
    finalImg = repmat(seg,[1 1 3]) .* im2double(img1);
        % % % % % % % % % % % %    
%      Getiing Filenames from Input RGB image and the mask (GroundTruth) Image
    filename1=cell2mat(imds_Lesion_Images.Files(ii,1));
    filename2=cell2mat(imds_GTruth_Image.Files(ii,1));
%  reading GT Image and converting to binary image
    gtruth=imread(filename2);
    gtruth=im2bw(gtruth);
    [rows_seg,col_seg]=size(seg);
% %  Resizinig GTruth and RGB Image according to each other size
    gtruth=imresize(gtruth, [rows_seg,col_seg]);
    img2 = imresize(img1, [rows_seg,col_seg]);
%% Evaluating Segmentation Accuracy by Calling Function
    accuracy = fun_evaluate_segmentation(seg,gtruth);

  %% Writing Segmentation Accuracy File
    [bpath1,bname1,bext1] = fileparts(filename1);
    d{1,1}=bname1;
    d{1,2}=",";
    d{1,3}=accuracy;
    file1=join([string(d),'\n']);

    % Checking Segmentation Accuracy Limit
    if(accuracy>=Segmentation_Accuracy_limit)
    %     if segmentation accuracy is higher than limit (i.e. 80%) then saving
    %     segemented image to create segmented dataset    
        cd(Dataset_Root)
        fid = fopen('000_Segmented.txt','a');
        fprintf(fid, file1);
        fclose(fid);
        cd(Dataset_Root)
        cd Results
        % imwrite(img2,['1_',bname1,bext1],'jpg');
        % imwrite(img3,['2_',bname1,bext1],'jpg');
        % imwrite(seg,['3_',bname1,bext1],'jpg');
        %% getting the Image class lable using provided GroundTruth.txt file
        u = GroundTruth_Desc(strcmp(GroundTruth_Desc.Var1, bname1), :);
        class_label=cell2mat(u.Var2);
        % %  Setting retrived Class Label as to save the segmented iamge
        cd(class_label)
        imwrite(finalImg,[bname1,bext1],'jpg');

        cd(Dataset_Root)
        cd segmentation_flow
%         imwrite(img1,['1_',bname1,bext1],'jpg');
%         imwrite(img3,['2_',bname1,bext1],'jpg');
%         imwrite(img4,['3_',bname1,bext1],'jpg');
%         imwrite(seg_stock,['4_',bname1,bext1],'jpg');
%         imwrite(seg,['5_',bname1,bext1],'jpg');
%         imwrite(finalImg,['6_',bname1,bext1],'jpg');
%         imwrite(gtruth,['7_',bname1,bext1],'jpg');

%       Showing Segmentation Results in the form of figure
        figure(1),
        subplot(2,3,1),imshow(img2),title('Input Image');
        subplot(2,3,2),imshow(img3),title('Pre Processed Image');
        subplot(2,3,3),imshow(seg),title('Segmented BW');
        subplot(2,3,4),imshow(gtruth),title('GroundTruth BW');
        subplot(2,3,5),imshow(finalImg),title('Segmented RGB');
        
        [B,L] = bwboundaries(seg,'noholes');
        [B1,L1] = bwboundaries(gtruth,'noholes');
    figure(2),
    imshow(img1),title([num2str(accuracy) ,' - > ', num2str(bname1)]);
    hold on
    for k = 1:length(B)
       boundary = B{k};
       plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2)
    end
    hold on
    for k = 1:length(B1)
       boundary = B1{k};
       plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
    end
            gcf_file_name=['8_',bname1,bext1];
            saveas(gcf,gcf_file_name)
       
% %     Showing Segmentation Results in Command Window
        disp([num2str(ii),'/',num2str(rows_lesn),' - ',...
            num2str(bname1),' -> ',num2str(accuracy) ,'%'])
    else
        cd(Dataset_Root)
        
        fid = fopen('000_FailCases.txt','a');
        fprintf(fid, file1);
        fclose(fid);
        disp([num2str(ii),'/',num2str(rows_lesn),' - ',...
            num2str(bname1), ' -> Less than limit, so using mask ']);
        u = GroundTruth_Desc(strcmp(GroundTruth_Desc.Var1, bname1), :);
        class_label=cell2mat(u.Var2);

        seg =   gtruth;
        finalImg = repmat(seg,[1 1 3]) .* im2double(img1);
        cd(Dataset_Root)
        cd Results
        % imwrite(img2,['1_',bname1,bext1],'jpg');
        % imwrite(img3,['2_',bname1,bext1],'jpg');
        % imwrite(seg,['3_',bname1,bext1],'jpg');
        cd(class_label)
        imwrite(finalImg,[bname1,bext1],'jpg');

        cd(Dataset_Root)
        cd segmentation_flow
%         imwrite(img1,['1_',bname1,bext1],'jpg');
%         imwrite(img3,['2_',bname1,bext1],'jpg');
%         imwrite(img4,['3_',bname1,bext1],'jpg');
%         imwrite(seg_stock,['4_',bname1,bext1],'jpg');
%         imwrite(seg,['5_',bname1,bext1],'jpg');
%         imwrite(finalImg,['6_',bname1,bext1],'jpg');
%         imwrite(gtruth,['7_',bname1,bext1],'jpg');
       
%     Showing Figures
        figure(1),
        subplot(221),imshow(img2),title('Input Image');
        subplot(222),imshow(img3),title('Pre Processed Image');
        subplot(223),imshow(seg),title('Maasked BW');
        subplot(224),imshow(finalImg),title('Masked RGB');
        [B,L] = bwboundaries(seg,'noholes');
    figure(3),
    imshow(img1),title(bname1);
    hold on
    for k = 1:length(B)
       boundary = B{k};
       plot(boundary(:,2), boundary(:,1), 'YES', 'LineWidth', 2)
    end
   
        gcf_file_name=['8_',bname1,bext1];
        saveas(gcf,gcf_file_name)
   
    end
end