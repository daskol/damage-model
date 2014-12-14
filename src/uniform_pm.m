function [prob] = uniform_pm(s1, s2)
%   PROBABILITY_MODEL Define an uniform probability model.
    prob = probability_model();
    prob.probability = @probability;
    prob.s1 = s1;
    prob.s2 = s2;

    function [p] = probability(stress)
%       RANDOM Calculate probility by stress.
        if stress < prob.s1
            p = 0;
        elseif stress >= prob.s2
            p = 1;
        else
            p = (stress - prob.s1) / (prob.s2 - prob.s1);
        end
    end
end
