function h=fun_plotmatches(I1,I2,P1,P2,matches,varargin)
% PLOTMATCHES  Plot keypoint matches
%   PLOTMATCHES(I1,I2,P1,P2,MATCHES) plots the two images I1 and I2
%   and lines connecting the frames (keypoints) P1 and P2 as specified
%   by MATCHES.
%
%   P1 and P2 specify two sets of frames, one per column. The first
%   two elements of each column specify the X,Y coordinates of the
%   corresponding frame. Any other element is ignored.
%
%   MATCHES specifies a set of matches, one per column. The two
%   elementes of each column are two indexes in the sets P1 and P2
%   respectively.
%
%   The images I1 and I2 might be either both grayscale or both color
%   and must have DOUBLE storage class. If they are color the range
%   must be normalized in [0,1].
%

[M1,N1,K1]=size(I1) ;
[M2,N2,K2]=size(I2) ;

    N3=N1+N2 ;
    M3=max(M1,M2) ;
    oj=N1 ;
    oi=0 ;

% Combine the two images. In most cases just place one image next to
% the other. If the stacking is 'o', however, combine the two images
% linearly.
figure,
axes('Position', [0 0 1 1]) ;
% imagesc(I) ; 
imshowpair(I1,I2,'montage')
hold on ; axis image ; axis off ;

K = size(matches, 2) ;
nans = NaN * ones(1,K) ;

x = [ P1(1,matches(1,:)) ; P2(1,matches(2,:))+oj ; nans ] ;
y = [ P1(2,matches(1,:)) ; P2(2,matches(2,:))+oi ; nans ] ;

h = plot(x(:),y(:),'g.') ;
title('Matched Features from Both Images');
