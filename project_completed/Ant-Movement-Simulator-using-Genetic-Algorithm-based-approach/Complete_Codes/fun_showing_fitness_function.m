% Solution to the Question  ----->
% Q1: Your code should output a plot showing the fitness score of the most-fit 
% ant in each generation using the following code

function fun_showing_fitness_function(fitness_data,Ngen)
hf = figure;
set(hf,'Color',[1 1 1]); 
hp = plot(1:Ngen,100*fitness_data/89,'r');
set(hp,'LineWidth',1);
axis([0 Ngen 0 100]); 
grid on; 
xlabel('Generation number'); 
ylabel('Ant fitness [%]');
title('Ant fitness as a function of generation');

end