% %  Clear All exisitng Workspace Variable (if any)
% %  closing all opened figure (if any)
% %  clearing all line in the command window and showing workspace tab if
% not existing 

clc; clear all; close all; workspace;
Current_Path=cd;
cd ..
cd lesionimages\
cd Results
pathname=cd;
imagespath=imageSet(pathname,'recursive');
Resized_Img_Size=[256,256];

imagecount=1;
allfoldernames= struct2table(dir(pathname));
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
%% Dataset Splitting for Training and Testing
trainingDataSizePercent = 80;
[trainingSet, validationSet] = partition(imagespath, trainingDataSizePercent/100, 'sequential');
%% Nested Loop 
%% Outer loop is for traverse though lesion type)
%% Inner Loop is to traverse through all images in corrosponding Class 
for i=1 : size(trainingSet,2)
    img_per_foldr=size(trainingSet(i).ImageLocation,2);
    temp=trainingSet(i).ImageLocation;
    for j=1 :  img_per_foldr
        v{imagecount,1}=temp{j};
        v{imagecount,2}=new(1,i);
        
        img=imread(v{imagecount,1});
        if size(img,2)> 256
        img= imresize(img,Resized_Img_Size);
        end
        if size(img,3) == 3
        G = double(rgb2gray(img));
        else
        G = img;
        end
        %% Feature Extraction
%      Feature 1 -> HoG Features
        cd(Current_Path)
       [featureVector, hogVisualization] = extractHOGFeatures(img);       
       FV1_HoG(imagecount,:)=double(featureVector(1,:));
%        Feature 2 -> Color Features
       FV2_Color(imagecount,:) = fun_Color_Features(img)';
%        FV3_LBP(imagecount,:) = extractLBPFeatures(G);           
       
       %% Showing Extracted Hog Features
%        figure(1),
%        subplot(2,2,1),imshow(img),title('Input Image');
%        subplot(2,2,2),plot(hogVisualization),title('HOG Visualization');
%%       increment in image number to travserse all images
        imagecount=imagecount+1;
%         showing iteration no from inner loop, displaying pregress of
%         these phases
        disp([num2str(i),':',num2str( j)]);
     end
end
clear i

%   getting Class Labels and saving to a variable
Class_Labels_Train=v(:,2);

%% Feature Reduction using own Entropy Function
%   Hog Features
FV1_HoG_Down = fun_entropy(FV1_HoG,340);
% FV2_Color_Down = fun_entropy(FV2_Color,45);

%% Feature Fusion after Feature Selection
% Reduced FV1 + FV2
% FV_Fused_Down=horzcat(FV1_HoG_Down,FV2_Color_Down);
FV_Fused_Down=horzcat(FV1_HoG_Down,FV2_Color);

% Full FV1 + FV2 without Feature Selection
FV_Fused_Full=horzcat(FV2_Color,FV1_HoG);

%% Adding Class Label at First Index because Supervised Learning
Final_FV_Down=horzcat(Class_Labels_Train,num2cell(FV_Fused_Down));

Final_FV1_Down=horzcat(Class_Labels_Train,num2cell(FV1_HoG_Down));
Final_FV2=horzcat(Class_Labels_Train,num2cell(FV2_Color));

Final_FV_Full=horzcat(Class_Labels_Train,num2cell(FV_Fused_Full));

%% Converting to Table so that it could be passed to classification learner app 
%   from Copmuter Vision Toolbox
Final_FV_Full=cell2table(Final_FV_Full);
Final_FV_Down=cell2table(Final_FV_Down);

Final_FV1_Down=cell2table(Final_FV1_Down);
Final_FV2=cell2table(Final_FV2);

%% Training SVM Code
svmmodel=fitcsvm(FV_Fused_Down,string(Class_Labels_Train));
% fitcsvm can also be used
save svmmodel;

