% 
close all;
clear all
clc
pth=cd;
Detect_path='D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\DLIB';
folder_name='input';

rootFolder = fullfile('D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\', folder_name);
success_count=1;
fail_count=1;
imageDS=imageDatastore(rootFolder);
for start=1:size(imageDS.Files)
close all
    file=imageDS.Files{start,1};
[in_path,in_file,in_ext]=fileparts(file);
rgb=imread(file);
% rgb=imresize(rgb,[256,256]);
gray = rgb2gray(rgb);
if (folder_name=='Face1')
    pth_selected=' D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\Final_Saved\1';
    elseif (folder_name=='Face2')
    pth_selected=' D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\Final_Saved\2';
    elseif (folder_name=='input')
    pth_selected=' D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\Final_Saved\3';
    else
end
%% DLIB
cd(Detect_path)
h = detector('new', 'D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\shape_predictor_68_face_landmarks.dat');
f = detector('detect', h, rgb);
m = detector('mean_shape', h);
params = initroi(m, [64, 64], [0.25, 0.6], [0.75, 0.9], 'similarity');
r = zeros(size(f, 1), 64, 64, 3, 'uint8');
s = zeros(size(f, 1), 68, 2);
for i = 1:size(f, 1)
    s(i, :, :) = detector('fit', h, rgb, f(i, :));
    r(i, :, :, :) = extractroi(rgb, s(i, :, :), params);
end
% show face detections and alignments
if( isempty(f)==1)
results_failed{fail_count,1}=in_file;
results_failed{fail_count,2}=0;
fail_count=fail_count+1;
else
  results_success{success_count,1}=in_file;
  results_all{success_count,1}=in_file;
  rgb_cropped = imcrop(rgb,[f(1,1),f(1,2),f(1,3)-f(1,1),f(1,4)-f(1,2)]);
  rgb_cropped_gray=rgb2gray(rgb_cropped);
  
  
%% ITA Equation
ITA=fun_get_ITA(rgb,0,'f')

lab=rgb2lab(rgb);
Lab_L = lab(:,:,1);
Lab_a = lab(:,:,2);
Lab_b = lab(:,:,3);
%% Averaging Filter
windowSize = 20; 
b= ones(windowSize,1) / windowSize;
ITA_smooth=filter(b,1,ITA);


cd(pth_selected)
% saveas(gcf,['1_',in_file,'.jpg']);
% % % % % % % % % % % % % % % % % % % % % % % % 
figure(1),imshow(gray),title('Gray Image with Parts Plotted');
hold on; axis on;
for i = 1:size(f, 1)
    x = [f(i, 1), f(i, 3), f(i, 3), f(i, 1), f(i, 1)];
    y = [f(i, 2), f(i, 2), f(i, 4), f(i, 4), f(i, 2)];
    plot(x, y, '-r');
    for j=1:68
        box_x(j,1)=s(i, j, 1);
        box_y(j,1)=s(i, j, 2);
    end
    
end

box_x=box_x';
box_y=box_y';
cd(pth)
[box_cheek_right,box_cheek_left]=get_cheeckbox(box_x,box_y);
box_chin=get_chinbox(box_x,box_y);
box_forehead=get_foreheadbox(box_x,box_y,x,y);
% mask = box_cheek_right;
% rgb_cropped = imcrop(rgb,[f(1,1),f(1,2),f(1,3)-f(1,1),f(1,4)-f(1,2)]);
%% Polygon Draw
cheek_right_ploy = polyshape(box_cheek_right(1,:),box_cheek_right(2,:));
cheek_left_ploy = polyshape(box_cheek_left(1,:),box_cheek_left(2,:));
chin_ploy = polyshape(box_chin(1,:),box_chin(2,:));
forehead_ploy = polyshape(box_forehead(1,:),box_forehead(2,:));

%% Polygon Plot
plot(cheek_right_ploy);
plot(cheek_left_ploy);
plot(chin_ploy);
plot(forehead_ploy );
hold off;
cd(pth_selected)
saveas(gcf,['1_',in_file,'.jpg']);
%% Cropping Image
BW1=roipoly(rgb,box_cheek_right(1,:),box_cheek_right(2,:));
BW2=roipoly(rgb,box_cheek_left(1,:),box_cheek_left(2,:));
BW3=roipoly(rgb,box_chin(1,:),box_chin(2,:));
BW4=roipoly(rgb,box_forehead(1,:),box_forehead(2,:));
out1=zeros(size(BW1,1),size(BW1,2));
out2=zeros(size(BW2,1),size(BW2,2));
out3=zeros(size(BW3,1),size(BW3,2));
out4=zeros(size(BW4,1),size(BW4,2));

out1 = rgb .* uint8(BW1);
out2 = rgb .* uint8(BW2);
out3 = rgb .* uint8(BW3);
out4 = rgb .* uint8(BW4);
%% ITA Calucalation Each
cd(pth)
ITA_cheek_right=fun_get_ITA(out1,0,'p');
ITA_cheek_left=fun_get_ITA(out2,0,'p');
ITA_chin=fun_get_ITA(out3,0,'p');
ITA_forehead=fun_get_ITA(out4,0,'p');

ITA_Sum=ITA_cheek_right+ITA_cheek_left+ITA_chin+ITA_forehead;
%% Smoothing
ITA_cheek_right_smooth=filter(b,1,ITA_cheek_right);
ITA_cheek_left_smooth=filter(b,1,ITA_cheek_left);
ITA_chin_smooth=filter(b,1,ITA_chin);
ITA_forehead_smooth=filter(b,1,ITA_forehead);
ITA_Sum_Smooth=filter(b,1,ITA_Sum);

figure(2);
subplot(221),imshow(rgb),title('RGB');
subplot(222),imshow(rgb_cropped),title('Cropped RGB');
subplot(223),imshow(ITA),title('ITA');
subplot(224),imshow(ITA_smooth),title('Smoothed ITA');
%% Manual Smoothing
% n=size(ITA,1);
% for i = 2:(n-1)
%     for j=2:(n-1)
%     ITA_Manual_Smth(i,j) = (ITA_Sum(i,j-1) + ITA_Sum(i,j) + ITA_Sum(i,j+1))/3;
%     end
% end
disp(mean(ITA_Sum(:)));
disp(mean(ITA_Sum_Smooth(:)));
% disp(mean(ITA_Manual_Smth(:)));

max(ITA_Sum(:))
max(ITA_Sum_Smooth(:))
% max(ITA_Manual_Smth(:))

figure(3),
subplot(131),hist(ITA_Sum)
subplot(132),hist(ITA_Sum_Smooth)
% subplot(133),hist(ITA_Manual_Smth)

%% Plotting Full ITA
alpha = (~isnan(ITA))*0.6;
figure(4)
imshow(rgb),title('ITA Plotted on Origal RGB');
hold on
OverlayImage = imshow( ITA);
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );
 cd(pth_selected)
saveas(gcf,['2_',in_file,'.jpg']);
%% ITA SUM
%% Plotting ITA onto input using Heatmap
alpha = (~isnan(ITA))*0.6;
figure(5)
imshow(rgb),title('ITA Plotted on Origal RGB');
hold on
OverlayImage = imshow( ITA_Sum );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );

 cd(pth_selected)
saveas(gcf,['3_',in_file,'.jpg']);
%%
figure(6)
subplot(241),imshow(out1),title('Cropped P1');
subplot(242),imshow(out2),title('Cropped P2');
subplot(243),imshow(out3),title('Cropped P3');
subplot(244),imshow(out4),title('Cropped P4');
subplot(245),imshow(ITA_cheek_right),title('ITA P1');
subplot(246),imshow(ITA_cheek_left),title('ITA P2');
subplot(247),imshow(ITA_chin),title('ITA P3');
subplot(248),imshow(ITA_forehead),title('ITA P4');

%%
% cd(pth_selected)
% saveas(gcf,['4_',in_file,'.jpg']);

% subplot(245),imshowpair(Lab_L,R_lab_l,ITA_cheek_right,R_ITA_cheek_R),title(['Right = ' num2str(max(ITA_cheek_right(:))),' Smoothed= ',num2str(max(ITA_cheek_right_smooth(:))) ]);
% subplot(246),imshowpair(Lab_L,R_lab_l,ITA_cheek_left,R_ITA_cheek_L),title(['Left= ' num2str(max(ITA_cheek_left(:))),' Smoothed= ',num2str(max(ITA_cheek_left_smooth(:))) ]);
% subplot(247),imshowpair(Lab_L,R_lab_l,ITA_chin,R_ITA_chin),title(['Chin=' num2str(max(ITA_chin(:))),' Smoothed= ',num2str(max(ITA_chin_smooth(:))) ]);
% subplot(248),imshowpair(Lab_L,R_lab_l,ITA_forehead,R_ITA_forehead),title(['Forehead=' num2str(max(ITA_forehead(:))),' Smoothed = ',num2str(max(ITA_forehead_smooth(:))) ]);

%% Mean & Max
results_all{success_count,2}=max(ITA_Sum(:));
results_all{success_count,3}=max(ITA_Sum_Smooth(:));
results_all{success_count,4}=min(ITA_Sum(:));
results_all{success_count,5}=min(ITA_Sum_Smooth(:));
results_all{success_count,6}=mean2(ITA_Sum);
results_all{success_count,7}=mean2(ITA_Sum_Smooth);


results_success{success_count,2}=max(ITA_cheek_right(:));
results_success{success_count,3}=max(ITA_cheek_left(:));
results_success{success_count,4}=max(ITA_chin(:));
results_success{success_count,5}=max(ITA_forehead(:));
results_success{success_count,6}=max(ITA_cheek_right_smooth(:));
results_success{success_count,7}=max(ITA_cheek_left_smooth(:));
results_success{success_count,8}=max(ITA_chin_smooth(:));
results_success{success_count,9}=max(ITA_forehead_smooth(:));
%% Mean
results_success{success_count,10}=mean2(ITA_cheek_right(:));
results_success{success_count,11}=mean2(ITA_cheek_left(:));
results_success{success_count,12}=mean2(ITA_chin(:));
results_success{success_count,13}=mean2(ITA_forehead(:));
results_success{success_count,14}=mean2(ITA_cheek_right_smooth(:))
results_success{success_count,15}=mean2(ITA_cheek_left_smooth(:));
results_success{success_count,16}=mean2(ITA_chin_smooth(:));
results_success{success_count,17}=mean2(ITA_forehead_smooth(:));

disp(['Peak P1 = ' num2str(results_success{success_count,2}),' Smooth = ',num2str(results_success{success_count,6})]);
disp(['Peak P2 = ' num2str(results_success{success_count,3}),' Smooth = ',num2str(results_success{success_count,7})]);
disp(['Peak P3 = ' num2str(results_success{success_count,4}),' Smooth = ',num2str(results_success{success_count,8})]);
disp(['Peak P4= ' num2str(results_success{success_count,5}),' Smooth = ',num2str(results_success{success_count,9})]);
disp(['Mean P1 =', num2str(results_success{success_count,10}),' Smoothed =',num2str(results_success{success_count,14})])
disp(['Mean P2 =', num2str(results_success{success_count,11}),' Smoothed =',num2str(results_success{success_count,15})])
disp(['Mean P3 =', num2str(results_success{success_count,12}),' Smoothed =',num2str(results_success{success_count,16})])
disp(['Mean P4 =', num2str(results_success{success_count,13}),' Smoothed =',num2str(results_success{success_count,17})])
% % % % % % % % % % % % % % % % % % % % % % % 

% croppedImage = imcrop(rgb, cheek_right_ploy);
% show the mean shape
% figure(4);
% plot(m(:, 1), m(:, 2), 'go');
% for j = 1:size(m, 1)
%     text(m(j, 1), m(j, 2), sprintf('%i', j));
% end
% set(gca, 'Ydir', 'reverse');
success_count=success_count+1;
end
end

Results_Success_Final=table();
Results_Success_Final.Filename=results_success(:,1);
Results_Success_Final.Peak_P1=results_success(:,2);
Results_Success_Final.Peak_P2=results_success(:,3);
Results_Success_Final.Peak_P3=results_success(:,4);
Results_Success_Final.Peak_P4=results_success(:,5);
Results_Success_Final.Peak_P1_Smoothed=results_success(:,6);
Results_Success_Final.Peak_P2_Smoothed=results_success(:,7);
Results_Success_Final.Peak_P3_Smoothed=results_success(:,8);
Results_Success_Final.Peak_P4_Smoothed=results_success(:,9);
Results_Success_Final.Mean_P1=results_success(:,2);
Results_Success_Final.Mean_P2=results_success(:,3);
Results_Success_Final.Mean_P3=results_success(:,4);
Results_Success_Final.Mean_P4=results_success(:,5);
Results_Success_Final.Mean_P1_Smoothed=results_success(:,6);
Results_Success_Final.Mean_P2_Smoothed=results_success(:,7);
Results_Success_Final.Mean_P3_Smoothed=results_success(:,8);
Results_Success_Final.Mean_P4_Smoothed=results_success(:,9);

Results_Fail_Final=table();
Results_Fail_Final.Filename=results_failed(:,1);
Results_Fail_Final.Status=results_failed(:,2);

Results_All_Final=table();
Results_All_Final.Filename=results_all(:,1);
Results_All_Final.Max=results_all(:,2);
Results_All_Final.MaxSm=results_all(:,3);
Results_All_Final.Min=results_all(:,4);
Results_All_Final.MinSm=results_all(:,5);
Results_All_Final.Mean=results_all(:,6);
Results_All_Final.MeanSm=results_all(:,7);

Save_filename1 = [folder_name,'- Success_Table_Parts.xlsx'];
Save_filename2 = [folder_name,'- Fail_Table_Final.xlsx'];
Save_filename3 = [folder_name,'- Success_All_Table.xlsx'];

cd(pth_selected)
writetable(Results_Success_Final,Save_filename1,'Sheet',1,'Range','D1')
writetable(Results_Fail_Final,Save_filename2,'Sheet',1,'Range','D1')
writetable(Results_All_Final,Save_filename3,'Sheet',1,'Range','D1')
