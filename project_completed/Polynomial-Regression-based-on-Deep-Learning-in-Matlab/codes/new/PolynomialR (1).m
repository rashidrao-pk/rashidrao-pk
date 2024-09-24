clear; clc;
close all
%load a csc file into a table
%Missing data has already been imputed and data has been normalised and
%standardised in Orange
machines = readtable("machine failure_release FINAL STANDARDISED.csv");

%change columns containing text into categorical data type
machines.Machine_Failure = categorical(machines.Machine_Failure);


%get the statistics of the dataset you have as well as use stackedplot to plot your dataset: 
[P_summary, Features, Classes, data_size] = data_statistics(machines); 
%P_summary, gives you the features in the data and their types
%Features gives you the features names 
%Classes also gives you the unique features in the data 
%data_size returns the size of the data

%use to plot a feature individually 
% T = machines.Torque; %choose the feature you want to plot individually
% figure
% histogram(T)
% title('Machine Torque distribution')
% xlabel('Torque') 
% ylabel('Frequency') 

%-replacing categorical values with numbers in matlab----
%To do this, we use the statistics and machine learning toolbox command called grp2idx. Create a new column called Machine_Failure_numeric to hold the values. 
machines.Machine_Failure_numeric = grp2idx(machines.Machine_Failure);

%% Task 3 Polynomial regression to predict torque from rotational speed

X = machines{:,2}; %rotational speed ({} to convert from table to array for plotting)
y = machines{:,3}; %torque

%Plot your dataset
figure
plot(X,y,'.')

xlabel('Rotational Speed [rpm]');
ylabel('Torque [Nm]');

%Create the dataset and set the percentage of data you want to use for
%testing
full_data_set = [X,y];
test_data_percentage = 0.3;


[train_data, test_data] = split_train_test(full_data_set,test_data_percentage); 

%Use this section to set up a k-folds or leave out validation strategy
%Number_of_folds = no_data_points * validation_data_percentage;  
%Use this for k-folds or leave out validation
% no_data_points = length(X);
% Number_of_folds = 1;
% [train_indices,test_indices] = crossvalind('LeaveMOut',no_data_points,Number_of_folds); %Returns only indices which you now have to use
% train_data = full_data_set(train_indices, 1:end);
% test_data = full_data_set(test_indices, 1:end);


for m = 1:length(train_data)
    %Let us train a linear regression model first
    degree_of_polynomial = 3;  %Change this variable to decide what type of model to create. 
    % The value of 1 is a linear regression model and 2 and above polynomial model
    model_coefficients = polyfit(train_data(1:m,1), train_data(1:m,2),degree_of_polynomial);   %Change this line to 
    
    %Let us use the model coefficients to predict new values 
    %using the training dataset
    y_prediction_training = polyval(model_coefficients,train_data(1:m,1));
    
    %Let us use the model coefficients to predict new values 
    %using the test/validation dataset
    y_prediction_test = polyval(model_coefficients,test_data(:,1)); 
    
    training_errors = (y_prediction_training - train_data(1:m,2));
    training_rmse(m) = sqrt(mean((training_errors).^2)); %append results to end of training rmse array
    
    %Let us calculate both the validation and training errors and rmse
    test_errors = (y_prediction_test - test_data(:,2));
    test_rmse(m) = sqrt(mean((test_errors).^2)); %append results to end of validation rmse array
end

hold on
plot(test_data(:,1), y_prediction_test, 'o')
legend('data set','predictions')
title('3rd Degree Polynomial')

figure
plot(1:length(training_rmse), training_rmse, 'r')
hold on
plot(1:length(test_rmse), test_rmse, 'b')
xlabel('Training set size');
ylabel('RMSE');
title('Learning Curve')
legend('training rmse','test rmse')

Average_Training_RMSE = mean(training_rmse)
Average_Testing_RMSE = mean(test_rmse)




