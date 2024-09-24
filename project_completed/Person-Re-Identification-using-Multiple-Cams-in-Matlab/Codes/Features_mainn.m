% clc;
%  clear all
% tic
pathname='F:\Study\MS(CS)\All_datasets\VIPeR\cam_b';
imagespath=imageSet(pathname,'recursive');
imagecount=1;
 allfoldernames= struct2table(dir(pathname));
        for (i=3:height(allfoldernames))
            new(i-2)=allfoldernames.name(i);
        end
for i=1 : size(imagespath,2)
    m=size(imagespath(i).ImageLocation,2);
    temp=imagespath(i).ImageLocation;
     for j=1 :  m
        v{imagecount,1}=temp{j};
        if(~isempty(strfind(temp{j},new(1,i))))
                v{imagecount,2}=new(1,i);    
        else
            v{imagecount,2}='None';
        end
            img=imread(v{imagecount,1}); 
            if(size(img, 3) == 3)
            imggray=double(rgb2gray(img));
            end
             
            img=imresize(img,[128,96]);
%            colorfeat= colorfeaturess(img);
%            geofeat= geometric(img);
%             haralickfeat = haralickTextureFeatures(covector);
            colorfeat = extractHOGFeatures(img);
%             haralickfeat(isnan(haralickfeat))=0;
% % % % % % % % % % % % % % % % % % 
             featurecolor{imagecount,1}=colorfeat(1,:);  
%              featuregeo{imagecount,1}=geofeat(1,:);
%               featureshape{imagecount,1}=Shapefeatures(1,:);
%              featureharalick{imagecount,1}=haralickfeat(1,:);
        imagecount=imagecount+1;
     end
end
%%
maxSize = max(cellfun(@numel,featurecolor)); 
minSize = min(cellfun(@numel,featurecolor)); 
avg=(maxSize+minSize)/2;
for i=1:length(featurecolor)
    pad=maxSize-length(featurecolor{i}); 
    featurecolornew{i,:}= padarray(featurecolor{i},[0 pad],3.7739,'post');
    ftemp=double(featurecolornew{i});
    FV1(i,:)=ftemp;
end
% for i=1:length(featuregeo)
%     ftemp1=double(featuregeo{i});
%     FV2(i,:)=ftemp1;
% end
% for i=1:length(featureharalick)
%     ftemp2=double(featureharalick{i});
%     FV3(i,:)=ftemp1;
% end
% for i=1:length(featureshape)
%     
%     ftemp3=double(featureshape{i});
%     
%     FV4(i,:)=ftemp3;  
% end

%%
y=v(:,2);
%%

[r, c]=size(FV1);
new_score = Find_Entropy(FV1,c);
ent_FV2 = real(new_score(:,:));
FV2=ent_FV2 ;
%%
opts2 = statset('Display','final');
[idx2,C2] = kmeans(FV1,6,'Distance','cityblock',...
    'Replicates',5,'Options',opts);


% %% 
% figure;
% plot(FV1(idx==1,1),FV1(idx==1,2),'r.','MarkerSize',12)
% hold on
% plot(FV1(idx==2,1),FV1(idx==2,2),'b.','MarkerSize',12)
% 
% plot(FV1(idx==3,1),FV1(idx==3,2),'g.','MarkerSize',12)
% 
% plot(FV1(idx==4,1),FV1(idx==4,2),'c.','MarkerSize',12)
% 
% plot(FV1(idx==5,1),FV1(idx==5,2),'y.','MarkerSize',12)
% 
% plot(FV1(idx==6,1),FV1(idx==6,2),'m.','MarkerSize',12)
% 
% 
% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3) 
% legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6','Centroids',...
%        'Location','NW')
% title 'Cluster Assignments and Centroids'
% hold off

%%  DEEP NET

outputFolder='F:\Study\MS(CS)\All_datasets\VIPeR';
rootFolder = fullfile(outputFolder, 'cam_b');
allfoldernames= struct2table(dir(rootFolder));

categories = {'cam_b'};
imds = imageDatastore(fullfile(outputFolder, categories), 'LabelSource','foldernames');
tbl = countEachLabel(imds);
minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');
% Notice that each set now has exactly the same number of images.
countEachLabel(imds)


%%
% Find the first instance of an image for each category
%% Pretrained Net AlexNet
net = alexnet();
net.Layers(1);
net.Layers(end);

imr2=net.Layers(1, 1).InputSize(:,1);
imc2=net.Layers(1, 1).InputSize(:,2);

imds.ReadFcn = @(filename)readAndPreprocessImage(filename,imr2,imc2);
[trainingSet2, testSet2] = splitEachLabel(imds, 0.001, 'randomize');
% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;
%%   Resize weigts for vgg only
% w1 = imresize(w1,[227 227]);
%%
featureLayer = 'fc8';
%featureLayer = 'pool5-drop_7x7_s1';
%%
trainingFeatures2 = activations(net, trainingSet, featureLayer, ...
 'MiniBatchSize', 64, 'OutputAs', 'columns');
%%
% Get training labels from the trainingSet
trainingLabels2 = trainingSet2.Labels;
% Train multiclass SVM classifier using a fast linear solver, and set
% 'ObservationsIn' to 'columns' to match the arrangement used for training
% features.
classifier2 = fitcecoc(trainingFeatures2, trainingLabels2, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
%%
%%
% Extract test features using the CNN
testFeatures2 = activations(net, testSet2, featureLayer, 'MiniBatchSize',64);
 

count=1;
for i=1:size(DeepFV,1)
    if(DeepFV(i,end)==4)
    FVFinal(count,:)=DeepFV(i,:);
    count=count+1;
    end
    
end
