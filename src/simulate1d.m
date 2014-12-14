% SIMULATE1D Simulation of 1d damage percolation phenomenda
sizes = [1:10]';
pm = uniform_pm(1, 2);
dm = @damage_model_1d;
sm = simulation(dm, pm);

result = sm.simulate(sm, sizes);

disp(result);

sm.visualize(sm, result);
