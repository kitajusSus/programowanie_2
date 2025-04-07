clear;
clc;

% Przykład użycia: a = Particle(masa, [x,y,z], [vx,vy,vz], 'nazwa_particle', ładunek);

m1 = 20; m2 = 20;
vec_r1 = [0,0,0]; vec_r2 = [250,0,0];
vec_v1 = [100,0,0]; vec_v2 = [-100,0,0];
charge1 = 1;  % Ładunek ujemny dla cząstki A
charge2 = -1;  % Ładunek ujemny dla cząstki B

% Tworzenie obiektów Particle z ładunkami
a = Particle(m1, vec_r1, vec_v1, 'czastka_a', charge1);
disp(a);  % Wyświetlenie obiektu a

b = Particle(m2, vec_r2, vec_v2, 'czastka_b', charge2);
disp(b);  % Wyświetlenie obiektu b

%% Na potrzeby testów promień cząstki to też jest jej masa (używam tej samej liczby)
% Sprawdzanie czy cząstki się zderzą i po jakim czasie.

% Ustawienia symulacji
dt = 0.05;      % Krok czasowy symulacji (mniejszy dla dokładności)
max_time = 5;  % Maksymalny czas symulacji
time = 0;       % Aktualny czas symulacji
collision = false; % Flaga kolizji
electric_scale = 1; % Skala siły elektrycznej (można dostosować)

% Ustawienia animacji
figure('Name', 'CERN SIMULATOR - Animacja z polem elektrycznym', 'NumberTitle', 'off');
axis_limit = 1000; % Limit osi wykresu
history_length = 50; % Długość historii trajektorii (ile poprzednich pozycji pokazać)

% Przechowywanie historii pozycji do rysowania trajektorii
a_history = zeros(history_length, 3);
b_history = zeros(history_length, 3);

% Pętla symulacji
fprintf('\nRozpoczęcie symulacji z polem elektrycznym...\n');
while time < max_time && ~collision
    % Obliczanie odległości między cząstkami
    distance = norm(a.position - b.position);

    % Obliczanie siły elektrycznej działającej na cząstki
    [F_a_on_b, F_mag] = Felektryczna(a, b);

    % Siła działająca na cząstkę a (Newton's 3rd law: F_b_on_a = -F_a_on_b)
    F_b_on_a = -F_a_on_b;

    % Obliczanie przyspieszenia z siły elektrycznej (F = m*a => a = F/m)
    a_acc = F_b_on_a / a.mass * electric_scale;
    b_acc = F_a_on_b / b.mass * electric_scale;

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

    % Dodanie wektorów sił elektrycznych (podzielone przez skalę dla lepszej wizualizacji)
    scale_viz = 0.1;  % Skala wizualizacji siły
    quiver3(a.position(1), a.position(2), a.position(3), ...
            F_b_on_a(1)*scale_viz, F_b_on_a(2)*scale_viz, F_b_on_a(3)*scale_viz, 'm', 'LineWidth', 1.5);
    quiver3(b.position(1), b.position(2), b.position(3), ...
            F_a_on_b(1)*scale_viz, F_a_on_b(2)*scale_viz, F_a_on_b(3)*scale_viz, 'c', 'LineWidth', 1.5);

    % Ustawienia wykresu
    grid on;
    axis equal;
    axis([-1, axis_limit, -axis_limit/2, axis_limit/2, -axis_limit/2, axis_limit/2]);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title(sprintf('CERN SIMULATOR - Czas: %.2f s, Odległość: %.2f, Siła: %.2e N', time, distance, F_mag));

    % Dodanie informacji o ładunkach cząstek
    text(1, -axis_limit/2 + 1, axis_limit/2 - 1, ...
         sprintf('Cząstka A: m = %.2f, q = %.2f', a.mass, a.charge), ...
         'Color', 'red', 'FontSize', 10);
    text(1, -axis_limit/2 + 2, axis_limit/2 - 1, ...
         sprintf('Cząstka B: m = %.2f, q = %.2f', b.mass, b.charge), ...
         'Color', 'blue', 'FontSize', 10);

    % Informacja o typie interakcji
    if a.charge * b.charge > 0
        interaction_type = 'ODPYCHANIE';
        text_color = 'red';
    elseif a.charge * b.charge < 0
        interaction_type = 'PRZYCIĄGANIE';
        text_color = 'green';
    else
        interaction_type = 'BRAK INTERAKCJI';
        text_color = 'black';
    end
    text(axis_limit/2 - 5, axis_limit/2 - 1, 0, interaction_type, 'FontSize', 12, ...
         'Color', text_color, 'HorizontalAlignment', 'center', 'FontWeight', 'bold');

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

    % Aktualizacja prędkości i pozycji cząstek z uwzględnieniem przyspieszenia
    a = a.update(dt, a_acc);
    b = b.update(dt, b_acc);

    % Aktualizacja czasu
    time = time + dt;

    % Co kilka kroków wyświetl aktualny stan w konsoli
    if mod(round(time/dt), 20) == 0
        fprintf('Czas: %.2f, Odległość: %.2f, Siła: %.2e N\n', time, distance, F_mag);
    end

    % Pauza dla lepszej wizualizacji (opcjonalnie)
    pause(0.01);
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
           sprintf('CERN SIMULATOR | Autor: Krzysztof Bezubik | Data: 2025-04-07'), ...
           'EdgeColor', 'none', 'HorizontalAlignment', 'center');
