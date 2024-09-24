ITA_rot = imresize(imrotate(ITA,-20),1.2);
points1 = detectSURFFeatures(rgb_cropped_gray);
points2 = detectSURFFeatures(ITA_rot);

[f1,vpts1] = extractFeatures(rgb_cropped_gray,points1);
[f2,vpts2] = extractFeatures(ITA_rot,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));


figure; showMatchedFeatures(rgb_cropped_gray,ITA_rot,matchedPoints1,matchedPoints2);
legend('matched points 1','matched points 2');