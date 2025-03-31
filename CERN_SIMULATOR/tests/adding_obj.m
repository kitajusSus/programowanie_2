clear;
clc;

% Przykład użycia: a = Particle(masa, [x,y,z], [vx,vy,vz], 'nazwa_particle');

m1 = 1; m2 = 2;
vec_r1 = [0,0,0]; vec_r2 = [10,0,0];
vec_v1 = [1.2,0.3,0]; vec_v2 = [0,0,0];

% Tworzenie obiektów Particle
a = Particle(m1, vec_r1, vec_v1, 'czastka_a');
disp(a);  % Wyświetlenie obiektu a

b = Particle(m2, vec_r2, vec_v2, 'cząstka_b');
disp(b);  % Wyświetlenie obiektu b

%% Na potrzeby testów promień cząstki to też jest jej masa (używam tej samej liczby)
% Sprawdzanie czy cząstki się zderzą i po jakim czasie.

% Ustawienia symulacji
dt = 1;        % Krok czasowy symulacji
max_time = 20;   % Maksymalny czas symulacji
time = 0;        % Aktualny czas symulacji
collision = false; % Flaga kolizji

% Ustawienia animacji
figure('Name', 'CERN SIMULATOR - Animacja zderzenia', 'NumberTitle', 'off');
axis_limit = 15; % Limit osi wykresu
history_length = 20; % Długość historii trajektorii (ile poprzednich pozycji pokazać)

% Przechowywanie historii pozycji do rysowania trajektorii
a_history = zeros(history_length, 3);
b_history = zeros(history_length, 3);

% Pętla symulacji
fprintf('\nRozpoczęcie symulacji zderzenia...\n');
while time < max_time && ~collision
    % Obliczanie odległości między cząstkami
    distance = norm(a.position - b.position);

    % Aktualizacja historii pozycji
    a_history = [a.position; a_history(1:end-1,:)];
    b_history = [b.position; b_history(1:end-1,:)];

    % Sprawdzanie kolizji (suma promieni = suma mas na potrzeby tego testu)
    collision_threshold = a.mass + b.mass;

    % Rysowanie animacji
    clf; % Czyszczenie wykresu
    hold on;

    % Rysowanie trajektorii
    plot3(a_history(:,1), a_history(:,2), a_history(:,3), 'r-', 'LineWidth', 1);
    plot3(b_history(:,1), b_history(:,2), b_history(:,3), 'b-', 'LineWidth', 1);

    % Rysowanie cząstek jako sfery
    [xa,ya,za] = sphere(20); % Generowanie współrzędnych sfery
    xa = xa * a.mass; ya = ya * a.mass; za = za * a.mass; % Skalowanie sfery do promienia
    surf(xa + a.position(1), ya + a.position(2), za + a.position(3), ...
         'FaceColor', 'red', 'EdgeColor', 'none', 'FaceAlpha', 0.8);

    [xb,yb,zb] = sphere(20);
    xb = xb * b.mass; yb = yb * b.mass; zb = zb * b.mass;
    surf(xb + b.position(1), yb + b.position(2), zb + b.position(3), ...
         'FaceColor', 'blue', 'EdgeColor', 'none', 'FaceAlpha', 0.8);

    % Dodanie wektorów prędkości
    quiver3(a.position(1), a.position(2), a.position(3), ...
            a.velocity(1), a.velocity(2), a.velocity(3), 'r', 'LineWidth', 2);
    quiver3(b.position(1), b.position(2), b.position(3), ...
            b.velocity(1), b.velocity(2), b.velocity(3), 'b', 'LineWidth', 2);

    % Ustawienia wykresu
    grid on;
    axis equal;
    axis([-1, axis_limit, -axis_limit/2, axis_limit/2, -axis_limit/2, axis_limit/2]);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title(sprintf('CERN SIMULATOR - Czas: %.2f s, Odległość: %.2f', time, distance));
    %legend('Trajektoria A', 'Trajektoria B', 'Cząstka A', 'Cząstka B', 'Location', 'NorthEast');
#{
    % Dodanie informacji o cząstkach
    text(0, -axis_limit/2 + 1, -axis_limit/2 + 1, ...
         sprintf('Cząstka A: m = %.2f, v = [%.2f, %.2f, %.2f]', ...
                 a.mass, a.velocity(1), a.velocity(2), a.velocity(3)), ...
         'Color', 'red');
    text(0, -axis_limit/2 + 2, -axis_limit/2 + 1, ...
         sprintf('Cząstka B: m = %.2f, v = [%.2f, %.2f, %.2f]', ...
                 b.mass, b.velocity(1), b.velocity(2), b.velocity(3)), ...
         'Color', 'blue');
#}
    % Informacja o kolizji
    if distance <= collision_threshold
        collision = true;
        text(axis_limit/2, 0, 0, 'KOLIZJA!', 'FontSize', 20, 'Color', 'red', ...
             'HorizontalAlignment', 'center');
    end

    hold off;

    % Odświeżenie wykresu
    drawnow;

    % Jeśli nastąpiła kolizja, zatrzymaj na chwilę animację
    if collision
        fprintf('Kolizja nastąpiła w czasie t = %.2f!\n', time);
        fprintf('Odległość między cząstkami: %.2f\n', distance);
        fprintf('Próg kolizji (suma mas): %.2f\n', collision_threshold);
        pause(1); % Zatrzymaj animację na 1 sekundę po wykryciu kolizji
        break;
    end

    % Aktualizacja pozycji cząstek
    a = a.update(dt);
    b = b.update(dt);

    % Aktualizacja czasu
    time = time + dt;

    % Co 10 kroków wyświetl aktualny stan w konsoli
    if mod(round(time/dt), 10) == 0
        fprintf('Czas: %.2f, Odległość: %.2f\n', time, distance);
    end

    % Pauza dla lepszej wizualizacji (opcjonalnie)
    pause(0.05);
end

% Wyświetlenie końcowego stanu
if ~collision
    fprintf('Cząstki nie zderzyły się w założonym czasie symulacji (%.2f).\n', max_time);
end

fprintf('\nStan końcowy cząstek:\n');
disp(a);
disp(b);

% Dodanie informacji o autorze i dacie
annotation('textbox', [0, 0, 1, 0.05], 'String', ...
           sprintf('CERN SIMULATOR | Autor: Krzysztof Bezubik | Data: dzisiaj'), ...
           'EdgeColor', 'none', 'HorizontalAlignment', 'center');


