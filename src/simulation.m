function [sim] = simulation(model)
%   SIMULATION Define an abstract simulation interface.
    sim = struct();
    sim.model = model;
    sim.simulate = simulate;

    function [result] = simulate()
%       CARRY_ON Perform a simulation of a damage model.
        result = model;
    end
end
