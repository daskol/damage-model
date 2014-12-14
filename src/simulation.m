function [sim] = simulation(model, prob)
%   SIMULATION Define an abstract simulation interface.
    sim = struct();
    sim.model = model;
    sim.prob = prob;
    sim.simulate = @simulate;
    sim.visualize = @visualize;
    sim.results = [];

    function [result] = simulate(sim, sizes)
%       CARRY_ON Perform a simulation of a damage model.
        num_sims = size(sizes);     % number of series
        num_reps = 5;               % number of repeats(length of seris)

        result = struct();
        result.raw = cell(num_sims, num_reps);  % threshold
        result.moments = zeros(num_sims, 2);    % mean and variance
        result.size = sizes;

        series = zeros(num_reps, 1);

        for i = 1:num_sims
            for j = 1:num_reps
                mdl = sim.model(sim.prob, sizes(i, :));
                mdl = mdl.simulate(mdl);
                dat = mdl.characters(mdl);
                result.raw{i, j} = dat;
                series(j) = dat;
            end

            result.moments(i, :) = [mean(series) std(series)];
        end
    end

    function [] = visualize(sim, result)
%       VISUALIZE Visualize data.
        figure;
        hold on;
        grid on;
        I = 1:size(result.size);
        stat = result.moments;
        plot(I, stat(:, 1) + stat(:, 2), 'b-');
        plot(I, stat(:, 1) - stat(:, 2), 'b-');
        plot(I, stat(:, 1), 'rx');
    end
end
