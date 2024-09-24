# Driver Drowsiness Detection using Computer Vision in Matlab

### Review from Client ->

![Review 4 Fiverr ](https://user-images.githubusercontent.com/25412736/183263208-5f8e8ad0-8176-4149-8725-0865b8bad8e2.JPG)


1. Each year hundreds of people lose their lives due to traffic accidents around the world. Unfortunately, Iran ranks first in the world in terms of road fatalities and each year approximately thirty thousands of fellow countrymen lose their lives in these events.
2. In a study by the National Transportation Research Institute (NTSRB) in which 107 random car accidents had been selected, fatigue accounted for 58% of the all accidents. A main cause of fatigue is sleeplessness or insomnia.
3. Ad hoc networks were the first systems to develop the automatic navigation in cars. A noticeable weakness of these systems is that their responses to environmental changes is not real time.
4. It is especially important in driving where time is a critical factor in driver's decision. On the other hand, another method to check the driver fatigue is monitoring the physical condition and facial expressions of the drivers, which wireless sensor networks are unable to process and transmit these information with adequate precision.

## Model :

![image](https://user-images.githubusercontent.com/25412736/174870729-32239010-25b4-4b4d-a2e2-5a552e020ab7.png)

## GUI:

![driver ](https://user-images.githubusercontent.com/25412736/174874688-b422977e-281a-4d6d-b397-d95902593f72.png)

## Software Requirments:

The whole system is implemented on MATLAB.

## Working Screenshots:

![image](https://user-images.githubusercontent.com/25412736/174870879-3e3b7a6c-2365-46b8-8c9f-c03e46f8cfa1.png) ![image](https://user-images.githubusercontent.com/25412736/174870886-36054275-a730-42b4-bfff-b7b17ebf7e6c.png)
(a) Face Region after Voila-Jones algorithm is applied. (b) Cropped face region.

# Eye Detection

![image](https://user-images.githubusercontent.com/25412736/174871038-99bbcd25-9c00-4a8f-b645-5005fcf4059d.png)![image](https://user-images.githubusercontent.com/25412736/174871042-d7d9e9be-7fd6-430e-b5ea-105c4394754e.png)

(a) Eye Region After the Calculations (b) Cropped Eye Region.

![image](https://user-images.githubusercontent.com/25412736/174871132-65e7a6b2-d9fa-4f43-b2ac-bf1c4a9bc627.png)![image](https://user-images.githubusercontent.com/25412736/174871139-362f304c-768e-4424-aaf9-72b1f0ff4165.png)![image](https://user-images.githubusercontent.com/25412736/174871149-69feeb80-ba1a-4a39-aee8-a819f9102eb5.png)

(a) Image after converting to YCbCr
(b) Image after converting to grayscale
(c) Image after converting to binary image

![image](https://user-images.githubusercontent.com/25412736/174871397-87bf085e-dc1d-4540-ae61-fb5ef7d858da.png)![image](https://user-images.githubusercontent.com/25412736/174871462-6d8a21a2-708d-444d-af13-cb147fe02231.png)

![image](https://user-images.githubusercontent.com/25412736/174871404-fb4ef093-ac67-43fc-a2b3-0a8636a7f5f1.png)![image](https://user-images.githubusercontent.com/25412736/174871478-59775de8-f9d1-49bd-9aa1-8f44103fc9db.png)
Original Cropped eyes.

# Mouth Detection 

![image](https://user-images.githubusercontent.com/25412736/174871561-a3cf364c-7d3e-4bde-ad7f-7f1078e42aa3.png)![image](https://user-images.githubusercontent.com/25412736/174871637-dfbf6c05-59f7-40a0-b579-14b1ba2550a4.png)
(a) Region of Mouth to be Extracted (b) Cropped Image Region.

![image](https://user-images.githubusercontent.com/25412736/174871824-52b3bc67-acd0-4679-abf1-5e1e03c50603.png)![image](https://user-images.githubusercontent.com/25412736/174871835-d8adab19-e0d4-4366-9b09-4400ae857f80.png)![image](https://user-images.githubusercontent.com/25412736/174871843-070a8b06-d5e1-4647-82ed-fd6f4f39b3ab.png)

(a) Mouth region converted to YCbCr colour space.(b) After converting to grayscale image. (c)After converting to binary image

![image](https://user-images.githubusercontent.com/25412736/174872021-0f295c0c-8409-4dfa-8288-f6f65eb3f0e8.png)![image](https://user-images.githubusercontent.com/25412736/174872038-269c6d70-a38f-4140-a3ec-79f418eac4ab.png)


![image](https://user-images.githubusercontent.com/25412736/174872041-c9b61eb0-6a27-4d35-9b86-d97b9bdfdf07.png)![image](https://user-images.githubusercontent.com/25412736/174872054-1e9ed3df-e4a4-4fca-a4a4-9aba25d37947.png)


![image](https://user-images.githubusercontent.com/25412736/174872060-221537c5-5562-4cef-a72c-a99a48d97a4b.png)![image](https://user-images.githubusercontent.com/25412736/174872068-1ffc9e00-ae3c-4a40-a389-ee96f9bb9a58.png)


# Skin Segmentation

1. An image which taken inside a vehicle includes the driver’s face. Typically a camera takes images within the RGB model (Red, Green and Blue). However, the RGB model includes brightness in addition to the colours. When it comes to human’s eyes, different brightness for the same color means different colour. 
2. When analyzing a human face, RGB model is very sensitive in image brightness. Therefore, to remove the brightness from the images is second step. We use the YCbCr space since it is widely used in video compression standards .
3. Since the skin-tone color depends on luminance, we nonlinearly transform the YCbCr colour space to make the skin cluster luma-independent. This also enables robust detection of dark and light skin tone colours. The main advantage of converting the image to the YCbCr domain is that influence of luminosity can be removed during our image processing. 
4. In the RGB domain, each component of the picture (red, green and blue) has a different brightness. However, in the YCbCr domain all information about the brightness is given by the Y component, since the Cb (blue) and Cr (red) components are independent from the luminosity.

## Conversion from RGB to YCbCr

Cb =  (0.148* Red)  - (0.291* Green)  + (0.439 * Blue)  + 128;
Cr =  (0.439 * Red)  - (0.368 * Green)  – (0.071 * Blue) + 128;

## Conversion from RGB to HSV

I' = rgb2hsv (I);


![image](https://user-images.githubusercontent.com/25412736/174872656-8d075644-7d69-4070-ac6b-07fb20652aeb.png)![image](https://user-images.githubusercontent.com/25412736/174872683-493f55d6-3190-4b5e-a32f-787f10eeae27.png)
(a) Input Image (b) Segmented Image from Input Image


![image](https://user-images.githubusercontent.com/25412736/174872791-0639de87-8e79-40fa-ad13-191184b0f9e6.png)![image](https://user-images.githubusercontent.com/25412736/174872784-64aa5375-019c-4aaa-8d2b-69be33fd67d5.png)![image](https://user-images.githubusercontent.com/25412736/174872809-14f540d8-149a-43da-b42c-bd4299090718.png)![image](https://user-images.githubusercontent.com/25412736/174872805-9472eaf8-7be2-4984-82cc-5bfe9020aef6.png)![image](https://user-images.githubusercontent.com/25412736/174872816-5ee9a5d5-a8ab-4146-8b01-a80339dd87db.png)![image](https://user-images.githubusercontent.com/25412736/174872830-2c064f4f-e203-46bf-afdd-a328b2852066.png)



## Decision Making
1. The first frame is used for learning. All the results are calculated taking first frame as ideal frame.
### Eyes Closed
When eyes are closed, the number of black pixels in binary image decreases considerably. If eyes are found closed for atleast 2 consecutive seconds (i.e. 2 * 16 = 32 frames, considering 16 frames per second), then the warning will be generated.

### Mouth Open
When mouth is open, the resulting black pixels in binary image can be considerably larger or smaller than the ideal frame. The difference can be more than 6% of the black pixels in ideal frame.If mouth is found open for atleast 2 consecutive seconds (i.e. 2 * 16 = 32 frames, considering 16 frames per second), it means that the person is yawning and in response the warning will be generated.
### Head Lowering
If the head is lowered, or turned around the number of skin pixels considerably decrease as compared to the ideal frame.If head is found lowered or found turned in other directions for atleast 2 consecutive seconds (i.e. 2 * 16 = 32 frames, considering 16 frames per second), it means that the person is vulnerable for accident and in response the warning will be generated.

## Limitations of the algorithm.

1. Objects in the video, should be uniformly illuminated, else results can differ.
2. Changing distance of person from the camera can cause problems.
3. Head lowering can give abrupt results in case of bald person.
4. The algorithm doesn’t work for the people sleeping with eyes open.
5. Face symmetry calculations are not same for everyone. The calculations considered are true for most of the people.

## Accuracy

The algorithm gives correct answer on about 25 videos that makes it about 83.33% accurate

