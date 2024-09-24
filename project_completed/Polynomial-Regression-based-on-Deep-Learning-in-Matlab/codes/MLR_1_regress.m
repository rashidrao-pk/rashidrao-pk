%% REGRESS Multiple linear regression using least squares

clear all; clc; close all;
% tbl = readtable('charpyData.xlsx', ...
%     'ReadRowNames',true);

% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
X = normalize(X);

x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure

%% Splitting Data to Train and Test Portion
[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);


[B,B_INT,RESD,R_INT,STATS] = regress(ytrain,xtrain,0.01);
% Diagnose outliers by finding the residual intervals rint that do not contain 0.
contain0 = (R_INT(:,1)<0 & R_INT(:,2)>0);
idx = find(contain0==false)
% Create a scatter plot of the residuals. Fill in the points corresponding to the outliers.

hold on
scatter(ytrain,RESD)
scatter(ytrain(idx),RESD(idx),'b','filled')
xlabel("Labels")
ylabel("Residuals")
hold off

 if ~exist('Results', 'dir')
       mkdir('Results')
 end
    
saveas(gcf,'Results/MLR1_Rgress.jpg','jpg');

