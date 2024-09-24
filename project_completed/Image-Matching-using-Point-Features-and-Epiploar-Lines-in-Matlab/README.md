# Image-Matching-using-Point-Features-and-Epiploar-Lines-in-Matlab
Image Matching using Point Features and Epiploar Lines in Matlab

## Methodology

![Figure](https://user-images.githubusercontent.com/25412736/177831133-3586a822-38b7-460a-a939-9056cdcc33d3.jpg)
To Find the similarity of Images, we will apply following steps;

### Pre-Processing (Gray Conversion) 
### Point-Feature Detection
### Feature Extraction
### Feature Matching
### Fundamental Matrix Estimation
\f F \f
### Epipolar Line Plotting 
\f[l^{(2)}_i = F p^{(1)}_i\f]
\f[l^{(1)}_i = F^T p^{(2)}_i\f]

To Find the similarity of Images, we will apply following steps ( Image 100) ;
### Pre-Processing (Gray Conversion) 
![image](https://user-images.githubusercontent.com/25412736/177831436-ea104db9-4265-4a0c-bc5e-76a34443053b.png)
![image](https://user-images.githubusercontent.com/25412736/177831427-72206272-afc5-4bc2-8b22-67d1f30f6d0e.png)
![image](https://user-images.githubusercontent.com/25412736/177831443-15b71edf-36a2-40c8-82b1-6a5b1c3f2acb.png)


### Point-Feature Detection
	M * N matrix for image containing Detected Points (76 x 4)
### Feature Extraction 
M-by-N matrix of M feature vectors
M number of VALID_POINTS corresponding to each descriptor
	Image 1 (3477 x 64)  
	Image 2 (3572 x 64)
  
  ### Feature Matching
	P-by-2 matrix, indexPairs, containing indices to the features most likely to correspond between the two input feature matrices
(151 x 2)
![image](https://user-images.githubusercontent.com/25412736/177831563-4fd403a4-0335-496f-b224-6b0a80f2853a.png)


### Fundamental Matrix Estimation
Inputs
Matched Point1 (151)
Matched Point2 (151)
Method (Least Median of Squares)
Outputs
3-by-3 Fundamental Matrix using Selected Method (3x3)
Logical indices for the inliers used to compute the fundamental matrix 			(151 x 1)

### Epipolar Line Plotting
Compute Epipolar Lines
Epipolar Lines 1 (76 x 3)
Epipolar Lines 2 (76 x 3)
Compute the intersection points of the lines and the image Border
Intersection (76 x 4)
![image](https://user-images.githubusercontent.com/25412736/177831637-e4116313-028e-4f9d-afb3-89ece90eb91e.png)

### Epipolar Line Plotting
Line Plotting
![image](https://user-images.githubusercontent.com/25412736/177831717-9dd0f56f-d3e3-4ddc-a94d-0b566c4648b4.png)


### Conclusion

Itemized Conclusion
Image matching has played a significant role in various visual applications and has attracted considerable attention. Researchers have also achieved significant progress in this field in the past few decades.
Image matching can be briefly classified into area- and feature-based matching. 
Area-based methods are used to achieve dense matching without detecting any salient feature points from the images. They are more welcomed in high overlapping image matching (such as medical image registration) and narrow-baseline stereo (such as binocular stereo matching)
The feature-based image matching can effectively address the limitations in large viewpoint, wide baseline, and serious non-rigid image matching problems. It can be used in a pipeline of salient feature detection, discriminative description, and reliable matching, often including transformation model estimation







## Results
![matches](https://user-images.githubusercontent.com/25412736/177830932-942e4e47-3a84-43fa-ba7d-8510326edd8e.jpg)

![epipolars](https://user-images.githubusercontent.com/25412736/177830938-cbbdc63c-531c-4fc3-a410-35bd9c323cf2.jpg)

![matches](https://user-images.githubusercontent.com/25412736/177830965-339c8a0e-bd04-4aad-8a1c-cf1a1f0216d8.jpg)

![epipolars](https://user-images.githubusercontent.com/25412736/177830974-ea66a542-9824-4238-a3c3-a97d9792dd18.jpg)

![matches](https://user-images.githubusercontent.com/25412736/177830984-5661388b-1831-4546-b108-47a10cd4f268.jpg)

![epipolars](https://user-images.githubusercontent.com/25412736/177830996-06dda8ae-0331-4476-be70-775d47adc60f.jpg)


