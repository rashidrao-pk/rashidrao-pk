clear all; clc; close all;

curr_path=cd;
% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);


x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure

rng("default") % For reproducibility of the partition
c = cvpartition(length(y),"Holdout",0.20);
trainingIdx = training(c); % Indices for the training set
XTrain = X(trainingIdx,:);
YTrain = y(trainingIdx);
testIdx = test(c); % Indices for the test set
XTest = X(testIdx,:);
YTest = y(testIdx);

Mdl = fitrnet(XTrain,YTrain,"Standardize",true, ...
    "LayerSizes",[30 10])