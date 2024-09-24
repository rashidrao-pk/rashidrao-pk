% %https://www.mathworks.com/help/vision/examples/image-category-classification-using-deep-learning.html
clc
clear all
outputFolder='D:\Study\Thesis\Document Classification\Coding';
rootFolder = fullfile(outputFolder, 'Dataset_Resized_Equal');
allfoldernames= struct2table(dir(rootFolder));
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
clear i
categories=new;
%categories1 = {'airplanes', 'ferry', 'laptop'};
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource','foldernames');
tbl = countEachLabel(imds);
minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');
% Notice that each set now has exactly the same number of images.
countEachLabel(imds);
%%


%%

% Find the first instance of an image for each category
%% Pretrained Net AlexNet
net = vgg19();
net.Layers(1);
net.Layers(end);

imr=net.Layers(1, 1).InputSize(:,1);
imc=net.Layers(1, 1).InputSize(:,2);

imds.ReadFcn = @(filename)readAndPreprocessImage(filename,imr,imc);
[trainingSet, testSet] = splitEachLabel(imds, 0.3, 'randomize');
% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;
%%   Resize weigts for vgg only
w1 = imresize(w1,[224 224]);
%%
featureLayer = 'fc7';
%featureLayer = 'pool5-drop_7x7_s1';
%%
trainingFeatures = activations(net, trainingSet, featureLayer, ...
 'MiniBatchSize', 64, 'OutputAs', 'columns');
%%
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
testFeatures = activations(net, testSet, featureLayer, 'MiniBatchSize',64);
%%
% Pass CNN image features to trained classifier
predictedLabels = predict(classifier, testFeatures);
%%
% Get the known labels
testLabels = testSet.Labels;
% x feature vector
x=testFeatures;
y=testLabels;

xy=array2table(x);
xy.type=y;

cd D:\Study\Thesis\Document Classification\Coding\

%%save model

save