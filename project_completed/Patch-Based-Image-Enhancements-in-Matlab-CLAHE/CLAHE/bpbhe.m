% The code designed by Pratik Oak. a is input gray image and final is BBHE
% image.

%--------- Brightness preserving Bi-Histogram Equalisation----------------
I=imread('tire.tif');
I = imresize(I,[128 128]);

% function [final]=bpbhe(I)


[ro,co,pl]=size(I);
if pl==3
    I=rgb2gray(I);
end
L=256;
I=I+1;                                      % to access 0 intensity
b=mean(mean(I));
w=0;q=0;
for i=1:ro
    for j=1:co
        if I(i,j)<=b                                %&& a(i,j)>=0
            c(i,j)=I(i,j);                  % image below avg
            w=w+1;                          % count of no. of pixels below avg
%         elseif a(i,j)>b
%             c(i,j)=NaN;
        end
    end
end
for i=1:ro
    for j=1:co
        %if a(i,j)<b                                %&& a(i,j)>=0
       if I(i,j)>b
            d(i,j)=I(i,j);                  % image above avg
            q=q+1;                          % coun of no. of pixels above avg
       else
           d(i,j)=0;
       end
    end
end


j=max(max(c));
[rows,cols]=size(c);
l=zeros(1,j+1);
for x=1:ro,
    for y=1:co,
        l(c(x,y)+1)=l(c(x,y)+1)+1;              % for counting pixels at each rk
    end
end
[g h]=size(l);
for j=2:h
    lf(1,j-1)=l(1,j);               % to get original size i.e. 0 to 7 etc.
end
pl=lf/w;                         % p(rk)

[rows,cols]=size(d);
u=zeros(1,L+1);
for x=1:ro,
    for y=1:co,
        u(d(x,y)+1)=u(d(x,y)+1)+1;              % for counting pixels at each rk
    end
end
[g h]=size(u);
for j=2:h
    uf(1,j-1)=u(1,j);               % to get original size i.e. 0 to 7 etc.
end

pu=uf/q;                         % p(rk)

j=max(max(c));
for x=1:j,
    cl(x)=sum(pl(1:x));             % formula as cdf of lower image
   % cu(x)=sum(pu(1:x));
end
for x=1:L,
   % cl(x)=sum(pl(1:x));             % formula as cdf of lower image
    cu(x)=sum(pu(1:x));
end
I=I-1;
o=min(min(I));
p=max(max(I));
j=max(max(c));
pr=double(j-1-o)*cl;
fl=double(o)+pr;                            % formula for transformation function for low image
po=double(p-j)*cu;
fu=double(j)+po;
c=c-1;
%ne=round(255*sk);       % running sum * (l-1)
for x=1:ro,
    for y=1:co,
%         if c(x,y)<0
%             low(x,y)=0;
%         else
         low(x,y)=fl(c(x,y)+1);             % apply fl on low image for equalisation
        %high(x,y)=fu(a(x,y)+1);
%         end
    end
end
j=max(max(c));
d=d-1;
for x=1:ro,
    for y=1:co,
        if d(x,y)<j
            high(x,y)=0;                    % only for pixels above mean
        else
            high(x,y)=fu(d(x,y)+1);         % apply fu on upper image for equalisation
        %high(x,y)=fu(a(x,y)+1);
        end
    end
end


final=low+high;                 % BBHE image
% end


figure(2);imshow(uint8(low));title('LOW Image');
figure(3);imshow(uint8(high));title('HIGH Image');
figure(5);subplot(1,2,1);imshow(uint8(final));title('BBHE Image');
img=uint8(final);
% [pids]=pixdis(img,L)
% [mic]=michelson(img)
% [sd]=rmsc(img)
% 
% img1=a;
% [ambe]=mb(img,img1)
% [vc]=vcm(final)
%[avq]=qtry(img,img1)


% [pr_cnt,op_img,pr_cnt2]=HE(img,L);
% 
% figure(5);subplot(1,2,2);bar(pr_cnt),title('Histogram Of BBHE Image');
% figure(3);imshow(uint8(op_img));title('HE img');
% figure(4);bar(pr_cnt2),title('Histogram Of HE Image');
% 
% imwrite(final,'tt.gif','gif');
% x=imread('tt.gif');
% figure(6);imshow(x);title('called after imwrite');
%  




