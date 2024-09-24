function [y1, y2]=fun_crossover_single_point(x1,x2)
%% Single Point Crossover
% 
%
%     nVar=numel(x1);
%     
%     c=randi([1 nVar-1]);
%     
%     y1=[x1(1:c) x2(c+1:end)];
%     y2=[x2(1:c) x1(c+1:end)];

temp_i = randi([1,15]);
temp_chr = [x1(1:temp_i) x2(temp_i+1:end)];
y2 = [x2(1:temp_i) x1(temp_i+1:end)];
y1 = temp_chr;         
end