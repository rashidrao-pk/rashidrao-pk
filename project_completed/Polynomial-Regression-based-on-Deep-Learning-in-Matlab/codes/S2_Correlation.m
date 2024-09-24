%% Step 2 Find Correlation

clear all
clc
close all
% Load data
% Unlike corrplot, plotmatrix cannot receive a table. 
% Form a matrix of variables in each column.
% data = [Horsepower, Weight, Acceleration, MPG]; 

[X, Xnames] = xlsread('charpyData.xlsx');
data = X;

nVars = size(data,2); 
% Remove any rows that contain NaN values. Otherwise corr() will 
% return NaN. 
data(any(isnan(data),2), :) = []; 

N = normalize(data);

R = corrcoef(N(:,1:end-1))

% Create plotmatrix
figure('Name', 'Charpy Data')
% pcolor(R)
imagesc(R)
xticks(1:16)
xticklabels(Xnames(1,1:end-1));
yticks(1:16)
yticklabels(Xnames(1,1:end-1));
set(gca,'xaxisLocation','top')

% xticklabels({'Test_Depth','Size','Coded_Site','C','Si','Mn','S','Cr','Mo','Ni','Al','V','H_Temp','Coded_Cool','T_Temp','Imp_Temp'})
saveas(gcf,'../Results/Results_Correlation.jpg','jpg')