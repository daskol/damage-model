% SIMULATE1D Simulation of 2d damage percolation phenomenda
% sizes = [1:10]';
tic;
sizes = [50;50]';
pm = uniform_pm(1, 2);
dm = @damage_model_2d;
sm = simulation(dm, pm);

result = sm.simulate(sm, sizes);

disp(result);
sm.visualize(sm, result);
toc;