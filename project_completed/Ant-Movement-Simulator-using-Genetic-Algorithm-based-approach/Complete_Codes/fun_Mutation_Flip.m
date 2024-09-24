%% applies Random Flip Mutation to chromosome 
% 2 random points are chosen and the values between flipped
function flippedChromosome = fun_Mutation_Flip(chromosome)
    point1 = randi([1, length(chromosome)]);
    point2 = randi([1, length(chromosome)]);
    while(point2 == point1)
        point2 = randi([1, length(chromosome)]); %so that point 1 != point2
    end
    if(point2 < point1) %swap values so that point1 < point2
        [point1, point2] = fun_swap(point1, point2);
    end
    tobeflipped = chromosome(point1:point2);
    chromosome(point1:point2) = fliplr(tobeflipped);
    flippedChromosome = chromosome;
end

