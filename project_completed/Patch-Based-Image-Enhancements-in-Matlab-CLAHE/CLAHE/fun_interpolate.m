function [CEImage]= fun_interpolate(Image,XRes,YRes,Min,Max,NrX,NrY,NrBins,Cliplimit)
%    Image - The input/output image
%    XRes - Image resolution in the X direction
%    YRes - Image resolution in the Y direction
%    Min - Minimum greyvalue of input image (also becomes minimum of output image)
%    Max - Maximum greyvalue of input image (also becomes maximum of output image)
%    NrX - Number of contextial regions in the X direction (min 2, max uiMAX_REG_X)
%    NrY - Number of contextial regions in the Y direction (min 2, max uiMAX_REG_Y)
%    NrBins - Number of greybins for histogram ("dynamic range")
%    Cliplimit - Normalized cliplimit (higher values give more contrast)
%  The number of "effective" greylevels in the output image is set by uiNrBins; selecting
%  a small value (eg. 128) speeds up processing and still produce an output image of
%  good quality. The output image will have the same minimum and maximum value as the input

Image=Image+1;
[XSize,YSize]=size(Image);
NrPixels = XSize*YSize;

if Cliplimit == 1
    return
end
if Cliplimit > 0 
    ClipLimit = max(1,Cliplimit*XSize*YSize/NrBins);
else
    ClipLimit = 1E8;
end
LUT=makeLUT(Min,Max,NrBins);
% avgBin = NrPixels/NrBins;
Bin=1+LUT(round(Image));

Hist = makeHistogram(Bin,XSize,YSize,NrX,NrY,NrBins);
if Cliplimit > 0
    Hist = clipHistogram(Hist,NrBins,ClipLimit,NrX,NrY);
end
Map=mapHistogram(Hist,Min,Max,NrBins,NrPixels,NrX,NrY);


% XRes=128;
% YRes=128;



% Interpolate
xI = 1;
for i = 1:NrX+1
    if i == 1
        subX = XSize/2;
        xU = 1;
        xB = 1;
    elseif i == NrX+1
        subX = XSize/2;
        xU = NrX;
        xB = NrX;
    else
        subX = XSize;
        xU = i - 1;
        xB = i;
    end
    yI = 1;
    for j = 1:NrY+1
        if j == 1
            subY = YSize/2;
            yL = 1;
            yR = 1;
        elseif j == NrY+1
            subY = YSize/2;
            yL = NrY;
            yR = NrY;
        else
            subY = YSize;
            yL = j - 1;
            yR = j;
        end
        UL = Map(xU,yL,:);
        UR = Map(xU,yR,:);
        BL = Map(xB,yL,:);
        BR = Map(xB,yR,:);
        subImage = Bin(xI:xI+subX-1,yI:yI+subY-1);
%         figure,imshow(uint8(subImage));
%         subImage = interpolate(subImage,UL,UR,BL,BR,subX,subY);
        CEImage(xI:xI+subX-1,yI:yI+subY-1) = subImage;
        yI = yI + subY;
    end
    xI = xI + subX;
end
end