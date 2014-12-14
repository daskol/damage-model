function [model] = abstract_damage_model(prob)
%   ABSTRACT_DAMAGE_MODEL Construct abstract damage model to customize
%   it later and to make a simulation.
    model = struct();

    model.size = [];                % size of lattice along each dimension
    model.dim = 0;                  % lattice dimension
    model.lattice = [];             % lattice
    model.prob = prob;              % probability model

    model.is_damaged = @is_damaged;
    model.damage = @damage;
    model.visualize = @visualize;
    model.simulate = @simulate;
    model.renorm = @renorm;
    model.characters = @characters;
    
    model.set_lattice = @set_lattice;
    model.set_size = @set_size;
    model.set_dim = @set_dim;
    model.set_is_damaged = @set_is_damaged_proc;
    model.set_damage = @set_damage_proc;
    model.set_visualize = @set_visualize_proc;
    model.set_simulate = @set_simulate_proc;
    
    function [damaged] = is_damaged(model)
%       IS_DAMAGE Check wether model was percolated.
        damaged = 1;
    end

    function [model] = damage(model)
%       DAMAGE Make one step of percolation.
        I = find(model.lattice == 0);
        maxi = numel(I);
        index = randi(maxi);
        model.lattice(I(index)) = model.prob.take(2);
    end

    function [] = visualize(model)
%       VISUALIZE Visualize model's data.
    end

    function [model] = simulate(model)
%       SIMULATE Simulate a phase transition(percolation).
        while ~model.is_damaged(model)
            model = model.damage(model);
        end
    end

    function [model] = renorm(model)
%       RENORM Implementation of renorm transformation step.
    end

    function [data] = characters(model)
%       CHARACTERS Calculate damage model's characteristics.
    end


%   Accessor section.

    function [] = set_lattice(lattice)
        model.lattice = lattice;
    end

    function [] = set_size(size)
        model.size = size;
    end

    function [] = set_dim(dim)
        model.dim = dim;
    end

    function [] = set_is_damaged_proc(proc)
        model.damage = proc;
    end

    function [] = set_damage_proc(proc)
        model.damage = proc;
    end

    function [] = set_visualize_proc(proc)
        model.visualize = proc;
    end

    function [] = set_simulate_proc(proc)
        model.simulate = proc;
    end
end
