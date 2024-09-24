clc
clear all
close all
%% Testing
code_path=cd;
% %  Load Trained Classifier from Direcotry
load(uigetfile({'*.mat'},'Pick Trained Classifier'));

imagecount=1;
%  Testing
for i=1 : size(validationSet,2)
    m=size(validationSet(i).ImageLocation,2);
    temp=validationSet(i).ImageLocation;
    for j=1 :  m
%         Saving Test Image paths and labels to v_test
        v_test{imagecount,1}=temp{j};
        v_test{imagecount,2}=new(1,i);
        img=imread(v{imagecount,1});
        if size(img,2)> 256
        img= imresize(img,Resized_Img_Size);
        end
%          Extract HoG Features for test dataset        
        [featureVector, hogVisualization] = extractHOGFeatures(img); 
%        Extract Color Features for test dataset
      Test_FV1_HoG(imagecount,:)=double(featureVector(1,:));
%        Feature 2 -> Color Features
       Test_FV2_Color(imagecount,:) = fun_Color_Features(img)';
       imagecount=imagecount+1;
        disp([num2str(i),':',num2str( j)]);
    end
end
% %  Getting Actual Labels for test Dataset
   Labels_Actual_Testing=string(v_test(:,2)); 
%%    Applying Feature Reduction on the HoG Feature
    Test_FV1_HoG_Down = fun_entropy(Test_FV1_HoG,340);
%     Test_FV2_Color_Down = fun_entropy(Test_FV2_Color,45);
%%      Feature Fusion
   Test_FV=horzcat(Test_FV1_HoG_Down,Test_FV2_Color);
%     Test_FV=horzcat(Test_FV1_HoG_Down,Test_FV2_Color);

Labels_Predicted_Testing=string(predict(svmmodel,Test_FV));
% %   Make Confusion Matrix
% Tabulate the results using a confusion matrix.
confMat = confusionmat(Labels_Actual_Testing, Labels_Predicted_Testing)

% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
% Plot Confusion Matrix

confusionchart(Labels_Actual_Testing,Labels_Predicted_Testing)

% Display the mean accuracy
disp(['Test Accuracy -> ', num2str(mean(diag(confMat))*100)]);
% Accuracy 
accuracy = mean(Labels_Predicted_Testing == Labels_Actual_Testing);

%% Inserting Class Label

%% Testing 
%  Selecting 4 images randomly from test Set
idx = randperm(numel(v_test(:,1)),16);
% Making Figure named as Testing
figure('Name','Testing')
%  Getting total no of images for visualization for loop
total_test_imgs=size(idx,2);
for i = 1:total_test_imgs
%     Dynamically creating subplot
    subplot(sqrt(total_test_imgs),sqrt(total_test_imgs),i)
%     set(gca, 'Position', [0.5, 0.5, 0.5, 0.5]);

    I = imread(string(v_test(idx(i),1)));
    label = Labels_Predicted_Testing(idx(i));
    title(string(label));
    [r c j]=size(I);
%     Putting Predicted Label onto image by using Dynamic Location
    position = [(r/3),5];
    value = char(label(1));
%     Inserting Text to existing Figure
    RGB = insertText(I,position,value,'FontSize',20);
%      Showing Figures
    imshow(RGB),title(Labels_Actual_Testing(idx(i)));
end