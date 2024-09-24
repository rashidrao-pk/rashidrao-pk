function [inpaintedImg1] = inpainting_setup(origImg,mask)

%% step 2 - inpainting

psz=21;
%% Getting Boundry 
% [boundry,boundry2]=get_boundry(mask);
%%  Inpainting
[inpaintedImg1,C2,D2,fillMovie2] = inpainting(origImg,mask,psz);
% [inpaintedImg2,C1,D1,fillMovie1] = inpainting(origImg,boundry2,psz);
% [inpaintedImg3,C3,D3,fillMovie3] = inpainting(origImg,boundry,psz);
inpaintedImg1=uint8(inpaintedImg1);
end

