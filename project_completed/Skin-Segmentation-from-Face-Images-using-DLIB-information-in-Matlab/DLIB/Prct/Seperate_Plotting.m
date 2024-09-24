%% Plotting 1
% %  Cheek Right
figure(7),
subplot(221),imshow(rgb),title('Mapped ITA P1');
hold on
OverlayImage = imshow( ITA_cheek_right );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );
%% Plotting 2
% %  Cheek Left
subplot(222),imshow(rgb),title('Mapped ITA P2');
hold on
OverlayImage = imshow( ITA_cheek_left );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );
%% Plotting 3
% %  Chin
subplot(223),imshow(rgb),title('Mapped ITA P3');
hold on
OverlayImage = imshow( ITA_chin );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );
%% Plotting 4
% %  Forehead
subplot(224),imshow(rgb),title('Mapped ITA P4');
hold on
OverlayImage = imshow( ITA_forehead );
caxis auto  
colormap( OverlayImage.Parent, jet );
colorbar( OverlayImage.Parent );
set( OverlayImage, 'AlphaData', alpha );