classdef Particle
    properties
        mass      % masa cząstki [jednostka masy]
        position  % pozycja cząstki [x, y]
        velocity  % prędkość cząstki [vx, vy]
        type      % typ cząstki (np. 'proton', 'electron', itp.)
    end

    methods
        % Konstruktor
        function obj = Particle(mass, position, velocity, type)
            if nargin > 0
                obj.mass = mass;
                obj.position = position;
                obj.velocity = velocity;
                obj.type = type;
            end
        end

        % Metoda do aktualizacji pozycji cząstki w czasie dt
        function obj = update(obj, dt)
            obj.position = obj.position + obj.velocity * dt;
        end

        % Metoda obliczająca energię kinetyczną cząstki
        function E = kineticEnergy(obj)
            v_mag = norm(obj.velocity);
            E = 0.5 * obj.mass * v_mag^2;
        end

        % Metoda obliczająca pęd cząstki
        function p = momentum(obj)
            p = obj.mass * obj.velocity;
        end
    end
end

