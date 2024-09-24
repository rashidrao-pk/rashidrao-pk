function [train_data, test_data] = split_train_test(data, test_ratio)
rng(1); %Assign a seed to the random number generator in order to ensure 
%that it produces the same random sequence all the time
shuffled_indices = ceil(rand(length(data),1) * (length(data)));
size(shuffled_indices);
test_set_size = int16(length(data) * test_ratio);
test_indices = shuffled_indices(1:test_set_size);
train_indices = shuffled_indices(test_set_size:end);
train_data = data(train_indices, 1:end);
test_data = data(test_indices, 1:end);
end