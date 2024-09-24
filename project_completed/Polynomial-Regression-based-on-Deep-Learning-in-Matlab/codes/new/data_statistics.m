%Create a function in a new m. file named data_statistics or in your current MATLAB script. 
%plot the data variables in stack format and return the data properties.
function [Features, Classes, data_size] = data_statistics(data) 
% P_summary = summary(data); %display summary of the imported dataset and datatypes of each variable

Features = data.Properties.VariableNames; %remove the ; to show you the data types
Classes = unique(Features); %Put unique names of the features into a variable
stackedplot(data) %display plots of the features in the dataset
data_size = size(data)
end
