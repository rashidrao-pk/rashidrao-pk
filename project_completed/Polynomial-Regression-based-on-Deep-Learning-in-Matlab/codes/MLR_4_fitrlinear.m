%% Linear regression model to high-dimensional data.
clear all; clc; close all;
% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);

x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure

[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);

% CVMdl = fitrlinear(X,Y,'ObservationsIn','columns','KFold',5,'Lambda',Lambda,...
%     'Learner','leastsquares','Solver','sparsa','Regularization','lasso');

hyperopts = struct('AcquisitionFunctionName','expected-improvement-plus');

[Mdl,FitInfo,HyperparameterOptimizationResults] = fitrlinear(xtrain,ytrain,...
    'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',hyperopts)

% mse = kfoldLoss(Mdl);

numNZCoeff = sum(Mdl.Beta~=0);


% Hypothesis Test on Coefficients
ypred= predict(Mdl,xtest);

[ConfusionMat,order] = confusionmat(ytest,ypred);

testMSE = loss(Mdl,xtest,ytest)

mse = mean((ypred - ytest).^2)
rmse = sqrt(mean((ypred - ytest).^2))

 if ~exist('Results', 'dir')
       mkdir('Results')
 end    
saveas(gcf,'Results/MLR4_FITRLINEAR_OBJECTIVE_FUNCTION_MODEL.jpg','jpg');
