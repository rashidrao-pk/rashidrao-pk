function [ class ] = tellmeClass( img ,svmmodel)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

 img=imresize(img,[128,96]);
    [featureVector, hogVisualization] = extractHOGFeatures(img);
    featureVector=double(featureVector);
%      [pc,score,latent,tsquare] = pca(featureVector);
   
class=predict(svmmodel,featureVector);

end

