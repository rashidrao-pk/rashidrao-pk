function mosaic = fun_stitching_affine(img1, img2)
%% Step 1 : Preprocessing
% make single
addpath('ransac');
tic
figure,
subplot(121),image(img1),title('Left Image '), axis off ;
subplot(122),image(img2),title('Right Image '), axis off ;
img1 = im2single(img1) ;
img2 = im2single(img2) ;
% make grayscale
if size(img1,3) > 1, im1g = rgb2gray(img1) ; else im1g = img1 ; end
if size(img2,3) > 1, im2g = rgb2gray(img2) ; else im2g = img2 ; end

input('Step 1 Completed, Press Enter to Go to Step 2 ');

%%  Step2: Detect keypoints and extract descriptors
[frame1,desc1] = vl_sift(im1g) ;
[frame2,desc2] = vl_sift(im2g) ;
perm1 = randperm(size(frame1,2)) ;
perm2 = randperm(size(frame2,2)) ;
sel1 = perm1(1:100) ;
subplot(121),
h1 = vl_plotframe(frame1(:,sel1)) ;
h2 = vl_plotframe(frame1(:,sel1)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(desc1(:,sel1),frame1(:,sel1)) ;
set(h3,'color','g') ;

sel2 = perm2(1:100) ;
subplot(122),
vl_plotframe(frame2(:,sel2)) ;
vl_plotframe(frame2(:,sel2)) ;

vl_plotsiftdescriptor(desc2(:,sel2),frame2(:,sel2)) ;

input('Step 2 Completed, Press Enter to Go to Step 3 ');

%%  Step3: Match Features
[matches, scores] = vl_ubcmatch(desc1,desc2) ;
numMatches = size(matches,2) ;

input('Step 3 Completed, Press Enter to Go to Step 4 ');

%%  Step 4 : Prune features

X1 = frame1(1:2,matches(1,:)) ; 
X1(3,:) = 1 ;

X2 = frame2(1:2,matches(2,:)) ; 
X2(3,:) = 1 ;

input('Step 4 Completed, Press Enter to Go to Step 5 ');
%% Step 5: Robust Transformation Estimation
% %  Using Affine
% % % % % % % % % % % % % % % % % % % % % % % % 
[H, inliers1] = ransacfitaffine(frame1, frame2, matches, 0.001);
fun_plotmatches(im1g, im2g, frame1, frame2, matches(:,inliers1));

outliers = setdiff(1:length(matches), inliers1);
outlier_matches = matches(:,outliers);
% fun_plotmatches(im1g, im2g, frame1, frame2, matches(:,outliers));

input('Step 5 Completed, Press Enter to Go to Step 6 ');
%% Step 6: Compute Optimal Transformation

dh1 = max(size(img2,1)-size(img1,1),0) ;
dh2 = max(size(img1,1)-size(img2,1),0) ;


input('Step 6 Completed, Press Enter to Go to Step 7 ');

%% Step 7 : Create panorama
box2 = [1  size(img2,2) size(img2,2)  1 ;
        1  1           size(img2,1)  size(img2,1) ;
        1  1           1            1 ] ;
box2_ = inv(H) * box2 ;
box2_(1,:) = box2_(1,:) ./ box2_(3,:) ;
box2_(2,:) = box2_(2,:) ./ box2_(3,:) ;
ur = min([1 box2_(1,:)]):max([size(img1,2) box2_(1,:)]) ;
vr = min([1 box2_(2,:)]):max([size(img1,1) box2_(2,:)]) ;

[u,v] = meshgrid(ur,vr) ;
im1_ = vl_imwbackward(im2double(img1),u,v) ;

z_ = H(3,1) * u + H(3,2) * v + H(3,3) ;
u_ = (H(1,1) * u + H(1,2) * v + H(1,3)) ./ z_ ;
v_ = (H(2,1) * u + H(2,2) * v + H(2,3)) ./ z_ ;
im2_ = vl_imwbackward(im2double(img2),u_,v_) ;

mass = ~isnan(im1_) + ~isnan(im2_) ;
im1_(isnan(im1_)) = 0 ;
im2_(isnan(im2_)) = 0 ;
mosaic = (im1_ + im2_) ./ mass ;

figure ; clf ;
imagesc(mosaic) ; axis image off ;
title('Mosaic') ;
input('Step 7 Completed, All steps completed, Press Enter to return to main Function ');

end
