%% Answer of the Question ->
% Your code should also output a plot showing the trail of the most-fit ant in the 
% final generation using the following codes
function fun_showing_trail(world_grid,trail,best_fitness,fitness,Ngen,run_as) 
world_grid = rot90(rot90(rot90(world_grid)));

xmax = size(world_grid,2);
ymax = size(world_grid,1);

hf = figure; 
set(hf,'Color',[1 1 1]); 
for y=1:ymax
    for x=1:xmax
        if(world_grid(x,y) == 1) 
            h1 = plot(x,y,'sk'); 
            hold on
        end
    end
end 
grid on

% display the fittest Individual trail 
for k=1:size(trail,1)
h2 = plot(trail(k,2),33-trail(k,1),'*m'); hold on
end
axis([1 size(world_grid,1) 1 size(world_grid,2)])
% Ngen is the number of generations and best_fitness is the fitness value 
% of the most-fit ant in in the final generation. 
% trail is a 200×2 matrix, which is the second output of the 
% simulate_ant.m function for the most-fit ant in in the final generation. 

if run_as==1
title_str = sprintf('John Muri Trail - Hero Ant fitness %d%% ',uint8(100*fitness/89));
elseif run_as==2
title_str = sprintf('Our Trail - Hero Ant fitness %d%% in %d generation ',uint8(100*fitness/89), Ngen);
end
title(title_str)
lh = legend([h1 h2],'Food cell','Ant movement'); set(lh,'Location','SouthEast');