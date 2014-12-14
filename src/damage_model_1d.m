function [model] = damage_model_1d(prob, N)
%   DAMAGE_MODEL_1D
    model = abstract_damage_model(prob);
    model.size = N;
    model.dim = numel(model.size);
    model.lattice = zeros(1, model.size);
    model.is_damaged = @is_damaged;
    model.visualize = @visualize;

    function [damaged] = is_damaged(model)
%       IS_DAMAGE Check wether model was percolated.
        fprintf('damage_model_1d\\is_damaged()\n');
        damaged = sum(model.lattice) == model.size(1);
    end

    function [] = visualize(model)
%       VISUALIZE Visualize model's data.
        figure;
        hold on;
        grid on;
        x1 = model.lattice == 0;
        x2 = model.lattice == 1;
        plot(x1, zeros(numel(x1)), 'rx', x2, ones(numel(x2)), 'b+');
    end
end
