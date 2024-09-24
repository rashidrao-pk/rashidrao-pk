% fun_plot_save
function fun_plot_save(xtrain,ytrain,xtest,ytest,ypred,AlgoName,res_path)
curr_path=cd;
test_errors1 = (ypred - ytest);
cd(res_path)
plot(xtrain,ytrain,'o')
plot(xtest,ypred,'x');
legend('Data','Predictions')
saveas(gcf,['Results/',AlgoName,'_DatavsPred.jpg'],'jpg');

figure
plot(1:length(test_errors1), test_errors1, 'b')
xlabel('Training set size');
ylabel('RMSE');
title('Learning Curve')
legend('training rmse','test rmse')
saveas(gcf,['Results/',AlgoName,'_TrainSet.jpg'],'jpg');
cd(curr_path)
end