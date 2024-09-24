% Enter data by hand if data from a ThingSpeak channel is not available.
strength = [-90 -90 -90 -90 -40 -20 -22.4 -45 -35 -41 -44 -55 -40 -75 -26]';
% Read data from a ThingSpeak channel.
% Uncomment the next line to read from ThingSpeak.
% strength = thingSpeakRead(CHANNEL_ID, 'ReadKey',READ_API_KEY,'numPoints',15,'fields',FIELD_NUMBER');
X =ITA();
Y = ITA(:,:);

strengthPercent = 2*(strength+100)/100;

picture = rgb; 
[height,width,depth] = size(picture);


OverlayImage=[];
F = scatteredInterpolant(Y, X, strengthPercent,'linear');
for i = 1:height-1
   for j = 1:width-1
          OverlayImage(i,j) = F(i,j);
   end
end
alpha = (~isnan(OverlayImage))*0.6;


imshow(picture);
hold on
OverlayImage = imshow( OverlayImage );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );