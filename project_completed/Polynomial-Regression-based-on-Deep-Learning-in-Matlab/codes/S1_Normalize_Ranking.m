clear all; clc; close all;
% tbl = readtable('charpyData.xlsx', ...
%     'ReadRowNames',true);

% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');
%% Data Normalization
X = normalize(X);

%% Splitting Data to Train and Test Portion
%  Selecting all the columns as predictors
% x=X(:,1:end-1); % remove last column from the X matrix
x=X(:,1:end-1); % remove last column from the X matrix

t=X(:,end); % response y is Charpy Energy

% [x,t] = cancer_dataset;
% xx = ceil(rand(50,699)*10)./10;
% xx([12 16 20 23 26 40 41 44 50],:) = x;
% x = xx;
trainFcn = 'trainscg'; % Scaled conjugate gradient backpropagation.
hiddenLayerSize = 50;
net = patternnet(hiddenLayerSize, trainFcn);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net.trainParam.epochs = 100
[net,tr] = train(net,x',t');

% ranking
[sorted_values,h]=sort(sum(abs(net.IW{1}))','descend');

most_significant_input=h';

fprintf('Most Significant Input using %d iterations &  %d hidden layers \n',net.trainParam.epochs,hiddenLayerSize)
disp(num2str(most_significant_input))

for i=1:size(most_significant_input,2)
Significance_Table {1,i}= Xnames{1,i};
Significance_Table {2,i}= most_significant_input(1,i);
end