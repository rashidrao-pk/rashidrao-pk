% Rank Selection. 
% A set of weights represents the probability of selection of each
% chromosome in a group of choices. It returns the index of the chosen chromosome.
% ---------------------------------------------------------
function index = fun_SelectionRank(weights,population)
% If the population has N individuals, the best individual gets rank N and the worst 1 then
TotalFitness = sum(weights);
%% getting Portions Occupied by each Bit
occupancy(:,:)=weights(:,1)/TotalFitness*100;
[value,index]=max(occupancy);

% probably TotalFitness isn't anymore the right name for the variable, but let it go)
% (N + 1) * N / 2 is just the sum of the ranks:
% [value,index]=max(weights);
% choice = index;
end