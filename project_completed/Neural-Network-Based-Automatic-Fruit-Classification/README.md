# Neural-Network-Based-Automatic-Fruit-Classification
Neural Network Based Automatic Fruit Classification
<br> 
![SS 1](https://user-images.githubusercontent.com/25412736/177775437-d28d69df-5090-42b4-b3a2-4ebb3e427a3d.PNG)
<br> 

## 3.1.	MODULES
The main functions of our system will be:
a)	Image Acquisition / Dataset Collection
b)	Pre-processing 
c)	Feature Extraction
d)	Feature Selection
e)	Classification
<br> 
![image](https://user-images.githubusercontent.com/25412736/177773952-49240395-bb8b-4e8b-9f2b-c8aab326724b.png)
<br> 
### a)	IMAGE ACQUISITION
The main stage in any PC vision-based framework is a technique for acquiring the information. Comprising of computerized pictures got from a camera. The system brings the image in digital format. The given image will be resized.
<br> 
### b)	PRE-PROCESSING
When a picture has been procured, pre-handling calculations can be connected to enhance the picture quality. The pre-processing is an improvement of the image data that suppresses unwanted distortions. The pre-processing method in image recognition and edge/boundary detection. It is very difficult to select the corresponding threshold for each image in different application domains.
![image](https://user-images.githubusercontent.com/25412736/177774088-d7aafe0a-a11a-43ef-bb2e-8e819090dd99.png)
<br> 
c)	FEATURE EXTRACTION
Feature detection is an important step in computer vision. Feature extraction starts from an initial set of measured data and builds derived values (features) intended to be informative and non-redundant, facilitating the subsequent learning and generalization steps, and in some cases leading to better human interpretations. Feature extraction is related to dimensionality reduction.
<br> 
![image](https://user-images.githubusercontent.com/25412736/177774124-5df8d4b4-2fed-450b-a03b-6884e0f008d4.png)
<br> Feature Extraction using InceptionV3 <br> 
### d)	FEATURE SELECTION
Optimization is used to improve the accuracy and reduce the bias in the model. When extract data with a high number of available features, it can become necessary to find ways to reduce the number of features which the classifier has to process. This is because every additional feature increases the complexity of the classification.
<br>
![image](https://user-images.githubusercontent.com/25412736/177774369-4b9cb972-3344-4260-8af8-eae5cd7a7f31.png)
<br>
Figure 5 Feature Selection
<br>
### e)	Classification
Classification is the process in machine learning in which features are classified into their most relevant category. In our approach, we will use SVM algorithm for classification.
<br>
![image](https://user-images.githubusercontent.com/25412736/177774508-5f4ac754-06b4-4eee-ad53-15ef399fe762.png)
<br>
Figure 6 Classification
<br>
### f)	TRAINING
Training is the phase in which system the system gets trained using extracted features. In our proposed work, our system will be trained using optimized features extracted from acquired dataset.
### g)	TESTING
In testing phase, trained system is evaluated using dataset and as a results, testing accuracy is achieved with some more performance measures. In our proposed work, we will calculate accuracy and detection time for testing phase.
## 3.2.	TOOL USED
For development of proposed project, Matlab 2020a will be used as the development tool and furthermore some of its sub-application maybe used for assistance.
•	Matlab
•	GUI feature of Matlab
•	Inception v3 model as Neural Network for features.
•	SVM classifier for classification of features.

# 4.	ADVANTAGES
•	Less Labor Cost
•	Automatic and Intelligent System
•	Fast and Accurate
•	Unobtrusive
•	More Working Hours

