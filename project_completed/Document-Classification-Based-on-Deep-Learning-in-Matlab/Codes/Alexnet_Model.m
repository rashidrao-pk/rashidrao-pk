% %https://www.mathworks.com/help/vision/examples/image-category-classification-using-deep-learning.html
clc;
close all;
clear all;
outputFolder='E:\Inzamam\Coding\';
rootFolder = fullfile(outputFolder, 'Dataset_Resized_Equal');
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
net = alexnet();
net.Layers(1);
net.Layers(end);
numel(net.Layers(end).ClassNames);


imds.ReadFcn = @(filename)readAndPreprocessImage(filename);
[trainingSet, testSet] = splitEachLabel(imds, 0.4, 'randomize');
% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;
% Scale and resize the weights for visualization
% w1 = mat2gray(w1);
%  w1 = imresize(w1,[228 228]);
% Display a montage of network weights. There are 96 individual sets of
% weights in the first layer.
% figure
% montage(w1);
% title('First convolutional layer weights');
featureLayer = 'fc6';
% featureLayer = 'activation_46_relu';

trainingFeatures = activations(net, trainingSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
% trainingFeatures = activations(net, trainingSet, featureLayer);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Get training labels from the trainingSet
trainingLabels = trainingSet.Labels;
% Train multiclass SVM classifier using a fast linear solver, and set
% 'ObservationsIn' to 'columns' to match the arrangement used for training
% features.
classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
%%
%%
% Extract test features using the CNN
testFeatures = activations(net, testSet, featureLayer, 'MiniBatchSize',32);
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
