% test Function for Best Route Learned
clc
workspace
clear
[fil,path]=uigetfile('*.*');
load([path,fil]);


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