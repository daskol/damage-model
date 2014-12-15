function [model] = damage_model_2d(prob, N)
%   DAMAGE_MODEL_2D
    model = abstract_damage_model(prob);
    model.size = N;
    model.dim = numel(model.size);
    model.lattice = zeros(N(1), N(2));
    model.is_damaged = @is_damaged;
    model.visualize = @visualize;
    model.characters = @characters;

    function [damaged] = is_damaged(model)
%        IS_DAMAGE Check wether model was percolated.
%         fprintf('damage_model_2d\\is_damaged()\n');
% Brute force search
        height  = size(model.lattice,1);
        width = size(model.lattice,2);
        
        Cluster = zeros(height,width);
        Cluster(:,1) = model.lattice(:,1); %filling first layer
        
        for jj = 2:width
            Cluster(:,jj) = (Cluster(:,jj-1)==1)&(model.lattice(:,jj)==1); %connections with previous layer
            for ii = 1:(height-1)   %
                Cluster(ii+1,jj) = ((model.lattice(ii+1,jj)==1)&&(Cluster(ii,jj)==1))||(Cluster(ii+1,jj)==1);
                Cluster(height-ii,jj) = (model.lattice(height - ii,jj)==1)&&(Cluster(height-ii+1,jj)==1)||(Cluster(height-ii,jj)==1);
            end
        end
        damaged = sum(Cluster(:,width)) >= 1;
    end

    function [] = visualize(model)
%       VISUALIZE Visualize model's data.
        figure;
        hold on;
        grid on;
        [x1(1),x1(2)] = find(model.lattice == 0);
        disp(model.lattice)
        [x2(1),x2(2)] = find(model.lattice == 1);
        scatter(x1(2), x1(1), 100, 'r');
        scatter(x2(2), x2(1), 100, 'b');
    end

    function [data] = characters(model)
        data = numel(find(model.lattice == 1)) / numel(model.lattice);
    end
end