function [y1, y2]=fun_crossover_uniform(x1,x2)
%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML122
% Project Title: Feature Selection using GA (Variable Number of Features)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%
    alpha=randi([0 1],size(x1));
    
    y1=alpha.*x1+(1-alpha).*x2;
    y2=alpha.*x2+(1-alpha).*x1;
    
% temp_i = randi([1,15]);
% temp_chr = [x1(1:temp_i) y1(temp_i+1:end)];
% y1 = [y1(1:temp_i) x1(temp_i+1:end)];
% x1 = temp_chr;
end