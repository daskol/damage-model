function [model] = damage_model_1d(prob, N)
%   DAMAGE_MODEL_1D
    model = abstract_damage_model(prob);
    model.size = N;
    model.dim = numel(model.size);
    model.lattice = zeros(1, model.size);
    model.is_damaged = @is_damaged;
    model.visualize = @visualize;
    model.characters = @characters;

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
        x1 = find(model.lattice == 0);
        x2 = find(model.lattice == 1);
        scatter(x1, zeros(numel(x1), 1), 100, 'r');
        scatter(x2, zeros(numel(x2), 1), 100, 'b');
    end

    function [data] = characters(model)
        data = numel(find(model.lattice == 1)) / numel(model.lattice);
    end
end
