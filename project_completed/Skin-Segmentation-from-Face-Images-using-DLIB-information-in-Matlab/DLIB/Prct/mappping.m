
close all;
clear all
clc
pth=cd;
format long g;
format compact;
fontSize = 15;
% rgb = imread('2008_001322.jpg');

Detect_path='D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\DLIB';
DS_Path='D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\Extracted-Face-Skin';
cd(DS_Path)
[f,p]=uigetfile('*.*');
[in_file,in_path,in_ext]=fileparts([p,f]);

originalRGBImage=imread([p,f]);
originalRGBImage=imresize(originalRGBImage,[512,512]);
lab=rgb2lab(originalRGBImage);

%ITA Equation
L = lab(:,:,1);
a = lab(:,:,2);
b = lab(:,:,3);
y = atan((L-50)/b);
ITA = y * (180/3.14159);
disp(ITA);




grayImage = min(originalRGBImage, [], 3); % Useful for finding image and color map regions of image.
% Get the dimensions of the image.  numberOfColorChannels should be = 3.
[rows, columns, numberOfColorChannels] = size(originalRGBImage);
% Crop off the surrounding clutter to get the colorbar.
colorBarImage = imcrop(originalRGBImage, [1, 20, 17, rows]);
b = colorBarImage(:,:,3);
% Crop off the surrounding clutter to get the RGB image.
rgbImage = imcrop(originalRGBImage, [81, 1, columns-20, rows]);
% Get the dimensions of the image.  
% numberOfColorBands should be = 3.
[rows, columns, numberOfColorChannels] = size(rgbImage);
% Display the image.
subplot(2, 3, 2);
imshow(rgbImage, []);
axis on;
caption = sprintf('Cropped Pseudocolor Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
xlabel('Column', 'FontSize', fontSize, 'Interpreter', 'None');
ylabel('Row', 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
hp = impixelinfo();
% Display the colorbar image.
subplot(2, 3, 3);
imshow(colorBarImage, []);
axis on;
caption = sprintf('Cropped Colorbar Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
xlabel('Column', 'FontSize', fontSize, 'Interpreter', 'None');
ylabel('Row', 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0.05 1 0.95]);
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off') 
% Get the color map.
storedColorMap = colorBarImage(:,1,:);
% Need to call squeeze to get it from a 3D matrix to a 2-D matrix.
% Also need to divide by 255 since colormap values must be between 0 and 1.
storedColorMap = double(squeeze(storedColorMap)) / 255
% Need to flip up/down because the low rows are the high temperatures, not the low temperatures.
storedColorMap = flipud(storedColorMap);
% Convert from an RGB image to a grayscale, indexed, thermal image.
indexedImage = rgb2ind(rgbImage, storedColorMap);
% Display the thermal image.
subplot(2, 3, 4);
imshow(indexedImage, []);
axis on;
caption = sprintf('Indexed Image (Gray Scale Image)');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
% Define the temperature at the top end of the scale
% This will probably be the high temperature.
highTemp = 28.9;
% Define the temperature at the dark end of the scale
% This will probably be the low temperature.
lowTemp = 0.9;
% Scale the image so that it's actual temperatures
thermalImage = ITA * mat2gray(indexedImage);
subplot(2, 3, 5);
imshow(thermalImage, []);
axis on;
colorbar;
title('Floating Point Thermal (Temperature) Image', 'FontSize', fontSize, 'Interpreter', 'None');
hp = impixelinfo(); % Let user mouse around and see temperatures.
hp.Units = 'normalized';
hp.Position = [0.45, 0.03, 0.25, 0.05];
% Get the histogram of the indexed image
subplot(2, 3, 6);
histogram(thermalImage, 'Normalization', 'probability');
axis on;
grid on;
caption = sprintf('Histogram of Thermal Temperature Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
xlabel('Temperature', 'FontSize', fontSize, 'Interpreter', 'None');
ylabel('Frequency', 'FontSize', fontSize, 'Interpreter', 'None');
