classifier = fitcecoc(trainingFeatures, trainingLabels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');

% % Tabulate the results using a confusion matrix.
%confMat = confusionmat(testLabels, preadictedLabels);
% % Convert confusion matrix into percentage form
% confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
% % Display the mean accuracy
% mean(diag(confMat))
%cd D:\Study\Thesis\Document Classification\Coding
%%  Testing
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
imgname=horzcat(pathname,filename);

%%label=testingdeepnet(imgname,xy,net,featureLayer)
foldername=regexp(pathname,'\','split');
foldername=foldername{end-1};
newImage = fullfile(pathname,filename);
% Pre-process the images as required for the CNN
imr=net.Layers(1, 1).InputSize(:,1);
imc=net.Layers(1, 1).InputSize(:,2);
img = readAndPreprocessImage(newImage, imr, imc);
% Extract image features using the CNN
imageFeatures = activations(net, img, 'fc7');

% Make a prediction using the classifier
label = predict(classifier, imageFeatures);
position = [35 185];
box_color = {'green'};
Label_text=cellstr(label);
predicted_Image_with_Label = insertText(img,position,Label_text,'FontSize',18,'BoxColor',...
    box_color,'BoxOpacity',0.4,'TextColor','black');

figure
imshow(predicted_Image_with_Label);
title('Predicted Image With Label');