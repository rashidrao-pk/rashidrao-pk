function [xtrain,ytrain,xtest,ytest]=fun_split_data(x,y,ratio)
total = length(x);
 
% Determine how many rows ratio% is.
[rows, columns] = size(x);
% Determine the last row number of the top  (upper) 10% of rows.
lastRow = int32(floor((ratio/100) * rows));
% Get first Ratio% into one array M:
xtrain = x(1:lastRow, :);
% Get the rest into one array N:
xtest = x(lastRow+1:end, :);

clear rows columns lastRow
%% for Labels
[rows, columns] = size(y);
% Determine the last row number of the top  (upper) 10% of rows.
lastRow = int32(floor((ratio/100) * rows));
% Get first Ratio% into one array M:
ytrain = y(1:lastRow, :);
% Get the rest into one array N:
ytest = y(lastRow+1:end, :);

end
