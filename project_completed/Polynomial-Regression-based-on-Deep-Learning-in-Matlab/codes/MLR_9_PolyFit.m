% MLR_9_PolyFit

% using polynomial base function

clc;
clear;
close all;

%% Generate data: generate t0 from x0
clear all; clc; close all;

% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);

x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is Charpy Energy
%% Splitting Data to Train and Test Portion

[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);


p = polyfit(xtrain,ytrain,16);

ypred = polyval (p,xtest);



