%%  fitrgp

clear all; clc; close all;

% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);
%% Split Predictors and Response

x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure

tbl=table();
tbl.Test_Depth=X(:,1);
tbl.Size=X(:,2);
tbl.Coded_Site=X(:,3);
tbl.C=X(:,4);
tbl.Si=X(:,5);
tbl.Mn=X(:,6);
tbl.S=X(:,7);
tbl.Cr=X(:,8);
tbl.Mo=X(:,9);
tbl.Ni=X(:,10);
tbl.Al=X(:,11);
tbl.V=X(:,12);
tbl.H_Temp=X(:,13);
tbl.Coded_Cool=X(:,14);
tbl.T_Temp=X(:,15);
tbl.Imp_Temp=X(:,16);

%% Split Data for test and train
[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);

%% 
% [h,atab,ctab,stats] = aoctool(X(:,1:end-1),X(:,end),X(:,2));

blackbox = fitrgp(tbl,y);

% blackbox = fitrgp(tbl,y,'ResponseName','y','CategoricalPredictors',[2 5], ...
%     'KernelFunction','ardsquaredexponential');

[ypred,~,yci]= predict(blackbox,xtest);

figure(2)
plot(xtrain,ytrain,'o')
plot(xtest,ypred,'x');
legend('Data','Predictions')

saveas(gcf,'Results/MLR7_FITRGB_Data_vs_Prediction.jpg','jpg');

testMSE = loss(blackbox,xtest,ytest)

mse = mean((ypred - ytest).^2)
rmse = sqrt(mean((ypred - ytest).^2))
