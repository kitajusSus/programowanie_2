classdef Particle
    properties
        mass      % masa cząstki [jednostka masy]
        position  % pozycja cząstki [x, y, z]
        velocity  % prędkość cząstki [vx, vy, vz]
        type      % typ cząstki (np. 'proton', 'electron', itp.)
        charge    % ładunek elektryczny cząstki [jednostka ładunku]
    end

    methods
        % Konstruktor
        function obj = Particle(mass, position, velocity, type, charge)
            if nargin > 0
                obj.mass = mass;
                obj.position = position;
                obj.velocity = velocity;
                obj.type = type;
                if nargin < 5
                    obj.charge = 0; % domyślnie neutralna
                else
                    obj.charge = charge;
                end
            end
        end

        % Metoda do aktualizacji pozycji i prędkości cząstki w czasie dt
        function obj = update(obj, dt, acceleration)
            if nargin < 3
                acceleration = [0, 0, 0]; % domyślnie brak przyspieszenia
            end
            % Aktualizacja prędkości (v = v0 + a*t)
            obj.velocity = obj.velocity + acceleration * dt;
            % Aktualizacja pozycji (r = r0 + v*t)
            obj.position = obj.position + obj.velocity * dt;
        end

        % Metoda obliczająca siłę elektrostatyczną między dwoma cząstkami
        function [F_vec, F_mag] = electricForce(obj, other_particle)
            % Stała Coulomba
            k = 8.99e9; % N*m^2/C^2

            % Wektor od obj do other_particle
            r_vec = other_particle.position - obj.position;
            r_mag = norm(r_vec);

            % Unikamy dzielenia przez zero
            if r_mag < 1e-10
                F_vec = [0, 0, 0];
                F_mag = 0;
                return;
            end

            % Jednostkowy wektor kierunku
            r_unit = r_vec / r_mag;

            % Siła elektrostatyczna (wartość): F = k * (q1 * q2) / r^2
            F_mag = k * (obj.charge * other_particle.charge) / (r_mag^2);

            % Wektor siły: dodatni - przyciąganie, ujemny - odpychanie
            F_vec = F_mag * r_unit;
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
        function [obj, other] = collideWith(obj, other)
            % Wektor łączący środki cząstek
            r = other.position - obj.position;
            r_norm = norm(r);

            % Unikamy dzielenia przez zero
            if r_norm == 0
                r = [1, 0, 0];
            else
                r = r / r_norm; % Normalizacja
            end

            % Rzutowanie prędkości na kierunek zderzenia
            v1_proj = dot(obj.velocity, r);
            v2_proj = dot(other.velocity, r);

            % Składowe prędkości wzdłuż kierunku zderzenia
            v1_comp = v1_proj * r;
            v2_comp = v2_proj * r;

            % Składowe prędkości prostopadłe do kierunku zderzenia
            v1_perp = obj.velocity - v1_comp;
            v2_perp = other.velocity - v2_comp;

            % Obliczenie nowych prędkości wzdłuż kierunku zderzenia (zachowanie pędu)
            m1 = obj.mass;
            m2 = other.mass;

            % Wzory na zderzenie sprężyste
            v1_new = ((m1 - m2) * v1_proj + 2 * m2 * v2_proj) / (m1 + m2);
            v2_new = ((m2 - m1) * v2_proj + 2 * m1 * v1_proj) / (m1 + m2);

            % Aktualizacja prędkości cząstek
            obj.velocity = v1_perp + v1_new * r;
            other.velocity = v2_perp + v2_new * r;
        end
    end
end
