% Data Mining 
clc
clear all
close all
load carbig

tbl = table(Acceleration,Cylinders,Displacement,Horsepower,Model_Year,Weight);

blackbox = fitrgp(tbl,MPG,'ResponseName','MPG','CategoricalPredictors',[2 5], ...
    'KernelFunction','ardsquaredexponential');

sigmaL = blackbox.KernelInformation.KernelParameters(1:end-1); % Learned length scales
weights = exp(-sigmaL); % Predictor weights
weights = weights/sum(weights); % Normalized predictor weights


tbl_weight = table(weights,'VariableNames',{'Predictor Weight'}, ...
    'RowNames',blackbox.ExpandedPredictorNames);
tbl_weight = sortrows(tbl_weight,'Predictor Weight');
b = barh(categorical(tbl_weight.Row,tbl_weight.Row),tbl_weight.('Predictor Weight'));
b.Parent.TickLabelInterpreter = 'none'; 
xlabel('Predictor Weight')
ylabel('Predictor')

