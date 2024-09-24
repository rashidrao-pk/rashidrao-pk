# An Artificial Intelligence Based Automatic Detection of Veins Blockage


## Demo -> 
![ezgif com-gif-maker](https://user-images.githubusercontent.com/25412736/183263811-4fdd11c0-b272-4498-89e0-41d9422327b6.gif)



## Introduction

1. Blockage in the veins, a very common disease
2. Can cause heart attack or angina
3. Continuous blockages can burst
4. Common remedy is an angiography in which doctors repair the veins by inserting stents known as angioplasty. 
<br>
![image](https://user-images.githubusercontent.com/25412736/177771464-1967db19-dff4-4f9d-8062-84f7f7cfeb5d.png)
<br>

## Proposed System

The Proposed system will mainly follow through four main step and some of sub-steps in them
<br>
1. Image Acquisition
2. Pre-Processing
3. Histogram Equalization
4. Edge Detection
5. Colour Transformation
6. Plaque Identification
<br>

![image](https://user-images.githubusercontent.com/25412736/177771770-1f786f1d-df14-4180-8cd4-24f2ffd725a7.png)
<br>

### Image Acquisition: Acquire an angiographic image
### Grey Scale Conversion of the angiographic image to arrange fewer data for each pixel
### Grey Scale Image (also called grey-level) is a data matrix whose values represent intensities within some range. 
Equation:    𝟎.𝟐𝟗𝟖𝟗 ∗ 𝐑 + 𝟎.𝟓𝟖𝟕𝟎 ∗ 𝐆 + 𝟎.𝟏𝟏𝟒𝟎 ∗ 𝐁
<br>
![image](https://user-images.githubusercontent.com/25412736/177772019-52fe7d3b-acd3-455a-ba64-bf558ee6e5b5.png)
<br>

Image Magnification through Equalized histogram technique
Equalized histogram: The process of adjusting intensity values can be done automatically using histogram equalization.
Algorithm:
For each pixel of the image 
value = Intensity(pixel)
histogram(value)++
end
<br>
![image](https://user-images.githubusercontent.com/25412736/177771976-0f9d9b03-f18b-4982-afd0-9eab8fa4357e.png)

<br>

Edge Detection through the following techniques:
Bot-hat Filter computes the morphological closing of the image and then subtracts the original image from the result
 Equation: IMGBH=(A.B)−A
 <br>
 ![image](https://user-images.githubusercontent.com/25412736/177772101-83651cb2-74b3-4c77-9166-d506cd438832.png)
<br>
Binary image is a digital image that has only two possible values for each pixel. each pixel is stored as a single bit—i.e., a 0 or 1
<br>
Equation:
𝒈(𝑿,𝒀)={𝟏
<br>
![image](https://user-images.githubusercontent.com/25412736/177772166-d6df770a-b8ab-4851-b670-d06155ed46e5.png)

<br>
![image](https://user-images.githubusercontent.com/25412736/177772184-1dcd61bc-4021-4a74-855f-b72b4f35cff1.png)

<br>

Edge Detection (Cont..)
Firangi filter uses the eigen vectors of the Hessian to compute the likeliness of an image region to vessels, according to the method described by Firangi.
 Equation:
 ![image](https://user-images.githubusercontent.com/25412736/177772309-73921b63-3243-4c1b-871f-1e4ae11fa8ba.png)

<br>
![image](https://user-images.githubusercontent.com/25412736/177772329-7fc1640f-8ef4-46ee-9f50-0c7d3a542850.png)

<br>
Edge Detection (Cont..)
Equation:
![image](https://user-images.githubusercontent.com/25412736/177772375-82dd1750-06a2-474f-841f-abdd7e5a8740.png)

Where;
⅄2 will be the eigenvalue 
ℛꞵ and S are the line filters
ꞵ and C are the threshold values 

Edge Detection (Cont..)
Area Opening:
The system removes from a binary image all connected components (objects) that have fewer than P pixels, producing another binary image BW2 
Syntax: 
BW2 = BWAREAOPEN(BW,P)
<br>
![image](https://user-images.githubusercontent.com/25412736/177772447-979bed10-6559-4dcb-9f33-40f9a42f78dc.png)

<br>

Colour coding through the following colour schemes:
HSV Transformation: 
HSV is alternative representations of the RGB colour model. H stands for Hue, S stands for Saturation and the V for Value. 
Hue is usually a number between 0 and 360 that represents the angle in the colour wheel 
Saturation is expressed in a range from just 0–1, where 0 is grey and 1 is a primary colour.
Value describes the brightness or intensity of the colour, from 0–100 percent, where 0 is completely black, and 100 is the brightest
Colour coding (Cont..)
HSV Transformation (Cont..) 
Equation:
<br>
![image](https://user-images.githubusercontent.com/25412736/177772542-82215210-15a8-4227-9244-19cbdf11ea31.png)
<br>
 Where:
 <br>
![image](https://user-images.githubusercontent.com/25412736/177772551-ad774d5c-7c9f-459b-a9a0-8e15775fbddc.png)
<br>
![image](https://user-images.githubusercontent.com/25412736/177772590-591bdbe5-ac85-4bb8-9b19-0de7e7e7bd7f.png)
<br>
LAB Transformation
The CIELAB colour space is also known as CIE L*a*b* or sometimes abbreviated as simply "Lab" colour space
It expresses colour as three numerical values, L* for the lightness and a* and b* for the green–red and blue–yellow colour components
Syntax: lab = rgb2lab(rgb)
<br>
![image](https://user-images.githubusercontent.com/25412736/177772651-1050e430-4311-4076-97af-e2febff91616.png)
<br>
LAB’s L Component output
Display the L* component of the L*a*b* image
Syntax: imshow(lab(:,:,1)
<br>
![image](https://user-images.githubusercontent.com/25412736/177772693-5f2f9906-36bd-4626-a494-7c72d6ae972b.png)
<br>
Generate Report
The angiographic image  will be processed in MATLAB and PHP application will generate the report
<br>
![image](https://user-images.githubusercontent.com/25412736/177772781-364d4f4d-06ec-46bd-866c-627c34c62239.png)

<br>

## User Interface 1
![image](https://user-images.githubusercontent.com/25412736/177772879-ac35465d-bbdc-4d6f-8974-a6f9e8720df4.png)

## User Interface II
![image](https://user-images.githubusercontent.com/25412736/177772943-2fbfc3ca-7902-49a2-aace-e28ab79e902f.png)


## User Interface III
![image](https://user-images.githubusercontent.com/25412736/177772958-0fa6b806-6467-4fc9-8670-a2fc86e68ab3.png)

## User Interface IV
![image](https://user-images.githubusercontent.com/25412736/177773030-7a14f559-bb7e-4931-ad15-22739f28ac49.png)

