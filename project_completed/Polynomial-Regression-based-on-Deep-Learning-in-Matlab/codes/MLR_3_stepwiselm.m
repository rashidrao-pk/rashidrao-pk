% stepwiselm
% Perform stepwise regression

clear all; clc; close all;


% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);
x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure
%% Split Data for test and train
[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);

mdl = stepwiselm(xtrain,ytrain,'PEnter',0.06)

% Hypothesis Test on Coefficients
[p,F,d] = coefTest(mdl);

% Predict responses to test data.
[ypred ,ci1]= predict(mdl,xtest);

[ConfusionMat,order] = confusionmat(ytest,ypred);

mse = mean((ypred - ytest).^2)
rmse = sqrt(mean((ypred - ytest).^2))


figure,
plot(xtrain,ytrain,'-o')
plot(xtest,ypred,'x');
legend('Data','Predictions')

