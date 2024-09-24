function [zout2] = colorfeatures(img)
% % img=imread('F:\Study\MS(CS)\Attique_Data\Ulcer\Dataset\ulcer\0.jpg');
image=im2double(img);
%%      RGB
R=image(:,:,1);
G=image(:,:,2);
B=image(:,:,3);
% % % % % % % % % % % % % 
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
% % % % % % % % % % % % 
Rmean=mean2(R);
Ren=entropy(R);
Rs=skewness(R);
Rs(isnan(Rs))=[];
Rk=kurtosis(R);
Rk(isnan(Rk))=[];
Rhar = harmmean(R);
% % % % % % % % % % % % % % % 
Gmean=mean2(G);
Gen=entropy(G);
Gs=skewness(G);
Gs(isnan(Gs))=[];
Gk=kurtosis(G);
Gk(isnan(Gk))=[];
Ghar = harmmean(G);
% % % % % % % % % % % % % % 
Bmean=mean2(B);
Ben=entropy(B);
Bs=skewness(B);
Bs(isnan(Bs))=[];
Bk=kurtosis(B);
Bk(isnan(Bk))=[];
Bhar = harmmean(B);
%%      YCbCr
YCbCr=rgb2ycbcr(image);
% % % % % % % % % % % 
Y=YCbCr(:,:,1);
Cb=YCbCr(:,:,2);
Cr=YCbCr(:,:,3);
% % % % % % % % % %    SVD 
Y_svd=svd(Y);
Cb_svd=svd(Cb);
Cr_svd=svd(Cr);


if(size(Y_svd,2)==1)
 Y_svd=Y_svd';
end
if(size(Cb_svd,2)==1)
 Cb_svd=Cb_svd';
end
if(size(Cr_svd,2)==1)
 Cr_svd=Cr_svd';
end
% % % % % % % % % % % % % 
Ymean=mean2(Y);
Yen=entropy(Y);
Ys=skewness(Y);
Yk=kurtosis(Y);
Yhar = harmmean(Y);
% % % % % % % % % % % % % 
Cbmean=mean2(Cb);
Cben=entropy(Cb);
Cbs=skewness(Cb);
Cbk=kurtosis(Cb);
Cbhar = harmmean(Cb);

% % % % % % % % % % % 
Crmean=mean2(Cr);
Cren=entropy(Cr);
Crs=skewness(Cr);
Crk=kurtosis(Cr);
Crhar =harmmean(Cr);
%%          NTSC
NTSc=rgb2ntsc(image);
N=NTSc(:,:,1);
T=NTSc(:,:,2);
Sc=NTSc(:,:,3);
% % % % % % % % % SVD
N_svd=svd(N);
T_svd=svd(T);
Sc_svd=svd(Sc);
if(size(N_svd,2)==1)
 N_svd=N_svd';
end
if(size(T_svd,2)==1)
 T_svd=T_svd';
end
if(size(Sc_svd,2)==1)
 Sc_svd=Sc_svd';
end

% % % % % % % % % 
Nmean=mean2(N);
Nen=entropy(N);
Ns=skewness(N);
Nk=kurtosis(N);
Nhar = harmmean(N);
% % % % % % % % % % 
Tmean=mean2(T);
Ten=entropy(T);
Ts=skewness(T);
Tk=kurtosis(T);
Thar = harmmean(T);
% % % % % 
Scmean=mean2(Sc);
Scen=entropy(Sc);
Scs=skewness(Sc);
Sck=kurtosis(Sc);
Schar = harmmean(Sc);
% out=[ Ren Rs Rk Rmean Rvariance Rstd Gen Gs Gk Gmean Gvariance Gstd Ben Bs Bk Bmean Bvariance Gstd kr kg kb sr sg sb rr rg rb mr mg mb rmeanr rmeang rmeanb rvariancer rvarianceg rvarianceb rstdr rstdg rstdb rH sH kH meanH varianceH stdH rS sS kS meanS varianceS stdS r Vs Vk Vmean Vvariance Vstd Lr Ls Lk Lmean Lvariance Lstd aen as ak amean avariance astd ben bs bk bmean bvariance bstd]
% end
zout=[B_svd Ben Bhar Bk Bmean Bs Cb_svd Cben Cbhar Cbk Cbmean Cbs Cr_svd Cren Crhar Crk Crmean Crs G_svd Gen Ghar Gk Gmean Gs N_svd Nen Nhar Nk Nmean Ns R_svd Ren Rhar Rk Rmean Rs Sc_svd Scen Schar Sck Scmean Scs T_svd Ten Thar Tk Tmean Ts Y_svd Yen Yhar Yk Ymean Ys];
zout(isnan(zout))=[];
zout1 = sort(zout,'desc');

for(i=1:size(zout1,2))
if(zout1(1:i)>=1)
zout2(1,i)=zout1(1,i);
else
    zout3(1,i)=zout1(1,i);
end
end
zout2=unique(zout2);
zout3=unique(zout3);


