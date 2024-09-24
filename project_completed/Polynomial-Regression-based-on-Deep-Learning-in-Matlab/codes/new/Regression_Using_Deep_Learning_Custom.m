clear all; clc; close all;
curr_path=cd;
  
% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');

before_min_value= min(min(X))
before_max_value= max(max(X))

% Data Visualization Before Normalizing
figure,plot(X,'o'),legend;
legend(Xnames,'Location','southwest')
title('Data Before Normalization');

X = normalize(X);
after_min_value= min(min(X))
after_max_value= max(max(X))

% Removing Nans if Any
X = rmmissing(X);

% Data Visualization After Normalizing
figure,plot(X,'o'),legend;
legend(Xnames,'Location','southwest')
title('Data After Normalization');

x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure

cd(curr_path)
[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);

%%
% figure
% plot(xtrain')
% xlabel("Inputs")
% title("Charpy Energy")
% numFeatures = size(xtrain,1);
% legend("Feature " + string(1:numFeatures),Location="northeastoutside")
%%
%% neural network
input_count = size( xtrain , 2 );
output_count = size( ytrain , 2 );

%% creation and training
% layers = [ ...
%     sequenceInputLayer(input_count)
%     fullyConnectedLayer(64)
%     reluLayer
%     fullyConnectedLayer(32)
%     reluLayer
%     fullyConnectedLayer(16)
%     reluLayer
%     fullyConnectedLayer(8)
%     reluLayer
%     fullyConnectedLayer(4)
%     reluLayer
%     fullyConnectedLayer(2)
%     reluLayer
%     fullyConnectedLayer(output_count)
%     regressionLayer
%     ]
numHiddenUnit = 50;
layers = [ ...
    sequenceInputLayer(input_count)
    lstmLayer(numHiddenUnit)
    fullyConnectedLayer(output_count)
    regressionLayer
    ]

%% Training Options
options = trainingOptions('sgdm', ...
    'ValidationData',{xtest',ytest'},...
    'InitialLearnRate',0.001,...
    'ValidationFrequency',50,...
    'MaxEpochs',2000, ...
    'MiniBatchSize', 1000 , ...
    'Verbose',true, ...
    'ExecutionEnvironment','auto',...
    'Plots','training-progress');
% Start Training
[net,info] = trainNetwork(xtrain',ytrain',layers,options);

YPredicted = predict(net,xtest');
YPredicted=YPredicted';

mse2 = mean((YPredicted - ytest).^2)
rmse2 = sqrt(mean((YPredicted - ytest).^2))

% 
% plot(xtest, YPredicted, 'g', 'linewidth', 2);
% legend('training data', 'underlying function', 'network output');

% perf = perform(net, ytest, YPredicted) % network performance
