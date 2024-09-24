function thresh=fun_threshold_new(C,S)
sigma = 20;        
is_real = 1;
% Apply thresholding
for s = 2:length(C)
  thresh = 3*sigma + sigma*(s == length(C));
%   for w = 1:length(C{s})
%     Ct{s}{w} = C{s}{w}.* (abs(C{s}{w}) > thresh*E{s}{w});
%   end
end


end

