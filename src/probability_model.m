function [prob] = probability_model()
%   PROBABILITY_MODEL Define an absract probability model.
    prob = struct();
    prob.probability = @probability;
    prob.take = @take;

    function [p] = probability(stress)
%       RANDOM Calculate probility by stress.
        p = 0;
    end

    function [value] = take(stress)
%       TAKE Check if a node is percolated or not by stress.
        if prob.probability(stress) < random('uniform', 0, 1)
            value = 1;
        else
            value = 0;
        end
    end
end
