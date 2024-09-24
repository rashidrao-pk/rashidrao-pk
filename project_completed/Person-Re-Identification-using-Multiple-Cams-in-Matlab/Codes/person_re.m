% I1 = imread('cameraman.tif');
% I2 = imresize(imrotate(I1,-20),1.2);

I1 = imresize(rgb2gray(imread('F:\Study\MS(CS)\All_datasets\VIPeR\cam_a\000_45.bmp')),2.5);
I2 = imresize(rgb2gray(imread('F:\Study\MS(CS)\All_datasets\VIPeR\cam_b\000_45.bmp')),2.5);

hn1 = imhist(I1)./numel(I1);
hn2 = imhist(I2)./numel(I2);

f = sum(sqrt(hn1-hn2).^2);


E_distance = sqrt(sum((h1-h2).^2));

h_new = repmat(h1,1,size(h2,2));

E_distance = sqrt(sum((h1_new-h2).^2));


points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);


figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
% legend('a','b');



D1 = bwdist(I1,'euclidean');
D2 = bwdist(I1,'cityblock');
D3 = bwdist(I1,'chessboard');
D4 = bwdist(I1,'quasi-euclidean');
RGB1 = repmat(rescale(D1), [1 1 3]);
RGB2 = repmat(rescale(D2), [1 1 3]);
RGB3 = repmat(rescale(D3), [1 1 3]);
RGB4 = repmat(rescale(D4), [1 1 3]);


figure,
subplot(221),imshow(RGB1)
hold on, imcontour(D1);
subplot(222),imshow(I1);
hold on, imcontour(D2);
subplot(223),imshow(I1);
hold on, imcontour(D3);
subplot(224),imshow(I1);
hold on, imcontour(D4);




subplot(2,2,1), isosurface(D1,15), axis equal, view(3)
camlight, lighting gouraud, title('Euclidean')