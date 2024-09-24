% x feature vector
x=ent_FV1;
% y is label
y=idx; 

% svmmodel=fitcsvm(x,y);
svmmodel=fitcecoc(x,y);
save svmmodel;

