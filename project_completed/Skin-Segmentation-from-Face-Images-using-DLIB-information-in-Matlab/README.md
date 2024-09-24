# Skin-Segmentation-from-Face-Images-using-DLIB-information-in-Matlab
Skin Segmentation from Face Images using DLIB information in Matlab

## Facial Parts Extraction<br>
1- Line 1-9, path setting and initializing for variable<br>
2- Line 10 Creating Image Datastore for all images in a Folder<br>
3- Till Line 17 Accessing rows from Datastore to access all images one by one<br>
4- First if else is checking, which dataset we are using, then set write image folder according
to dataset provided to save results (20-27)<br>
5- from %% DLIB Line 28-39 DLIB provides us a bounding box for detected face from input<br>
6- Line 62, fun_get_ITA, is calculating the ITA using our own function.<br>
7- 64-67, LAB conversion<br>
8- 68, averaging filter is performed to smooth data<br>
9- From Line 79, Loop is calculating those 68 values of face<br>
10- we saved these values in box_x and box_y to get our own facial parts<br>
11- we used, get_cheeckbox, get_chinbox, get_foreheadbox functions, to get the roi for each
facial part<br>
12- used polyshape functions to get polygon over the facial parts<br>
13- Then used plot function to plot those parts over input image<br>
14- Then cropped the original image using roipoly functions and roi, we got new segmented
parts from the image<br>
15- All out variable is having segmented RGB parts (Cheeks, forehead, chin)<br>
16- then we used fun_get_ITA to get ITA Score for each part<br>
17- then we summed up all ITA and got a new ITA_Sum for all those three parts<br>
18- we applied filter on all those three parts to get smoothed ITA for each<br>
19- Then we plotted ITA onto the Image<br>
20- Then we tablulated results using variables which later on written on an excel file<br>
21- Displaying Peak, Mean Values <br>
22- Then Writing Excel files at the end of the program <br>

![1_0145_1_m_FL](https://user-images.githubusercontent.com/25412736/177792453-365770ef-61c3-494e-b92b-e70c7ec22c67.jpg)

![1_0145_1_m_FL_skin_whitebg](https://user-images.githubusercontent.com/25412736/177792489-21879500-ae40-46ea-be08-f10d1c1df107.jpg)

![1_0145_1_m_FL_skin_whitebg](https://user-images.githubusercontent.com/25412736/177792514-f55c6bf8-57b4-42bc-8e03-ab4c79768eaf.jpg)



<br>
### We have to follow this algorithm:
![image](https://user-images.githubusercontent.com/25412736/177791707-a3219aa5-12d5-4c26-b6f6-c4ad128b25d8.png)

