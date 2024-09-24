%%  fitcensemble
clear all; clc; close all;

% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);

x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure


%% Splitting Data to Train and Test Portion
[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);

blackbox = fitcensemble(xtrain,ytrain)

Imp2 = predictorImportance(blackbox);

[ypred ,ci1]= predict(blackbox,xtest);

mse = mean((ypred - ytest).^2)
rmse = sqrt(mean((ypred - ytest).^2))

plot(xtrain,ytrain,'o')
plot(xtest,ypred,'x');

legend('Data','Predictions')
cd ..
if ~exist('Results', 'dir')
       mkdir('Results')
 end    
saveas(gcf,'Results/MLR5_FitceEnsemble_DatavsPred.jpg','jpg');


