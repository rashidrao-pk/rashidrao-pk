% 
close all;
clear all
clc
pth=cd;
% rgb = imread('2008_001322.jpg');

Detect_path='D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\DLIB';
DS_Path='D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\Extracted-Face-Skin';
cd(DS_Path)
[f,p]=uigetfile('*.*');
[in_file,in_path,in_ext]=fileparts([p,f]);

rgb=imread([p,f]);
rgb=imresize(rgb,[256,256]);
gray = rgb2gray(rgb);
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
else
  rgb_cropped = imcrop(rgb,[f(1,1),f(1,2),f(1,3)-f(1,1),f(1,4)-f(1,2)]);
  rgb_cropped_gray=rgb2gray(rgb_cropped);
%% ITA Equation
ITA=fun_get_ITA(rgb,0,'f')

%% Smoothing
 lab=rgb2lab(rgb);
Lab_L = lab(:,:,1);
Lab_a = lab(:,:,2);
Lab_b = lab(:,:,3);
b = 1/5*ones(5,1);
ITA_smooth=filter(b,1,ITA);
R_rgb = imref2d(size(rgb_cropped),0.2,0.2);
R_lab_l = imref2d(size(Lab_L),0.2,0.2);
R_lab_a = imref2d(size(Lab_a),0.2,0.2);
R_lab_b= imref2d(size(Lab_b),0.2,0.2);
R_ITA = imref2d(size(ITA),0.2,0.2);
R_ITA_new = imref2d(size(ITA_smooth),0.2,0.2);
%% Smoothing 2
windowSize = 5; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;
figure(1);
subplot(331),imshow(rgb),title('RGB');
subplot(332),imshow(rgb_cropped),title('Cropped RGB');
subplot(333),imshow(ITA),title('ITA');
subplot(334),imshow(uint8(Lab_L)),title('LAB L');
subplot(335),imshow(uint8(Lab_a)),title('LAB A');
subplot(336),imshow(uint8(Lab_b)),title('LAB B');
subplot(337),imshowpair(Lab_L,R_lab_l,ITA_smooth,R_ITA_new),title('Mapped LAB-L ITA');
subplot(338),imshowpair(Lab_a,R_lab_a,ITA_smooth,R_ITA_new),title('Mapped LAB-A ITA');
subplot(339),imshowpair(Lab_b,R_lab_b,ITA_smooth,R_ITA_new),title('Mapped LAB-B ITA');
% % % % % % % % % % % % % % % % % % % % % % % % 
figure(2),imshow(gray),title('Gray Image with Parts Plotted');
hold on; axis on;
for i = 1:size(f, 1)
    x = [f(i, 1), f(i, 3), f(i, 3), f(i, 1), f(i, 1)];
    y = [f(i, 2), f(i, 2), f(i, 4), f(i, 4), f(i, 2)];
    plot(x, y, '-r');
    for j=1:68
        box_x(j,1)=s(i, j, 1)
        box_y(j,1)=s(i, j, 2)
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
plot(cheek_right_ploy)
plot(cheek_left_ploy)
plot(chin_ploy)
plot(forehead_ploy )
hold off;
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
ITA_cheek_right=fun_get_ITA(out1,0,'p');
ITA_cheek_left=fun_get_ITA(out2,0,'p');
ITA_chin=fun_get_ITA(out3,0,'p');
ITA_forehead=fun_get_ITA(out4,0,'p');

ITA_cheek_right_smooth=filter(b,1,ITA_cheek_right);
ITA_cheek_left_smooth=filter(b,1,ITA_cheek_left);
ITA_chin_smooth=filter(b,1,ITA_chin);
ITA_forehead_smooth=filter(b,1,ITA_forehead);
%% Plotting ITA onto input using Heatmap
alpha = (~isnan(ITA))*0.6;
figure(111)
imshow(rgb),title('ITA Plotted on Origal RGB');
hold on
OverlayImage = imshow( ITA );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );


%%
figure(3)
subplot(341),imshow(out1),title('Cropped P1');
subplot(342),imshow(out2),title('Cropped P2');
subplot(343),imshow(out3),title('Cropped P3');
subplot(344),imshow(out1),title('Cropped P4');

R_ITA_cheek_R = imref2d(size(ITA_cheek_right),0.2,0.2);
R_ITA_cheek_L = imref2d(size(ITA_cheek_left),0.2,0.2);
R_ITA_chin = imref2d(size(ITA_chin),0.2,0.2);
R_ITA_forehead = imref2d(size(ITA_forehead),0.2,0.2);

subplot(345),imshow(ITA_cheek_right),title('ITA P1');
subplot(346),imshow(ITA_cheek_left),title('ITA P2');
subplot(347),imshow(ITA_chin),title('ITA P3');
subplot(348),imshow(ITA_forehead),title('ITA P4');
%% Plotting
% %  Cheek Right
subplot(349),imshow(rgb),title('Mapped ITA P1');
hold on
OverlayImage = imshow( ITA_cheek_right );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );
%% Plotting
% %  Cheek Left
subplot(3,4,10),imshow(rgb),title('Mapped ITA P2');
hold on
OverlayImage = imshow( ITA_cheek_left );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );
%% Plotting
% %  Chin
subplot(3,4,11),imshow(rgb),title('Mapped ITA P3');
hold on
OverlayImage = imshow( ITA_forehead );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );
%% Plotting
% %  Forehead
subplot(3,4,12),imshow(rgb),title('Mapped ITA P4');
hold on
OverlayImage = imshow( ITA_cheek_right );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );
% subplot(245),imshowpair(Lab_L,R_lab_l,ITA_cheek_right,R_ITA_cheek_R),title(['Right = ' num2str(max(ITA_cheek_right(:))),' Smoothed= ',num2str(max(ITA_cheek_right_smooth(:))) ]);
% subplot(246),imshowpair(Lab_L,R_lab_l,ITA_cheek_left,R_ITA_cheek_L),title(['Left= ' num2str(max(ITA_cheek_left(:))),' Smoothed= ',num2str(max(ITA_cheek_left_smooth(:))) ]);
% subplot(247),imshowpair(Lab_L,R_lab_l,ITA_chin,R_ITA_chin),title(['Chin=' num2str(max(ITA_chin(:))),' Smoothed= ',num2str(max(ITA_chin_smooth(:))) ]);
% subplot(248),imshowpair(Lab_L,R_lab_l,ITA_forehead,R_ITA_forehead),title(['Forehead=' num2str(max(ITA_forehead(:))),' Smoothed = ',num2str(max(ITA_forehead_smooth(:))) ]);

%% Mean & Max
mean_r_chk=mean2(ITA_cheek_right(:));
mean_l_chk=mean2(ITA_cheek_left(:));
mean_chin=mean2(ITA_chin(:));
mean_frhd=mean2(ITA_forehead(:));
mean_chk_r_smth=mean2(ITA_cheek_right_smooth(:))
mean_chk_l_smth=mean2(ITA_cheek_left_smooth(:));
mean_chin_smth=mean2(ITA_chin_smooth(:));
mean_frhd_smth=mean2(ITA_forehead_smooth(:));
max_chk_r=max(ITA_cheek_right(:));
max_chk_l=max(ITA_cheek_left(:));
max_chin=max(ITA_chin(:));
max_frhd=max(ITA_forehead(:));
max_chk_r_smth=max(ITA_cheek_right_smooth(:));
max_chk_l_smth=max(ITA_cheek_left_smooth(:));
max_chin_smth=max(ITA_chin_smooth(:));
max_frhd_smth=max(ITA_forehead_smooth(:));

disp(['Mean B4 =', num2str(mean_r_chk),' Mean Smoothed =',num2str(mean_chk_r_smth)])
disp(['Mean B4 =', num2str(mean_l_chk),' Mean Smoothed =',num2str(mean_chk_l_smth)])
disp(['Mean B4 =', num2str(mean_chin),' Mean Smoothed =',num2str(mean_chin_smth)])
disp(['Mean B4 =', num2str(mean_frhd),' Mean Smoothed =',num2str(mean_frhd_smth)])
% % % % % % % % % % % % % % % % % % % % % % % 
disp(['Peak Right = ' num2str(max_chk_r),' After Smooth = ',num2str(max_chk_r_smth)]);
disp(['Peak Left = ' num2str(max_chk_l),' After Smooth = ',num2str(max_chk_l_smth)]);
disp(['Peak Chin = ' num2str(max_chin),' After Smooth = ',num2str(max_chin_smth)]);
disp(['Peak Forehead = ' num2str(max_frhd),' After Smooth = ',num2str(max_frhd_smth)]);

% croppedImage = imcrop(rgb, cheek_right_ploy);
% show the mean shape
figure(4);
plot(m(:, 1), m(:, 2), 'go');
for j = 1:size(m, 1)
    text(m(j, 1), m(j, 2), sprintf('%i', j));
end
set(gca, 'Ydir', 'reverse');
end




%% Plotting Moving Average


