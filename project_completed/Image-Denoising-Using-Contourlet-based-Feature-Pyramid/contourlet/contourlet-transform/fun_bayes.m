function bayesC=fun_bayes(C,S)
%Calculating sigmahat
var=length(C)-S(size(S,1)-1,1)^2+1;
sigmahat=median(abs(C(var:length(C))))/0.6745;
st=(S(1,1)^2)+1;


for jj=2:size(S,1)-1
    %for the H detail coefficients
    coefh=C(st:st+S(jj,1)^2-1);
    thr=bayes(coefh,sigmahat);
    bayesC(st:st+S(jj,1)^2-1)=sthresh(coefh,thr);
    st=st+S(jj,1)^2;
    % for the V detail coefficients
    coefv=C(st:st+S(jj,1)^2-1);
    thr=bayes(coefv,sigmahat);
    bayesC(st:st+S(jj,1)^2-1)=sthresh(coefv,thr);
    st=st+S(jj,1)^2;
    %for Diag detail coefficients 
    coefd=C(st:st+S(jj,1)^2-1);
    thr=bayes(coefd,sigmahat);
    bayesC(st:st+S(jj,1)^2-1)=sthresh(coefd,thr);
    st=st+S(jj,1)^2;
end


end