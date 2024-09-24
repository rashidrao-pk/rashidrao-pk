function [fittest,optRoute,minDist,population]=fun_GA(world_grid,string_controller,param)

Ngen=param.Generation;
selected_selection=param.selected_selection;
selected_crossover=param.selected_crossover;
selected_mutation=param.selected_mutation;

if (selected_selection==2)
   Tr_Size=param.choice_Tournament_Parameter; 
end

tic


% iter = 2000;% Number of iterations: repeat "iter" times 
population_size = size(string_controller,2); % Number of chromosomes in population

fittest = zeros(Ngen, 1); %initialize vector to store fitness score of fittest individual each generation for plotting

%% generate random population of "population_size" chromosomes
population = zeros(population_size,population_size);
% for i = 1:population_size
%     population(i,:) = randi([0 9],population_size);
% end
population=randi([0 9],population_size);


%% extra column at end for fitness scores
population = [population zeros(population_size,1)];
hw = waitbar(0,'Running Iterations...');
%% repeat iter times; each time generates a new population
for k = 1:Ngen
    perc=k/Ngen;
    waitbar(perc,hw);
    %% evaluate fitness scores
    for i = 1:population_size
        %fitness function: higher values, the smaller the distance

%         disp([' k-> ',num2str(k), ' i-> ',num2str(i), ' Lowest -> ', num2str(min(population(i,:)))]);
         [fitness, trail] = simulate_ant(world_grid, abs(population(i,:)));
         population(i,population_size+1) =fitness;
% plot(k,fitness);
% xlabel('generation');ylabel('Fitness');
%     drawnow;
%         population(i,101) = (computeRoundTripDistance(population(i, 1:population_size), DistMat));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    %% elite, keep best 30%
    population = sortrows(population,population_size+1);
    
%   figure(1)
%   plot(k, population(population_size,population_size+1));
%   xlabel('generations'), ylabel('fitness score');
%   title ('Fittest individual each generclose allation');
%   drawnow()
    fittest(k, 1) = population(end, population_size+1); %save score of fittest in this generation k for plotting
    
    population_new = zeros(population_size,population_size);
   
    population_new(1:(0.3*population_size),:) = population(population_size-(0.3*population_size-1):population_size,1:population_size);
    population_new_num = (0.3*population_size);
    
    %% repeat until new population is full
    while (population_new_num < population_size)
        %% use a selection method and pick two chromosomes
        weights = population(:,population_size+1)/sum(population(:,population_size+1));
        switch (selected_selection)
        case 1
%                 disp('Selection ->  Roulette Wheel Selection');
        %% RouletteWheel SELECTION 1
        choice1 = fun_SelectionRouletteWheel(weights);
        choice2 = fun_SelectionRouletteWheel(weights);
        x1 = population(choice1, 1:population_size);
        y1 = population(choice2, 1:population_size);
        case 2
%%      SELECTION Tournament
        choice1 = fun_SelectionTournament(weights,Tr_Size,population_size);
        choice2 = fun_SelectionTournament(weights,Tr_Size,population_size);
        x1 = population(choice1, 1:population_size);
        y1 = population(choice2, 1:population_size);
        case 3
%%      SELECTION Rank
        choice1 = fun_SelectionRank(weights,population);
        choice2 = fun_SelectionRank(weights,population);
        x1 = population(choice1, 1:population_size);
        y1 = population(choice2, 1:population_size);
        end
        
%% CROSSOVER OPERATOR
    if (rand < 0.6)       
    switch (selected_crossover)
    case 1
%   Single Point Crossover  1
[x1, y1]=fun_crossover_single_point(x1, y1);
    case 2
%   Uniform Crossover       2
[x1, y1]=fun_crossover_uniform(x1,y1);
    case 3
%   Double Point Cross Over 3            
[x1, y1]=fun_crossover_DoublePoint(x1,y1);

    end
    end
%%       MUTATION
% % % % % % % % % % % % % % % % % % % % % % % % % % % %
%       Mutation 1 operator
if (rand < 0.3)        
    switch (selected_mutation)
        case 1
        %%       Mutation Flip 
        x1 = fun_Mutation_Flip(x1);
        y1 = fun_Mutation_Flip(y1);
        case 2
        %%       Mutation Probability
        mutationProbability=param.mutationProbability;
        x1 = fun_Mutation_Probability(x1, mutationProbability);
        y1 = fun_Mutation_Probability(y1, mutationProbability);
        
        case 3
        %% Mutation Individual
        mutationProbability = param.mutationProbability;    % Probability of Mutation
        x1 = fun_MutationIndividual(x1, mutationProbability);
    end

end
        
%% put in new population, add first new chromosome
        population_new_num = population_new_num + 1;
        population_new(population_new_num,:) = x1;
        % add second chromosome
        if (population_new_num < population_size)
            population_new_num = population_new_num + 1;
            population_new(population_new_num,:) = y1;
        end
    end

    %% replace, last column not updated yet
    population(:,1:population_size) = population_new;
end
 delete(hw);
population=abs(population);

%% at end: evaluate fitness scores and rank them
for i = 1:population_size
%     population(i,population_size+1) = (computeRoundTripDistance(population(i, 1:population_size), DistMat));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   [fitness, trail] = simulate_ant(world_grid, abs(population(i,:)));
   population(i,population_size+1)=fitness;
end
population = sortrows(population,population_size+1);
minDist = 1/(population(end,population_size)); %minimum distance in last generation
optRoute = (population(end, 1:population_size));%route of best candidate in last generation 1 x N matrix
toc;  
end