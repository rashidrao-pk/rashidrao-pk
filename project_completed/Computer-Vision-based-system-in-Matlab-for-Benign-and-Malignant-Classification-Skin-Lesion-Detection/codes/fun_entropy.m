function Reduced_FeatureVector= fun_entropy(FeatureVector,count)
[r1, c1]=size(FeatureVector);

% % Loop will run upto the features to be reduced
    for i = 1 : c1
    %Entropy is a statistical measure of randomness that can be
    %used to characterize the texture of the input image Entropy is defined 
    %as -sum(p.*log2(p)) where p contains the histogram counts returned from IMHIST.
    %ENTROPY uses 2 bins in IMHIST for logical arrays and 256 bins for
    %uint8, double or uint16 arrays.
        entroVec(i) = entropy(FeatureVector(:,i));
    end
  [entVals, entIndx] = sort(entroVec,'descend');
  new_score1 = FeatureVector(:,entIndx);
   Reduced_FeatureVector = real(new_score1(:,1:count));
end
