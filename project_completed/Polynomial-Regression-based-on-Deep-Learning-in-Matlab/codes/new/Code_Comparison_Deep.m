clear all; clc; close all;
warning off;
curr_path=cd;
  
% To create numeric arrays from an Excel spreadsheet:
[X, Xnames] = xlsread('charpyData.xlsx');

before_min_value= min(min(X));
before_max_value= max(max(X));
combination=0;
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
if ~exist('AllResults', 'dir')
       mkdir('AllResults')
end
results_path=[cd,'\AllResults'];

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
hidden_sizes = {64 32 16 8 4 2 [64 32 16 8 4 2], ...
                [32 16 8 4 2] ...
                [16 8 4 2] ...
                [8 4 2] ...
                [4 2]}; % simple neural net

% training algorithms
%% IMPORTANT LINES 
% Run any of these following two lines by commenting one and trying other
% will give differennt results

train_func = {'trainlm','trainscg'};
OuterIterations=size(train_func,2);
InnerIterations=size(hidden_sizes,2);

for i=1:OuterIterations
    for j=1:InnerIterations
        combination=combination+1;
        close all;
        layers_size=cell2mat(hidden_sizes(1,j));
        algo = char(train_func(1,i));
        net = fitnet(layers_size,algo );
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
%%      Uncomment Blow Section to Save the Network Struture also
%         jframe=view(net);
%         hFig = fun_save_net_configuration(jframe);
%         cd(results_path)
%         saveas(hFig, [num2str(combination),'_Network.png'])
%         close(hFig)
%         clear hFig
%%      Training
        [net,tr,output,error]= train(net, x.', y.');
%       Showing Graphs for Training
        figure(1)
        plotperform(tr);
        print('-dpsc', 'perform')
        cd(results_path)
        saveas(gcf,[num2str(combination),'_Performance.png'])
        figure(2)
        plottrainstate(tr);
        print('-dpsc', 'trainstate')
        saveas(gcf,[num2str(combination),'_TrainState.png'])
        
        YPredicted = net(xtest');
        YPredicted=YPredicted';
        errors = gsubtract( ytest,YPredicted);
        perf = perform(net, ytest, YPredicted); % network performance

        mse = mean((YPredicted - ytest).^2);
        rmse = sqrt(mean((YPredicted - ytest).^2));
        cd(curr_path)
        R2 = fun_calculateR2(ytest,YPredicted);
        results{combination,1}=combination;
        results{combination,2}=tr.num_epochs;
        results{combination,3}=tr.best_epoch;
        results{combination,4}=min(tr.best_perf);
        results{combination,5}=min(tr.perf);
        results{combination,6}=min(tr.vperf);
        results{combination,7}=min(tr.tperf);
        results{combination,8}=min(tr.gradient);
        results{combination,9}=mse;
        results{combination,10}=rmse;
        results{combination,11}=R2;
        results{combination,12}=tr.time(:,end);
        
        resultsinfo{combination,1}=combination;
        resultsinfo{combination,2}=layers_size;
        resultsinfo{combination,3}=algo;
        disp([num2str(combination),'/',num2str(OuterIterations*InnerIterations),' Done']);
%% Uncomment Below Whole Section  to see the Results in Command WIndow for all iterations
%         disp(['Total Epochs :',num2str(tr.num_epochs)]);
%         disp(['Best Epoch :',num2str(tr.best_epoch)]);
%         disp(['Training Performance:',num2str(tr.best_perf)]);
%         disp(['Performance (Best) :',num2str(min(tr.perf))]);
%         disp(['Validation Performance at Best Epoch:',num2str(min(tr.vperf))]);
%         disp(['Testing Performance (Best) :',num2str(min(tr.tperf))]);
%         disp(['Gradient (Best):',num2str(min(tr.gradient))]);
%         disp(['MSE :',num2str(mse)]);
%         disp(['RMSE :',num2str(rmse)]);
%         disp(['R2 :',num2str(R2)]);
%%
        % Visualize Predictions
        % Visualize the predictions in a scatter plot. Plot the predicted values against the true values.
        figure(3)
        scatter(YPredicted,ytest,'+');
        xlabel("Predicted Value");
        ylabel("True Value");
        title('Visualize Predictions');
        hold on
        plot([-5 5], [-5 5],'r--')
%%         Uncomment Below both lines to save the Predictions also
%         cd(results_path)
%         saveas(gcf,[num2str(combination), '_Predictions.png'])
    end
end

Results_All=table();
Results_All.Combination_No=results(:,1);
Results_All.TotalEpochs=results(:,2);
Results_All.BestEpochs=results(:,3);
Results_All.Training_Performance=results(:,4);
Results_All.Performance=results(:,5);
Results_All.Validation_Performance=results(:,6);
Results_All.Testing_Performance=results(:,7);
Results_All.Gradient=results(:,8);
Results_All.MSE=results(:,9);
Results_All.RMSE=results(:,10);
Results_All.R2=results(:,11);
Results_All.Training_Time=results(:,12);

Results_Info=table();
Results_Info.Combination_No=resultsinfo(:,1);
Results_Info.LayerSize=resultsinfo(:,2);
Results_Info.Algorithm=resultsinfo(:,3);

filename = 'Results.xlsx';

cd(results_path)
writetable(Results_All,filename,'Sheet','Results','Range','A1')
writetable(Results_Info,filename,'Sheet','Combinations','Range','A1')

close all
