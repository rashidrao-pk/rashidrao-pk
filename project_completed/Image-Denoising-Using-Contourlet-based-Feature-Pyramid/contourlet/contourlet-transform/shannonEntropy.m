function entropy=shannonEntropy(x,h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS : x is the threshold vector
%          h is the histrogram of the image
% OUTPUT:  entropy is the Entropy of the image after probabilistic 
%          partition by the threshold vector 'h'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by : Sujoy Paul, Jadavpur University, Kolkata %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
entropy=0;
x=[1 (x+1) 256];
s=size(x);
for i=1:s(2)-1
    temp = h(x(i):x(i+1));
    tsum= sum(temp);
    ent=0;
    if tsum~=0
    for j=x(i):x(i+1)
        if h(j)~=0
            a=h(j)/tsum;
            ent = ent + a*log(a);
        end
    end
    end
    entropy = entropy + ent;    
end
entropy=-entropy;