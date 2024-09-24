alex = alexnet;
layers = alex.Layers;

layers(23) = fullyConnectedLayer(10);
layers(25) = classificationLayer;

allimages = imageDatastore('Dataset_Resized_Equal', 'IncludeSubFolders', true, 'LabelSource', 'foldernames');

%%
% outputFolder='F:\Research\Document Classification\Coding\';
% rootFolder = fullfile(outputFolder, 'Dataset_Resized_Equal');
% allfoldernames= struct2table(dir(rootFolder));
% for (i=3:height(allfoldernames))
%     new(i-2)=allfoldernames.name(i);
% end
% clear i
% % categories = {'airplanes', 'ferry', 'laptop'};
% categories=new;
% allimages = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
%%
allimages.ReadFcn = @(filename)readAndPreprocessImage(filename);


[trainingImages, testImages] = splitEachLabel(allimages, 0.3, 'randomize');

opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001, 'MaxEpochs', 20, 'MiniBatchSize', 64);
myNet = trainNetwork(trainingImages, layers, opts);

predictedLabels = classify(myNet, testImages);
accuracy = mean(predictedLabels == trainingImages.Labels);