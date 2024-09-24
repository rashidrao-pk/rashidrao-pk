clc;
clear all;
close all;
imagespath=imageSet('D:\paper5\t','recursive');
imagecount=1;
% s = size(imagespath,4);
for i=1 : size(imagespath,2)
    m=size(imagespath(i).ImageLocation,2);
    temp=imagespath(i).ImageLocation;
     for j=1 :  m
        v{imagecount,1}=temp{j};
        if(~isempty(strfind(temp{j},'Run')))
                v{imagecount,2}='R';
           
                else
                  v{imagecount,2}='W'; 
            end
            for k = 1 : m
    try
         img=imread(v{imagecount,1});
    catch
        continue;
    end
            end
          
%   img=rgb2gray(img);
%             img=single(img);
%         
            
            
            img=imresize(img,[128,64]);

%              img = imadjust(Ienhance,stretchlim(Ienhance));
%              B = img(:,:,3);
             [featureVector, hogVisualization] = extractHOGFeatures(img);
            
            feature{imagecount,1}=featureVector(1,:);

        imagecount=imagecount+1;
     end
     end

for i=1:length(feature)
    
    ftemp=double(feature{i});
    
    FV(i,:)=ftemp;  
end

X=v(:,2);


%  [pc,score,latent,tsquare] = princomp(FV);
%     [pc,score,latent] = pca(FV);
% Only PCA
  [pc,score] = princomp(FV);

  red_dim_Hog = score(:,1:500);



  Vector = horzcat(red_dim_Hog);
  Vector(:,size(Vector,2)+1)=cell2mat(X);
%   save red_dim.mat
  

%% Color features

% function color=colorfeatures(I)
% I2=imrread(I);
% R=I2(:,:,1);
% meanR=mean2(R);
% stdR=std(R);
% SkR=skewness(R);
% 
% color=horzcat(meanR stdR SkR);
% end
%  