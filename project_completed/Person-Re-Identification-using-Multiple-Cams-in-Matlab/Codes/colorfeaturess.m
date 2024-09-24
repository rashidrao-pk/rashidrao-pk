function zout2 = colorfeatures( image )
% image=imread('peppers.png');
image=im2double(image);
RGB=image;
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);
meanR=mean(R);
meanG=mean(G);
meanB=mean(B);
SDR=std(R);
STDG=std(G);
STDB=std(B);
VR=var(R);
VG=var(G);
VB=var(B);

R_svd=svd(R);
G_svd=svd(G);
B_svd=svd(B);
if(size(R_svd,2)==1)
 R_svd=R_svd';
end
if(size(G_svd,2)==1)
 G_svd=G_svd';
end
if(size(B_svd,2)==1)
 B_svd=B_svd';
end

Fused=[meanR meanG meanB SDR STDG STDB VR VG VB R_svd G_svd B_svd];
zout1 = sort(Fused,'desc');
average=mean2(zout1);
for(i=1:size(zout1,2))
if(zout1(1:i)>=average)
zout2(1,i)=zout1(1,i);
else
    zout3(1,i)=zout1(1,i);
end
end
zout2=unique(zout2);
zout3=unique(zout3);
end

