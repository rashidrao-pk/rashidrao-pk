clear all; clc; close all;
% tbl = readtable('charpyData.xlsx', ...
%     'ReadRowNames',true);
curr_path=cd;

% addpath(curr_path);  

% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);
cd ..
if ~exist('Results', 'dir')
       mkdir('Results')
end
res_path=cd;
cd(curr_path)
x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure

[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);

%% Plot Data

plot(xtrain, ytrain, 'rx', 'MarkerSize', 10); % Plot the data
ylabel('X Train'); % Set the y??axis label
xlabel('Charpy Energy'); % Set the x??axis label

%% Linear Regression
mdl_fitlm=fitlm(xtrain,ytrain);

[ypred ,ci1]= predict(mdl_fitlm,xtest);
mse1 = mean((ypred - ytest).^2)
rmse1 = sqrt(mean((ypred - ytest).^2))
% Writing Result Image
fun_plot_save(xtrain,ytrain,xtest,ytest,ypred,'1_LinearRegression',res_path)

%% Gaussian Process Regression (GPR)
mdl_fitrgp=fitrgp(xtrain,ytrain,'BasisFunction', 'constant', ...
    'KernelFunction', 'exponential', ... % Highest Results
    'Standardize', true);

% 'KernelFunction', 'rationalquadratic' 2nd highest
% 'KernelFunction', 'matern52' 3rd highest



mse_2 = resubLoss(mdl_fitrgp)

[ypred ,ci1]= predict(mdl_fitrgp,xtest);
mse2 = mean((ypred - ytest).^2)
rmse2 = sqrt(mean((ypred - ytest).^2))
fun_plot_save(xtrain,ytrain,xtest,ytest,ypred,'2_GPR',res_path)

Loss2 = loss(mdl_fitrgp,xtest,ytest)

%% Support Vector Machine (SVM) Regression
mdl_fitrsvm=fitrsvm(xtrain,ytrain);
mse_3 = resubLoss(mdl_fitrsvm)
Loss3 = loss(mdl_fitrsvm,xtest,ytest)


ypred= predict(mdl_fitrsvm,xtest);
mse3 = mean((ypred - ytest).^2)
rmse3 = sqrt(mean((ypred - ytest).^2))
% Writing Result Image
fun_plot_save(xtrain,ytrain,xtest,ytest,ypred,'3_SVM',res_path)

%% Generalized Linear Model
mdl_fitglm=fitglm(xtrain,ytrain);

ypred= predict(mdl_fitglm,xtest);
mse4 = mean((ypred - ytest).^2)
rmse4 = sqrt(mean((ypred - ytest).^2))
fun_plot_save(xtrain,ytrain,xtest,ytest,ypred,'4_GLM',res_path)

%% Regression Tree
mdl_fitrtree=fitrtree(xtrain,ytrain);
Loss4 = loss(mdl_fitrtree,xtest,ytest)

ypred= predict(mdl_fitrtree,xtest);
mse5 = mean((ypred - ytest).^2)
rmse5 = sqrt(mean((ypred - ytest).^2))

mse_5 = resubLoss(mdl_fitrtree)
fun_plot_save(xtrain,ytrain,xtest,ytest,ypred,'5_RegTree',res_path)

%%  FitCEnsemble
mdl_fitcensemble = fitcensemble(xtrain,ytrain);
Imp6 = predictorImportance(mdl_fitcensemble);
[ypred ,ci1]= predict(mdl_fitcensemble,xtest);

mse6 = mean((ypred - ytest).^2)
rmse6 = sqrt(mean((ypred - ytest).^2))
fun_plot_save(xtrain,ytrain,xtest,ytest,ypred,'6_Ensemble',res_path)


%% Regression Tree Ensembles
t = templateTree('MaxNumSplits',1);
mdl_fitrensemble=fitrensemble(xtrain,ytrain,'NumBins',50,'Learners',t,'CrossVal','on');


kflc = kfoldLoss(mdl_fitrensemble,'Mode','cumulative');
estGenError = kflc(end)

figure;
plot(kflc);
ylabel('10-fold cross-validated MSE');
xlabel('Learning cycle');

rmpath(curr_path);
