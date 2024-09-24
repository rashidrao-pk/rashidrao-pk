clear all; clc; close all;
curr_path=cd;
  
% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');

before_min_value= min(min(X));
before_max_value= max(max(X));


% Data Visualization Before Normalizing
% figure,plot(X,'o'),legend;
% legend(Xnames,'Location','southwest')
% title('Data Before Normalization');

X = normalize(X);
after_min_value= min(min(X));
after_max_value= max(max(X));

% Data Visualization Before Normalizing
% figure,plot(X,'o'),legend;
% legend(Xnames,'Location','southwest')
% title('Data After Normalization');

cd ..
if ~exist('Results', 'dir')
       mkdir('Results')
end
res_path=cd;
cd(curr_path)
x =X(:,1:end-1); % remove last column from the X matrix
y = X(:,end); % response y is systolic pressure

[xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,80);

% figure
% plot(xtrain')
% xlabel("Inputs")
% title("Charpy Energy")
% numFeatures = size(xtrain,1);
% legend("Feature " + string(1:numFeatures),Location="northeastoutside")

%% neural network
% creation and training
% hidden layers
%% Reults are Depedandant to these also
% hidden_sizes = 64; % simple neural net
hidden_sizes = [4 2]; % complex neural net

% training algorithms
%% IMPORTANT LINES 
% Run any of these following two lines by commenting one and trying other
% will give differennt results

train_func = 'trainlm'; % pretty bad (default)
% train_func = 'trainscg'; % 

net = fitnet(hidden_sizes, train_func);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression'};
net.performFcn='mse';

view(net)

[net,tr,output,error]= train(net, x.', y.');

figure
plotperform(tr);
print('-dpsc', 'perform')
figure
plottrainstate(tr);
print('-dpsc', 'trainstate')

YPredicted = net(xtest');
YPredicted=YPredicted';
errors = gsubtract( ytest,YPredicted);
perf = perform(net, ytest, YPredicted); % network performance

mse = mean((YPredicted - ytest).^2);
rmse = sqrt(mean((YPredicted - ytest).^2));
R2 = fun_calculateR2(ytest,YPredicted);


results.TotalEpochs=            tr.num_epochs;
results.BestEpochs=             tr.best_epoch;
results.Training_Performance=   min(tr.best_perf);
results.Performance=            min(tr.perf);
results.Validation_Performance= min(tr.vperf);
results.Testing_Performance=    min(tr.tperf);
results.Gradient=               min(tr.gradient);
results.MSE=mse;
results.RMSE=rmse;
results.R2=R2;

disp(['Total Epochs :',num2str(tr.num_epochs)]);
disp(['Best Epoch :',num2str(tr.best_epoch)]);
disp(['Training Performance:',num2str(tr.best_perf)]);
disp(['Performance (Best) :',num2str(min(tr.perf))]);
disp(['Validation Performance at Best Epoch:',num2str(min(tr.vperf))]);
disp(['Testing Performance (Best) :',num2str(min(tr.tperf))]);
disp(['Gradient (Best):',num2str(min(tr.gradient))]);
disp(['MSE :',num2str(mse)]);
disp(['RMSE :',num2str(rmse)]);
disp(['R2 :',num2str(R2)]);

% Visualize Predictions
% Visualize the predictions in a scatter plot. Plot the predicted values against the true values.
figure
scatter(YPredicted,ytest,'+');
xlabel("Predicted Value");
ylabel("True Value");
title('Visualize Predictions');
hold on
plot([-5 5], [-5 5],'r--')
