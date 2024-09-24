function T=fun_diffEvolution(h,D,max_runs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS : h is the histogram of the input image
%          D is the number of thresholds
%          max_runs is the maximum number of times DE needs to be executed
% OUTPUT : T is the output threshold vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by : Sujoy Paul, Jadavpur University, Kolkata %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
max_val=255;                         % Upper Limit of the search space for 8-bit images
min_val=0;                           % Lower Limit of the search space
range_min = min_val*ones(1,D);
range_max = max_val*ones(1,D);
%*********************************************************************
% Initialize the Population
%*********************************************************************
NP = 10*D;                           % Population Size of DE
maxgen = 100;                        % No. of generations of DE
F = 0.5;                             % Weighting Factor
CR = 0.9;                            % Crossover probability
statistics_x = zeros(max_runs,D);
fitness_parent = zeros(1,NP);
fitness_child = zeros(1,NP);
x = zeros(NP,D);
w=waitbar(0,'Please Wait');
for runn = 1:max_runs
    
    for i = 1 : NP
        for j = 1:D
            x(i, j) =  round(range_min(j) + ((range_max(j)-range_min(j))*(rand)));
        end
        x(i,:)=sort(x(i,:));
        fitness_parent(i) = shannonEntropy(x(i,:),h');
    end
    
    v = zeros(size(x));
    u = zeros(size(x));
    
    %*********************************************************************
    % Start of Iteration
    %*********************************************************************
    for gen = 2:maxgen
        waitbar(gen/maxgen,w,sprintf('%12.0f%s',gen/maxgen*100,'% DONE'));
        %*********************************************************************
        % Mutation
        %*********************************************************************
        for i = 1:NP
            r = ceil(rand(1,3)*NP);
            while r(1)==r(2) || r(2)== r(3) || min(r)==0 || max(r)>NP
                r = ceil(rand(1,3)*NP);
            end
            v(i,:) = x(r(1),:) + F*(x(r(2),:) - x(r(3),:));
            
            %*********************************************************************
            % Crossover
            %*********************************************************************
            ra=round(rand*D);
            for j = 1:D
                if rand > CR || j==ra
                    u(i,j) = x(i,j);
                else
                    u(i,j) = v(i,j);
                end
            end
            u(i,:) = round(u(i,:));
            u(i,:)=sort(u(i,:));
        end
        
        for i = 1:NP
            for jj = 1:D
                u(i,jj) = max(u(i,jj), range_min(jj));
                u(i,jj) = min(u(i,jj), range_max(jj));
            end
            u(i,:)=sort(u(i,:));
            fitness_child(i,1) = shannonEntropy(u(i,:),h');
        end
        
        for i = 1:NP
            if fitness_parent(i) < fitness_child(i)
                fitness_parent(i) = fitness_child(i);
                x(i,:) = u(i,:);
            end
        end
        
        
        [~,globalbest_index] = max(fitness_parent);
        global_xbest = x(globalbest_index,:);
        
    end
    statistics_x(runn,:) = global_xbest;
end
if max_runs==1
    T =statistics_x;
else
    T = median(statistics_x);
end
close(w);