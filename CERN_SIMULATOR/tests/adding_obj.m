clear;
clc;

% Przykład użycia: a = Particle(masa, [x,y,z], [vx,vy,vz], 'nazwa_particle');

m1 = 1.5; m2 = 5;
vec_r1 = [0,0,0]; vec_r2 = [10,0,0];
vec_v1 = [5,0,0]; vec_v2 = [0.6,0,0];


a = Particle(m1, vec_r1, vec_v1, 'czastka_a');
disp(a);  % Wyświetlenie obiektu a

b = Particle(m2, vec_r2, vec_v2, 'cząstka_b');
disp(b);  % Wyświetlenie obiektu b

%% Na potrzeby testów promień cząstki to też jest jej masa (używam tej samej liczby)
% Sprawdzanie czy cząstki się zderzą i po jakim czasie.

% Ustawienia symulacji
dt = 0.1;        % Krok czasowy symulacji
max_time = 20;   % Maksymalny czas symulacji
time = 0;        % Aktualny czas symulacji
collision = false; % Flaga kolizji

% Pętla symulacji
fprintf('\nRozpoczęcie symulacji zderzenia...\n');
while time < max_time && ~collision
    % Obliczanie odległości między cząstkami
    distance = norm(a.position - b.position);

    % Sprawdzanie kolizji (suma promieni = suma mas na potrzeby tego testu)
    collision_threshold = a.mass + b.mass;

    if distance <= collision_threshold
        collision = true;
        fprintf('Kolizja nastąpiła w czasie t = %.2f!\n', time);
        fprintf('Odległość między cząstkami: %.2f\n', distance);
        fprintf('Próg kolizji (suma mas): %.2f\n', collision_threshold);
        break;
    end

    % Aktualizacja pozycji cząstek
    a = a.update(dt);
    b = b.update(dt);

    % Aktualizacja czasu
    time = time + dt;

    % Co 10 kroków wyświetl aktualny stan
    if mod(round(time/dt), 10) == 0
        fprintf('Czas: %.2f, Odległość: %.2f\n', time, distance);
    end
end

% Wyświetlenie końcowego stanu
if ~collision
    fprintf('Cząstki nie zderzyły się w założonym czasie symulacji (%.2f).\n', max_time);
end

fprintf('\nStan końcowy cząstek:\n');
disp(a);
disp(b);



