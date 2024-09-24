function [yhat,ci] = fun_mypredictQLM(x,varargin) %#codegen
%MYPREDICTQLM Predict response using linear model
%   MYPREDICTQLM predicts responses for the n observations in the n-by-1
%   vector x using the linear model stored in the MAT-file QLMMdl.mat, and
%   then returns the predictions in the n-by-1 vector yhat. MYPREDICTQLM
%   also returns confidence interval bounds for the predictions in the
%   n-by-2 vector ci.
CompactMdl = loadLearnerForCoder('QLMMdl');
[yhat,ci] = predict(CompactMdl,x,varargin{:});
end