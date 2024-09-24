clear all
clc
close all

% read the John Moir Trail (world) 
filename_world = 'muir_world.txt'; 
world_grid = dlmread(filename_world,' ');

string_controller=[1,1,3,2,7,6,3,1,5,1,8,0,1,7,6,3,4,6,1,1,0,1,5,8,4,4,9,2,9,3];

%% Asking for Choice
choice_answer = questdlg('Would you like to run as Default or Custom?', ...
	'Parameter Selection', ...
	'Default','Custom','Default');
% Handle response
switch (choice_answer)
    case 'Default'
        disp('Default Selection');
        Ngen=4000;
        selected_selection=1;
        selected_mutation=1;
        selected_crossover=1;
    case 'Custom'
        choice_selection = questdlg('Select Selection Type', ...
        'SELECTION TYPE','Roulette_Wheel','Tournament','Rank','Tournament');
        switch (choice_selection)
        case 'Roulette_Wheel'
                selected_selection=1;
        case 'Tournament'
        selected_selection=2;
        choice_Tournament_Parameter = questdlg('Select Tournemant Parameter?', ...
        'Tournament Parameter','0.25','0.5','0.75','0.5');
                switch(choice_Tournament_Parameter)
                    case '0.25'
                    param.choice_Tournament_Parameter=0.25;
                    case '0.5'
                    param.choice_Tournament_Parameter=0.5;
                    case '0.75'
                    param.choice_Tournament_Parameter=0.75;
                    case ''
                     disp('No Input');
                     return
                end
                case ''
                 disp('No Input');
                 return
            case 'Rank'
                selected_selection=3;
            case ''
            disp('No Input');
            return
        end
        %% CROSS OVER TYPE
        choice_crossover = questdlg('Select Crossover Type', ...
        'CROSSOVER TYPE', ...
       'Single_Point','Uniform','Double_Point','Single_Point');
        switch (choice_crossover)
            case 'Single_Point'
                selected_crossover=1;
            case 'Uniform'
                selected_crossover=2;
            case 'Double_Point'
                selected_crossover=3;
            case ''
                 disp('No Input');
                 return
        end
        %% MUTATION TYPE
        choice_mutation = questdlg('Select Mutation Type?', ...
        'MUTATTION TYPE', ...
        'Flip','Probability','Individual','Probability');
            switch (choice_mutation)
                case 'Flip'
                    selected_mutation=1;
                case 'Probability'
                    selected_mutation=2;
                    param.mutationProbability = 0.0625;
                case 'Individual'
                    selected_mutation=3;
                    param.mutationProbability = 0.05;
                case ''
                     disp('No Input');
                     return
            end
%             Ngen=input("Enter no of Generation : ");
Ngen = str2num(cell2mat(inputdlg( "Enter no of Generation : " )));
            
    case ''
        disp('No Input');
        return
end

% APPLY GA on Input which is String 1x32 Values 
% Fiteness Criteria is Max Food Cell Count which is 89
param.Generation=Ngen;
param.selected_selection=selected_selection;
param.selected_crossover=selected_crossover;
param.selected_mutation=selected_mutation;


[fitness_data,string_ours,minDist,population]=fun_GA(world_grid,string_controller,param);

%% Get Fitness Results
[fitness_ours, trail_ours] = simulate_ant(world_grid, string_ours);
[fitness, trail] = simulate_ant(world_grid, string_controller);

Fitness_Best_Ours=uint8(100*fitness_ours/89);
Fitness_Best_Mori=uint8(100*fitness/89);

%% PLOT 1 to show fitness score of the most-fit ant 
% Ngen is the number of generations and 
% fitness_data is a 1×Ngen vector of fitness values of the most-fit ant in Ngen generation

fun_showing_fitness_function(fitness_data,Ngen);

%% PLOT 2 
% trail of the most-fit ant in the final generation 
% Ngen is the number of generations and best_fitness is the fitness value 
% of the most-fit ant in in the final generation. 
% trail is a 200×2 matrix, which is the second output of the 
% simulate_ant.m function for the most-fit ant in in the final generation. 

fun_showing_trail(world_grid,trail,fitness_data,fitness,100,1);
fun_showing_trail(world_grid,trail_ours,fitness_data,fitness_ours,Ngen,2);
