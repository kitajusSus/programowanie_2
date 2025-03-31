clear;
clc;

% Tworzenie obiektu klasy Particle
fprintf('Tworzenie cząstki...\n');
a = Particle(1.0, [0, 0], [1, 1], 'skibidi');
disp(a);
fprintf('Początkowy stan cząstki: [%.2f , %.2f]\n', a.position(1), a.position(2));
a = a.update(2);
fprintf('Stan po 2 sekundach: [%.2f , %.2f]\n', a.position(1), a.position(2));
a = a.update(2);
fprintf('Stan po 2 sekundach: [%.2f , %.2f]\n', a.position(1), a.position(2));
a = a.update(1.32);
fprintf('Stan po 1,32 sekundach: [%.2f , %.2f]\n', a.position(1), a.position(2));

#{
% Test metod w klasie Particle essunia tzw
fprintf('\nTest metody update:\n');
fprintf('Aktualizacja po 2sekundach...\n');
a = a.update(2);
fprintf('Pozycja po pierwszej aktualizacji: [%.2f, %.2f]\n', a.position(1), a.position(2));

fprintf('Aktualizacja o dt=1...\n');
a = a.update(1);
fprintf('Pozycja po drugiej aktualizacji: [%.2f, %.2f]\n', a.position(1), a.position(2));

fprintf('Dla dt=2...\n');
a = a.update(2);
fprintf('Pozycja po aktualizacji: [%.2f, %.2f]\n', a.position(1), a.position(2));

% Test metod obliczeniowych
fprintf('\nTest metod obliczeniowych:\n');
fprintf('Energia kinetyczna: %.2f\n', a.kineticEnergy());
p = a.momentum();
fprintf('Pęd: [%.2f, %.2f]\n', p(1), p(2));

fprintf('\nTest zakończony pomyślnie!\n');
#}
