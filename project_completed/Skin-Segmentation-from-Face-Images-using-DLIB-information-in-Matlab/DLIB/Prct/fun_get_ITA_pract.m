function [ITA1,ITA2]=fun_get_ITA(A,B)
ITA2 = (atan((A-50)./B)) * (180/3.14159);
for ilop=1:size(A,1)
    for jlop=1:size(A,2)    
        q22(ilop,jlop) = (A(ilop,jlop)-50);
        t22(ilop,jlop)=(atan(q22(ilop,jlop)/B(ilop,jlop)));
        ITA1(ilop,jlop)= t22(ilop,jlop)* (180/3.14159);
    end
end
end