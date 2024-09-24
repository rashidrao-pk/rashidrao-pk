clc;
close all;
clear all;
[filename,pathname]=uigetfile();

I=imread([pathname,filename]);
load('svmmodel.mat');
 Class=tellmeClass(I,svmmodel);
 position =  [1 50];
value = Class;
RGB = insertText(I,position,value,'AnchorPoint','LeftBottom');
figure
imshow(RGB),title('Numeric values');

