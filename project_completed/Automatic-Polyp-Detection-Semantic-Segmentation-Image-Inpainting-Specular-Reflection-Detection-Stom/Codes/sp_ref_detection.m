function binaryImage = sp_ref_detection(rgbimage)
hsi= rgb2hsi(rgbimage);
hh = hsi(:,:,1);
ss = hsi(:,:,2);
ii = hsi(:,:,3);

threshold_1=0.25;
threshold_2=0.80;
%% 
binaryImage = (ss <= threshold_1 ) & (ii >= threshold_2);
end

