function accuracy = fun_evaluate_segmentation(seg,gtruth)
% Inputs : 
%   seg     : Segmented Binary Image & 
%   gtruth  : Binary Mask Provided
% Output : Accuracy 
segVec = seg(:);        % Algorithm segmented image
    gtruthVec = gtruth(:);          % Ground truth
    [rows, cols] = size(gtruthVec);
    count = 0;
    for i= 1:rows
        if (segVec(i) == 1 && gtruthVec(i) == 1)
            count = count +1;
        else
            continue; 
        end
    end
    segCount = sum(sum(seg));
    gtruthCount = sum(sum(gtruth));
    accuracy = count/(segCount + gtruthCount - count);
    accuracy=accuracy*100;
end