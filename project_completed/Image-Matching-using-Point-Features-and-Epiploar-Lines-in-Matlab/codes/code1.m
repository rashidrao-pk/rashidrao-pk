clc
clear all;
close all;

% Code1
[f1,p1]=uigetfile('*.*');
[f2,p2]=uigetfile('*.*');

I1= imread([p1,f1]);
I2= imread([p2,f2]);

[r,c,ch]=size(I1);

% I2=imresize(I2,[r,c]);

if (size(I1,3)==3)
I1_gray=rgb2gray(I1);
else
    I1_gray=I1;
end

if (size(I2,3)==3)
I2_gray=rgb2gray(I2);
else
    I2_gray=I2;
end



%% Extract Points
points1 = detectSURFFeatures(I1_gray);
points2 = detectSURFFeatures(I2_gray);

[features1,valid_points1] = extractFeatures(I1_gray,points1);
[features2,valid_points2] = extractFeatures(I2_gray,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

figure(1),
subplot(121),imshow(I1),title('Image 1');
subplot(122),imshow(I2),title('Image 2');

figure(2);
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage'),
title('Detected Feature Matching');

% estimateFundamentalMatrix
% Estimate fundamental matrix from corresponding points in stereo images
% https://www.mathworks.com/help/vision/ref/estimatefundamentalmatrix.html#d123e196857
[fLMedS,inliers,status] = estimateFundamentalMatrix(matchedPoints1.Location,...
    matchedPoints2.Location,'NumTrials',4000,'Method','LMedS','DistanceThreshold',1e-4);

%%  EpipolarLine
% Compute epipolar lines for stereo images
% https://www.mathworks.com/help/vision/ref/epipolarline.html

% Compute the epipolar lines in the first image.
epiLines1 = epipolarLine(fLMedS,matchedPoints1.Location(inliers,:));
% Compute the intersection points of the lines and the image border.
points1 = lineToBorderPoints(epiLines1,size(I1));
% Show the epipolar lines in the first image

figure(3),
subplot(121),imshow(I1_gray);
title('Inliers and Epipolar Lines in First Image'); hold on;
plot(matchedPoints1.Location(inliers,1),matchedPoints1.Location(inliers,2),'go')
line(points1(:,[1,3])',points1(:,[2,4])');

% Compute and show the epipolar lines in the second image.
epiLines2 = epipolarLine(fLMedS,matchedPoints2.Location(inliers,:));
points2 = lineToBorderPoints(epiLines2,size(I2));

truesize;

figure(3),
subplot(122),imshow(I2_gray);
title('Inliers and Epipolar Lines in Second Image'); hold on;
plot(matchedPoints2.Location(inliers,1),matchedPoints2.Location(inliers,2),'go')
line(points2(:,[1,3])',points2(:,[2,4])');


figure(3),
subplot(121),imshow(I1_gray);
title('Inliers and Epipolar Lines in First Image'); hold on;
plot(matchedPoints1.Location(inliers,1),matchedPoints1.Location(inliers,2),'go')
line(points1(:,[1,3])',points1(:,[2,4])');