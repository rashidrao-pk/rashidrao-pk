%% FITLM Create linear regression model by fitting to data.
clear all; clc; close all;
format long g

% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);

x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is Charpy Energy
%% Splitting Data to Train and Test Portion

[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);


mdl = fitlm(xtrain,ytrain);
% mdl = fitlm(trainData,"PredictorVars",["borough","grosssquarefeet", ...
%     "landsquarefeet","buildingclasscategory","yearbuilt","MM","DD"], ...
%     "ResponseVar","saleprice")


compactMdl = compact(mdl);
vars = whos('compactMdl','mdl');
[vars(1).bytes,vars(2).bytes]

% err = loss(mdl,x,y)
%  y ~ 1 + x1 + x2 + x3

% Coefficient Confidence Intervals
% coefCI(mdl)

% Hypothesis Test on Coefficients
[p,F,d] = coefTest(mdl);

% figure(2),plot(mdl)

[ypred ,ci1]= predict(mdl,xtest);

[ConfusionMat,order] = confusionmat(ytest,ypred);

figure,
plot(xtrain,ytrain,'-o')
plot(xtest,ypred,'x');
legend('Data','Predictions')

mse = mean((ypred - ytest).^2)
rmse = sqrt(mean((ypred - ytest).^2))

%% Save Model
% saveLearnerForCoder(mdl,'QLMMdl');
