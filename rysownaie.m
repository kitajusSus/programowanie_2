% Generowanie danych (symulowane dane)
x = linspace(0, 10, 50);  % 50 punktów w zakresie od 0 do 5
y =  x +  rand(1,50) ;  % no i mozna tez + rand(1,50) dla szumu;

% Dopasowanie linii regresji (współczynniki a i b)
p = polyfit(x, y, 1)  % Dopasowanie linii do danych (stopień 1 -> linia)
% pierwszy element to dopasownaie a, potem jest  (współczynnik przesunięcia wyraz wolny b:
a = p(1);
b = p(2);

% Definicja funkcji regresji
y_regresja =  a * x. + b;

%parametry generalnie tego co robił;
fps = 30;  % Klatki na sekundę
num_frames = 100;
r = 0.5;  % rozmiar kulki
x_range = linspace(0, 10, num_frames);  % Zasięg X dla animacji
y_range = y_regresja(x_range);  % Obliczenie odpowiadających punktów Y

% Tworzymy okno wykresu
figure;
axis([0 5 0 10]);
hold on;
grid on;

#plot(x, y, 'b.', 'MarkerSize', 10);
plot(x, y_regresja(x), '-r', 'LineWidth', 2);

% Tworzenie  kulki
% kulka jako rysunek NaN, nie ma zdefiniowanej pozycji, ale jest rysunkiem juz samodzielnym:
kulka = plot(NaN, NaN, 'g', 'MarkerFaceColor', 'g', 'MarkerSize', 50);  % Kulka

% Animacja kulki poruszającej się wzdłuż linii regresji
for i = 1:num_frames
    % Ustalanie nowej pozycji kulki
    x_pos = x_range(i);  % Pozycja X kulki
    y_pos = y_range(i);  % Pozycja Y kulki (zgodnie z linią regresji)

    % Ustawianie pozycji kulki
    set(kulka, 'XData', x_pos, 'YData', y_pos);
    pause(1 / fps);
end






