# Image-Stitching-using-SIFT-features-for-Panorama-Creation-in-Matlab
Image Stitching using SIFT features for Panorama Creation in Matlab

Image Stitching Based on Affine and Homography
## Part A:
In part A, two images parliament-left and parliament-right are being stitched.
  1.	Step1: Preprocessing<br>
    1.1.	Conversion to Single<br>
    1.2.	Gray Conversion<br>
  2.	Step2: Detect keypoints and extract descriptors<br>
    2.1.	Frames and descriptors will be extracted Using vl_sift function from vl_feat library.<br>
    2.2.	They are plotted using vl_plotframe<br>
    2.3.	Descriptors are plotted using vl_plotsiftdescriptor.m<br>
  3.	Step3: Match Features<br>
    3.1.	Extracted Descriptors are matched using vl_ubcmatch.m<br>
  4.	Step4: Prune features<br>
    4.1.	Select the closest matches based on the matrix of pairwise descriptor distances<br>
  5.	Step5: Robust Transformation Estimation<br>
    5.1.	Affine Transformation and inliers are calculated using ransacfitaffine.m<br>
    5.2.	Transformation Plotting using fun_plotmatches.m<br>
    5.3.	Outliers are also calculated<br>
  6.	Step6: Compute Optimal Transformation<br>
  7.	Step7: Create panorama<br>
    7.1.	Panorama is created using above data and passed to vl_imwbackward.m<br>
 <br>
## Part B:<br>
In part B, two images Glendon-Hall-left, Glendon-Hall-middle and Glendon-Hall-right are being stitched.<br>
  1.	Step1: Preprocessing<br>
    1.1.	Conversion to Single<br>
    1.2.	Gray Conversion<br>
  2.	Step2: Detect keypoints and extract descriptors<br>
    2.1.	Frames and descriptors will be extracted Using vl_sift function from vl_feat library.<br>
    2.2.	They are plotted using vl_plotframe<br>
    2.3.	Descriptors are plotted using vl_plotsiftdescriptor.m<br>
  3.	Step3: Match Features<br>
    3.1.	Extracted Descriptors are matched using vl_ubcmatch.m<br>
  4.	Step4: Prune features<br>
    4.1.	Select the closest matches based on the matrix of pairwise descriptor distances<br>
  5.	Step5: Robust Transformation Estimation<br>
    5.1.	vl_colsubset is used for homography estimation.<br>
    5.2.	Kronecker tensor and VL_HAT  Hat operator are also used.<br>
    5.3.	Svd is calculated.<br>
    5.4.	Hence score homography is calculated.<br>
  6.	Step6: Compute Optimal Transformation <br>
    6.1.	Max Score is selected from homography score.<br>
    6.2.	Homography based points are then plotted.<br>
  7.	Step7: Create panorama<br>
    7.1.	Panorama is created using above data and passed to vl_imwbackward.m <br>

![Figure 1](https://user-images.githubusercontent.com/25412736/177797140-a7b4d181-5f86-496f-8f37-6373ff897945.jpg)


![Full SS](https://user-images.githubusercontent.com/25412736/177797154-74841ac5-8cb1-4653-9663-84f18dee0e89.PNG)

![Left with Features](https://user-images.githubusercontent.com/25412736/177797167-d6ec240e-8c73-4406-82cc-916a03093076.png)


![Matched Features Part_A](https://user-images.githubusercontent.com/25412736/177797178-af259008-cd04-4011-befa-6714ed1b14d6.png)


![Part B 1st Stitched Image (Img1+Img2) with Features](https://user-images.githubusercontent.com/25412736/177797194-e9532da5-b27f-4160-b678-7803de7f2d19.png)


![Part B Final Stitched Image (Img1+Img2 + Img3) with Features](https://user-images.githubusercontent.com/25412736/177797203-3bb9d3c6-c1bd-48df-952b-b74dc0734005.png)


![Part B Img 1 with Features](https://user-images.githubusercontent.com/25412736/177797220-999f5543-1c7c-4840-a839-5664732cdb03.png)


![Part B Img 2 with Features](https://user-images.githubusercontent.com/25412736/177797230-bd50985a-b9da-40ca-a4a3-f6ddab977707.png)


![Part B Img 3 with Features](https://user-images.githubusercontent.com/25412736/177797242-96e658c9-4c59-4d05-b682-882982df31e8.png)


![Part B Img1 and Img2 Matched Feature](https://user-images.githubusercontent.com/25412736/177797255-1e7e5039-f692-4013-9434-fcc6b218f9ff.png)


  ![Part B Img1, Img2 and Img3 Matched Feature](https://user-images.githubusercontent.com/25412736/177797265-7d8ccd09-91a5-4b58-a454-2c8c95a682be.png)


![Uploading Part B Stitched Image of Img1 and Img2.png…]()


![Process](https://user-images.githubusercontent.com/25412736/177797288-b4972a7d-8d92-4d85-92e8-e0dd9c684378.PNG)


![Right with Features](https://user-images.githubusercontent.com/25412736/177797301-c16f829c-f87c-4e43-902e-4639b1116459.png)


![Uploading Stitched Image Part A.png…]()


