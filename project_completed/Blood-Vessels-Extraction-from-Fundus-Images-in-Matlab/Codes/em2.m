clc; clear all; close all; 
 %myFolder2 = './mes_ex';
 myFolder = 'E:\MS(CS)\Others\Online\Fiverr\himas_legal_diabetic\Dataset\Disc_Swelling_ODE';

filename = 'result.csv';
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist: \n%s',myFolder);
    uiwait(warndlg(errorMessage));
    return ;
end
filePattern = fullfile(myFolder, '*.jpg');
theFiles = dir(filePattern);
%filePattern2 = fullfile(myFolder2, '*.jpg');
%theFiles2 = dir(filePattern2);
 
for n =21:30
    tic
    baseFileName = theFiles(n).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1,'Now reading %s\n', fullFileName);
    %baseFileName2 = theFiles2(n).name;
    %fullFileName2 = fullfile(myFolder2, baseFileName2);
    %fprintf(1,'Now reading %s\n', fullFileName2);
    
   I = imread(fullFileName);
   %I2 = imread(fullFileName2);
 
    G = rgb2gray(I);
    J = adapthisteq(G);
    hsv = rgb2hsv(I);
    h = hsv(:,:,1);
    hs = hsv(:,:,2);
    v = hsv(:,:,3);
    rgb = I;
    D  = im2double(G);

    greenChannel = I(:,:,2);
    redChannel = I(:,:,1);
    blueChannel = I(:,:,3);
    allBlack = zeros(size(I,1),size(I,2),'uint8');
    just_green = cat(3,allBlack,greenChannel,allBlack);
    just_red = cat(3,redChannel,allBlack,allBlack);
    just_blue = cat(3,allBlack,allBlack,blueChannel);
    ggreen =  rgb2gray(just_green);
    gred =  rgb2gray(just_red);
    gblue =  rgb2gray(just_blue);
    Iblur3 = imgaussfilt(J,4);
    hsv = rgb2hsv(I);
    h = hsv(:,:,1);
  %% Vessel Extraction
  
  ves_Img = blood_vessel(G,60);
  bw_b = ves_Img;
  %bw_b = imread('vessels1.png');
  blob = regionprops(bw_b, G,'Centroid', 'PixelIdxList','MeanIntensity', 'MajorAxisLength', 'MinorAxisLength');
  mean_in = cat(1,blob.MeanIntensity);
  min_inT = min(mean_in);
  
  maskImage = I;
  maskImage(repmat(bw_b,[1 1 3])) = 1;
  G2 = rgb2gray(maskImage);
  J2 = adapthisteq(G2);
    hee = regionprops(bw_b,h,'Centroid','MeanIntensity');
    hes = regionprops(bw_b,hs,'Centroid','MeanIntensity');
    hev = regionprops(bw_b,v,'Centroid','MeanIntensity');
    mean_h = cat(1,hee.MeanIntensity);
    mean_s = cat(1,hes.MeanIntensity);
    mean_v = cat(1,hev.MeanIntensity);
    min_h = min(mean_h);
    mean_h2 = mean(mean_h);
    min_h2 = min(mean_h);
    max_h2 = max(mean_h);
    mean_s2 = mean(mean_s);
    min_s2 = min(mean_s);
    max_s2 = max(mean_s);
    mean_v2 = mean(mean_v);
    min_v2 = min(mean_v);
    max_v2 = max(mean_v);


   %% OD localization
   
    H = adapthisteq(gred);
    [x1c,y1c,x2c,y2c,x3c,y3c,x4c,y4c,hwc,hcc] = position_boun(G);
    radius = hwc;
    [od_region,xc1,yc1] = od_centroid(gred,radius); 
    position = [x1c y1c x2c y2c x3c y3c x4c y4c radius];
    
    xc2 = xc1;
    yc2 = yc1;

    b = 1/2 * radius;
    b2 = 1/3 * radius;
    b3 = 1/4 * radius;
    xLeft = xc2 - b/3;
    yBottom = yc2 - b/3;
    FB = [xLeft yBottom b3 b3];
    %%<< boundaty outside OD=========>
    theta2 = 0:10:360;
    x2 = ceil(b3*cos(theta2)+xc2);
    y2 = ceil(b3*sin(theta2)+yc2);
  %%<<======boundary inside =========================
    ri = 10;
    theta3 = 0:30:360;
    x3 =ceil(b3*cos(theta3)+xc2);
    y3 = ceil(b3*sin(theta3)+yc2);
    th = linspace(0,2*pi) ;
    theta4 = 0:5:360;
    x31 =ceil(b3*cos(th)+xc2);
    y31 = ceil(b3*sin(th)+yc2);
    be = poly2mask(x31,y31,size(I,1),size(I,2));
    
  %% Exudate and hemorrhage segmentation  
    
    se4 = strel('disk',20);
    se2 = strel('disk',5);
    %% exudate
    me_ex = exudate_detect(I,be,xc1,yc1);
     %% hemorrhage
    [me_h] = hae_detect(I,min_inT,G2);
     
    sh9 = regionprops(me_h,J,'Centroid','BoundingBox','Eccentricity','MeanIntensity','Area','MinIntensity');
    mean_in2 = cat(1,sh9.MeanIntensity);
    min_in2 = cat(1,sh9.MinIntensity);
    min_h22 = min(min_in2);
    mean_h22 = mean(min_in2);

     if(isempty(min_h22))
         min_h22 = 50;
     end

    tth = J2>=min_h22 & J2 <mean_h22+10;
    tth = bwareaopen(tth,100);

    tt3 = tth & me_h;
    tt3 = imclose(tt3,se2);
%% Decision Tree

    bw_final2 = hae_condition2(tt3,I,mean_h2,mean_s2);
    bw_final3 = imclose(bw_final2,se2);
    bex = regionprops(me_ex,'Centroid');
    bhh = regionprops(bw_final3,'Centroid');
    text = 0;
    texth = 0;
    texte = 0;
   
    if(length(bex)>0)
         result = me_ex | bw_final3; 
    else
         result = bw_final3;
    end
%     if(length(bhh)>0)
%         
%              texth = 1;
%     else
%               texth = 0;
%     end
    
     dr_r = regionprops(result,'Centroid');
     if(length(dr_r)>0)
         %% abnormal
         text = 1;
         
     else
         %% normal
          text = 0;
     end

    figure
    imshow(I)
    hold on
    %visboundaries(me_ex,'Color','r','LineWidth',2);
    visboundaries(result,'Color','r','LineWidth',2);
    hold off

end
