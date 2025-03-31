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

                % Metoda obsługująca zderzenie z inną cząstką
        function [p1, p2] = collideWith(p1, p2)
            % Wektor łączący środki cząstek
            r = p2.position - p1.position;
            r_norm = norm(r);

            % Unikamy dzielenia przez zero
            if r_norm == 0
                r = [1, 0, 0];
            else
                r = r / r_norm; % Normalizacja
            end

            % Rzutowanie prędkości na kierunek zderzenia
            v1_proj = dot(p1.velocity, r);
            v2_proj = dot(p2.velocity, r);

            % Składowe prędkości wzdłuż kierunku zderzenia
            v1_comp = v1_proj * r;
            v2_comp = v2_proj * r;

            % Składowe prędkości prostopadłe do kierunku zderzenia
            v1_perp = p1.velocity - v1_comp;
            v2_perp = p2.velocity - v2_comp;

            % Obliczenie nowych prędkości wzdłuż kierunku zderzenia (zachowanie pędu)
            m1 = p1.mass;
            m2 = p2.mass;

            % Wzory na zderzenie sprężyste
            v1_new = ((m1 - m2) * v1_proj + 2 * m2 * v2_proj) / (m1 + m2);
            v2_new = ((m2 - m1) * v2_proj + 2 * m1 * v1_proj) / (m1 + m2);

            % Aktualizacja prędkości cząstek
            p1.velocity = v1_perp + v1_new * r;
            p2.velocity = v2_perp + v2_new * r;
        end
    end
end

