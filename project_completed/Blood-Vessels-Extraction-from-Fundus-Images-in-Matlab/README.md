# Blood-Vessels-Extraction-from-Fundus-Images-in-Matlab
Blood Vessels Extraction from Fundus Images in Matlab


![image](https://user-images.githubusercontent.com/25412736/177868333-cc55562c-1852-4c25-a8f3-dedb9e2b4acf.png)


## Methodology
### 1. Input retinal fundus images
This function takes input images to the program. This input image format can be Graphics Interchange Format (GIF), Joint Photographic Experts Group (JPEG), Portable Network Graphics (PNG), and Tagged Image File Format (TIFF) formats. The images are retinal fundus images. Retinal fundus images are the images of the interior lining of the eyeball, including the retina (the light-sensitive screen), optic disc (the head of the nerve to the eye), and the macula (the small spot in the retina where vision is keenest). These images are taken by fundus cameras. A fundus camera is a specialized low power microscope with an attached camera. Its optical design is based on the indirect ophthalmoscope.

![image](https://user-images.githubusercontent.com/25412736/177868497-c7caf2f7-84fd-4551-8c3e-88169ccbcdd3.png)

Figure 3 shows some example retinal fundus images. The top two images show retinal fundus images of the right eye and bottom two images show retinal fundus images of the left eye. From here images are carried on to be preprocessed which later helps with Vessel Extraction.


### 2. Vessel extraction
Retinal blood vessel extraction is one of the most important steps in the ODED system. Retinal blood vessel extraction is a process to get binary vessel maps where retinal blood vessels are labelled as white and retinal background pixels are labelled as black or vice versa. An example of a binary vessel map is shown in Figure 4. The ideal purpose of this step is getting binary vessel images by an automatic computerized algorithm and the resulting image will be post-processed to get the horizontal and vertical vessel images in order to continue the Exclusion Method (EM) used in optic disc localization.

![image](https://user-images.githubusercontent.com/25412736/177868726-0cfeb872-c0e7-4bad-9329-c6d3be053c62.png)

As the first step of retinal blood vessel extraction, retinal fundus image is preprocessed. Preprocessing includes, resizing, reshaping, gray scaling, enhancing and filtering. After the preprocessing is done, the preprocessed image is converted into a binary image using thresholding. Thresholding is the simplest method of image segmentation. This method is based on a clip-level (or a threshold value) to turn a gray-scale image into a binary image. Thresholding is the main step of this vessel extraction process and after thresholding. Resulting image from thresholding is a noisy image with separated blood vessels. After thresholding is done, all the unnecessary noise is removed from the image. As the final step, the resulting clear image is converted into horizontal and vertical vessel images and these images will be used in further processing (Optic disc localization). Flow chart of the retinal blood vessel extraction process is shown in Figure 5.

![image](https://user-images.githubusercontent.com/25412736/177868873-7c4746c8-f23f-40ee-8ef1-92ac06e7694d.png)


### Optic disc (OD) localization
The two main structures used in retinal image analysis are blood vessels and optic disc. Optic disc is the brightest region in the retinal image and the blood vessels originate from its center (Shown in Figure 6). Optic disc localization is also an important step in the ODED system because optic disc segmentation, which is the most important step, mainly depends on the results of this step

![image](https://user-images.githubusercontent.com/25412736/177868975-defc0df7-5b11-4555-9e8f-4d7d78c8f339.png)

Different methods have been proposed for localization of OD. They have exploited some of OD region features, such as its yellow color, having more brightness, having high grey intensity, and containing a network of convergence vessels. They have been applied through different techniques. Most of the methods for localizing optic disc fail when pathological regions exist in retina images. Some other algorithms suffer from high computational cost. The method that the ODED system uses to localize OD is known as Exclusion Method (EM). The EM generalizes the idea that the area around the OD has a low frequency of horizontal vessels and a high frequency of vertical vessels. The EM model is simple and fast. Importantly, the EM is less independent of the appearance of the OD region. Furthermore, the EM can still work efficiently even when the OD deteriorates, such as changing the size and shape of the image, or the image consists of other lesions such as exudates or hemorrhages.

![image](https://user-images.githubusercontent.com/25412736/177869114-a4677f5d-43cb-4e6c-99f4-b23215f7b392.png)


### 4. Optic disc (OD) segmentation
Segmenting the optic disc (OD) is the most important step in the ODED system because it helps to detect the abnormalities of OD and classify optic disc edema. A reliable OD segmentation technique is necessary for automatic screening of OD abnormalities. There are several ODsegmentation techniques but only few of these techniques can provide accurate results due to unclear cloudy edges of optic discs with optic disc edema. A comparison between retinal fundus images of a normal eye and an eye with optic disc edema is shown in Figure 8
![image](https://user-images.githubusercontent.com/25412736/177869232-a0b482a9-fdb9-422e-a9c6-2b08df3e8538.png)


### 5. Papilledema classification
Optic disc edema (Papilledema) classification is the final step of this system. The segmented OD region from the previous step is used to classify optic disc edema. The diameter of the OD is used to detect the swollen OD. The average human optic disc dimensions are 1.88mm vertically by 1.77mm horizontally, and can be grouped by vertical diameter into small (1.2-1.7mm), average (1.87-1.96mm), and large (2.03-2.27mm) disc sizes. The size of a human adult eye is approximately 24.2 mm (transverse) × 23.7 mm (sagittal) × 22.0-24.8 mm (axial) with no significant difference between sexes and age groups. In the transverse diameter, the eyeball size may vary from 21 mm to 27 mm. The system uses the abnormal change of the ratio between eye and the OD for optic disc edema classification. The diameter change of the OD is
illustrated in the following figure.

