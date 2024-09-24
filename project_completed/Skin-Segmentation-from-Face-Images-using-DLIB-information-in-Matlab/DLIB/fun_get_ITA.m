function ITA=fun_get_ITA(rgb,para,type)
warning off;
if type=='f'
else
disp('');
end
if para==1
    lab=rgb;
    elseif para==0
    lab=rgb2lab(rgb);
else
end
lab=double(lab);
Lab_L = lab(:,:,1);
Lab_a = lab(:,:,2);
Lab_b = lab(:,:,3);

% [ITA1,ITA2]=fun_get_ITA(Lab_L,Lab_b);


for ilop=1:size(Lab_L,1)
    for jlop=1:size(Lab_L,2)
        if Lab_a(ilop,jlop)~=0
            q22(ilop,jlop) = (Lab_L(ilop,jlop)-50);
            t22(ilop,jlop)=(atan(q22(ilop,jlop)/Lab_b(ilop,jlop)));
            value=t22(ilop,jlop)* (180/3.14159);
%                 if value>=55
%                      ITA(ilop,jlop)=0;
%                 elseif value<=-55
%                      ITA(ilop,jlop)=0;
%                 else
%                      ITA(ilop,jlop)=value;
%                 end
            ITA(ilop,jlop)=value;
        elseif Lab_a(ilop,jlop)==0
            ITA(ilop,jlop)=0;
            else
        end
    end
clc
% disp(ilop);
end
% yy = atan((Lab_L-50)./Lab_b);
% ITA2 = yy * (180/3.14159);

% figure(121),
% subplot(221),imshow(uint8(rgb)),title('Input RGB');
% subplot(222),imshow(uint8(lab)),title('LAB');
% subplot(223),imshow(ITA),title('ITA Using Loop');
% subplot(224),imshow(ITA2),title('ITA Without Loop');
% close(figure(121))
end
% disp(ITA);