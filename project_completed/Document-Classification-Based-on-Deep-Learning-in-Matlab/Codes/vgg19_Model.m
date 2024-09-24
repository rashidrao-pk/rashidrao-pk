% %https://www.mathworks.com/help/vision/examples/image-category-classification-using-deep-learning.html
clc;
close all;
clear all;
outputFolder='F:\Study\MS(CS)\Inzoogee\Coding\';
rootFolder = fullfile(outputFolder, 'Dataset_Resized_Equal');
% rootFolder = fullfile(outputFolder, 'Dataset_Resized_Equal');
allfoldernames= struct2table(dir(rootFolder));
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
clear i
% categories = {'airplanes', 'ferry', 'laptop'};
categories=new;
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
tbl = countEachLabel(imds);
minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');
% Notice that each set now has exactly the same number of images.
countEachLabel(imds);
minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');
% Notice that each set now has exactly the same number of images.
countEachLabel(imds);
% Find the first instance of an image for each category


%% Pretrained Net AlexNet
net = vgg19();
net.Layers(1);
net.Layers(end);
numel(net.Layers(end).ClassNames);

imr=net.Layers(1, 1).InputSize(:,1);
imc=net.Layers(1, 1).InputSize(:,2);

imds.ReadFcn = @(filename)readAndPreprocessImage(filename,imr,imc);

% imds.ReadFcn = @(filename)readAndPreprocessImage(filename);
[trainingSet, testSet] = splitEachLabel(imds, 0.3, 'randomize');
% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;
% Scale and resize the weights for visualization
w1 = mat2gray(w1);
w1 = imresize(w1,[224 224]);

featureLayer = 'fc7';

trainingFeatures = activations(net, trainingSet, featureLayer, 'MiniBatchSize',128);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% b

classifier = fitcecoc(trainingFeatures, trainingLabels);
%%
%%
% Extract test features using the CNN
testFeatures = activations(net, testSet, featureLayer, 'MiniBatchSize',128);
% Pass CNN image features to trained classifier
predictedLabels = predict(classifier, testFeatures);
% Get the known labels
testLabels = testSet.Labels;
%%
% x feature vector
x=testFeatures;
% y is label
y=cellstr(testLabels);
%   XY is feature,label
xy=array2table(x);
xy.type=y;
