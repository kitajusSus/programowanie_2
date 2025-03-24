# Autor: 89219
# Data: 2025-03-17
% w wielu miejscach używam tagów, gdzie pisze  te same rzeczy na różne sposoby, by miec jak potem to zmienic
close all;
clear all;
graphics_toolkit qt

% Funkcja pomocnicza do wyboru wartości na podstawie warunku
#{
function result = merge(condition, true_value, false_value)
  if (condition)
    result = true_value;
  else
    result = false_value;
  endif
endfunction
#}

 %Tworzenie okna głównego
h.fig = figure("name", "Program do dopasowania prostej",
              "position", [100, 100, 800, 600],
              "color", [1,1,1]);

% Tworzenie głównego wykresu
h.ax = axes("position", [0.05, 0.42, 0.5, 0.5]);

% Funkcja do aktualizacji wykresu i obliczeń
function update_plot(obj, init=false)
  h = guidata(obj); # zdefiniowany obiekt
  replot = false;

  switch (gcbo)
    case {h.ladowanie_danych}
      % Otwieranie pliku z danymi
      [filename, filepath] = uigetfile({"*.txt", "Pliki tekstowe (*.txt)"},
                                      "Wybierz plik z danymi");
      if (filename != 0)
        fullpath = fullfile(filepath, filename);
        try
          %Wczytanie danych z pliku
          plik1 = fopen(fullpath, "rt");
          save_format = "%f %f %s"; # float, float, string;
          data = textscan(plik1, save_format);
          fclose(plik1);
          h.data_x = data{1};
          h.data_y = data{2};
          ## Aktualizacja pola informacji
          set(h.info_text, "string", sprintf("Wczytano %d punktów z pliku: %s",
                                          length(h.data_x), filename));
          ## Policzenie statystyk
          h.liczba_punktow = length(h.data_x);
          h.min_x = min(h.data_x);
          h.max_x = max(h.data_x);
          h.min_y = min(h.data_y);
          h.max_y = max(h.data_y);
          ## Wyświetlenie statystyk
          stats_text = sprintf("Liczba punktów: %d\nZakres X: [%.2f, %.2f]\nZakres Y: [%.2f, %.2f]",
                             h.liczba_punktow, h.min_x, h.max_x, h.min_y, h.max_y);
          set(h.stats_display, "string", stats_text);
          ## Aktywacja przycisków
          set(h.przycisk_dopasowania, "enable", "on");
          set(h.przycisk_zapisywanie, "enable", "on");

          guidata(obj, h);
         % Wyświetlenie surowych danych
         ## ERRORBAR USTAWIENIE  errorbar(X,Y,EX,EY,FMT)
         % errorbar
          errorbar(h.data_x, h.data_y,1,0.5, "o", "markersize", 8);
          title(h.ax, "Dane wejściowe");
          grid(h.ax, "on");
          xlabel(h.ax, "X");
          ylabel(h.ax, "Y");
%% rysowanie osi
        catch
          set(h.info_text, "string", "Błąd wczytywania pliku. Sprawdź format.");
        end_try_catch
      endif

    case {h.przycisk_dopasowania}
      if (isfield(h, "data_x") && isfield(h, "data_y"))
        % Dopasowanie prostej (wielomian stopnia 1)
        [p, s] = polyfit(h.data_x, h.data_y, 1);
        h.a = p(1);  % współczynnik kierunkowy
        h.b = p(2);  % wyraz wolny
        fprintf("AutoDeubgger Przycisk dopasowania, dziala: %f \n", h.a);

        % Obliczenie punktów do wykresu
        h.x_fit = linspace(min(h.data_x), max(h.data_x), 100);
        h.y_fit = polyval(p, h.x_fit);

        % Obliczenie R^2 (współczynnik determinacji)
        y_fit = polyval(p, h.data_x);
        SS_total = sum((h.data_y - mean(h.data_y)).^2);
        SS_residual = sum((h.data_y - y_fit).^2);
        R_squared = 1 - (SS_residual / SS_total);
        h.R_squared = R_squared;
        % Aktualizowanie wyniku
        result_text = sprintf("Wynik dopasowania:\ny = %.4f * x + %.4f\nR^2 = %.4f",
                            h.a, h.b, h.R_squared);
        set(h.result_display, "string", result_text);
        guidata(obj, h);
        replot = true;
        set(h.info_text, "string", "Dopasowanie prostej zakończone");
      endif

    case {h.grid_checkbox}
      v = get(gcbo, "value");
      grid(h.ax, merge(v, "on", "off"));

    case {h.zmiana_nazwy}
      v = get(gcbo, "string");
      title(h.ax, v);

    case {h.linecolor_niebieski, h.linecolor_czerwony}
      set(h.linecolor_niebieski, "value", gcbo == h.linecolor_niebieski);
      set(h.linecolor_czerwony, "value", gcbo == h.linecolor_czerwony);
      replot = true;

    case {h.linestyle_popup, h.markerstyle_list}
      replot = true;

    case {h.line_thickness}
      replot = true;

    case {h.przycisk_zapisywanie}
    % `isfield` - sprawdzanie czy  pole "a" w obiekcie h jest wypełnione itd
      if (isfield(h, "a") && isfield(h, "b"))
        [filename, filepath] = uiputfile({"*.txt", "Pliki tekstowe (*.txt)"},
                                        "Zapisz wyniki");
        if (filename != 0)
          fullpath = fullfile(filepath, filename);
        % Zapisanie wyników do pliku
          zapisany_file = fopen(fullpath, "wt");
          fprintf(zapisany_file, "# Wyniki dopasowania prostej\n");
          fprintf(zapisany_file, "# Data: %s\n\n", datestr(now));
          fprintf(zapisany_file, "# Równanie prostej: y = %.6f * x + %.6f\n", h.a, h.b);
          fprintf(zapisany_file, "# R^2 = %.6f\n\n", h.R_squared);
          fprintf(zapisany_file, "# Dane wejściowe (x, y):\n");

          for i = 1:length(h.data_x)
            fprintf(zapisany_file, "%.6f %.6f\n", h.data_x(i), h.data_y(i));
          endfor

          fclose(zapisany_file);
          set(h.info_text, "string", sprintf("Wyniki zapisano do pliku: %s", filename));
        endif
      else
        set(h.info_text, "string", "Brak wyników do zapisania.");
      endif

    case {h.przycisk_wykres}
      [filename, filepath] = uiputfile({"*.png", "Obraz PNG (*.png)"},
                                      "Zapisz wykres");
      if (filename != 0)
        fullpath = fullfile(filepath, filename);
        print(fullpath);
        set(h.info_text, "string", sprintf("Wykres zapisano do pliku: %s", filename));
      endif
  endswitch
%Aktualizacja wykresu
%  sprawdzanie  (a nalogicznie jak ostatnio) czy argumenty h takie jak "x_fit" i "y_fit" są wypełnione. (mają wartosci
  if (replot && isfield(h, "x_fit") && isfield(h, "y_fit"))
    % Pobranie aktualnych ustawień
    linewidth = get(h.line_thickness, "value");
  %Kolor linii
    cb_red = get(h.linecolor_czerwony, "value");
    line_color = merge(cb_red, [1 0 0], [0 0 1]);
 %Styl linii
    lstyle_idx = get(h.linestyle_popup, "value");
    lstyles = {"-", "--", ":", "-."};
    lstyle = lstyles{lstyle_idx};
 % Styl znacznika
    marker_idx = get(h.markerstyle_list, "value");
    markers = {"none", "+", "o", "*", ".", "x", "s", "d", "^"};
    mstyle = markers{marker_idx};
   %nieniesienie  danych i dopasowania
    cla(h.ax);
    hold(h.ax, "on");
    errorbar( h.data_x, h.data_y,25,15, '>'); %dane
    plot(h.ax, h.x_fit, h.y_fit,
          "color", line_color,
          "linestyle", lstyle,
         "linewidth", linewidth,
         "marker", mstyle); %prosta
    legend(h.ax, "Dane", "Prosta dopasowana");
    %%Aktualizacja tytułu wykresu
    plot_tytul = get(h.zmiana_nazwy, "string");
    if (!isempty(plot_tytul))
      title(h.ax, plot_tytul);
    else
      title(h.ax, "pole do zmiany nazwy wykresu");
    endif
    xlabel(h.ax, "X");
    ylabel(h.ax, "Y");
    % Zastosowanie siatki
    grid(h.ax, merge(get(h.grid_checkbox, "value"), "on", "off"));
    hold(h.ax, "off");
  endif
endfunction

%%Przyciski do wczytywania danych i dopasowania
h.ladowanie_danych = uicontrol("style", "pushbutton",
                             "units", "normalized",
                             "string", "Wczytaj dane z pliku",
                             "callback", @update_plot,
                             "position", [0.05, 0.35, 0.25, 0.05]);
h.przycisk_dopasowania = uicontrol("style", "pushbutton",
                        "units", "normalized",
                        "string", "Dopasuj prostą",
                        "callback", @update_plot,
                        "enable", "off",
                        "position", [0.31, 0.35, 0.25, 0.05]);
%%Panel informacyjny
h.info_text = uicontrol("style", "text",
                       "units", "normalized",
                       "string", "Wczytaj plik z danymi aby rozpocząć.",
                       "horizontalalignment", "left",
                       "position", [0.05, 0.29, 0.5, 0.05]);
%%Statystyki danych
h.stats_display = uicontrol("style", "text",
                          "units", "normalized",
                          "string", "puste okno h.stats_display",
                          "horizontalalignment", "left",
                          "position", [0.05, 0.15, 0.25, 0.12]);
% Wyniki dopasowania
h.result_display = uicontrol("style", "text",
                           "units", "normalized",
                           "string", "puste okno h.result_display, wyniki",
                           "horizontalalignment", "left",
                           "position", [0.31, 0.15, 0.25, 0.12]);

h.przycisk_zapisywanie = uicontrol("style", "pushbutton",
                        "units", "normalized",
                        "string", "Zapisz wyniki",
                        "callback", @update_plot,
                        "enable", "off",
                        "position", [0.05, 0.08, 0.25, 0.05]);

h.przycisk_wykres = uicontrol("style", "pushbutton",
                         "units", "normalized",
                         "string", "Zapisz wykres",
                         "callback", @update_plot,
                         "position", [0.31, 0.08, 0.25, 0.05]);

h.tytul_label = uicontrol("style", "text",
                             "units", "normalized",
                             "string", "Tytuł wykresu:",
                             "horizontalalignment", "left",
                             "position", [0.6, 0.85, 0.35, 0.05]);
% change name
h.zmiana_nazwy = uicontrol("style", "edit",
                            "units", "normalized",
                            "string", "Defaulotowe ustawienie tittle wykresy",
                            "callback", @update_plot,
                            "position", [0.6, 0.80, 0.35, 0.05]);

h.grid_checkbox = uicontrol("style", "checkbox",
                          "units", "normalized",
                          "string", "Pokaż siatkę",
                          "value", 1,
                          "callback", @update_plot,
                          "position", [0.6, 0.75, 0.35, 0.05]);

h.line_thickness_label = uicontrol("style", "text",
                                 "units", "normalized",
                                 "string", "Grubość linii:",
                                 "horizontalalignment", "left",
                                 "position", [0.6, 0.70, 0.35, 0.05]);
%% line T H I  C C  ness  no dosłownie wiadomo o co be
% grubosc linii / grubosc
h.line_thickness = uicontrol("style", "slider",
                           "units", "normalized",
                           "min", 1,
                           "max", 5,
                           "value", 2.5,
                           "callback", @update_plot,
                           "position", [0.6, 0.65, 0.35, 0.05]);
#{
- value to ustawienie defaultowe działające przy uruchomieniu programu./ /// standardowe
#}


h.linecolor_label = uicontrol("style", "text",
                            "units", "normalized",
                            "string", "Kolor linii:",
                            "horizontalalignment", "left",
                            "position", [0.6, 0.60, 0.35, 0.05]);

h.linecolor_niebieski = uicontrol("style", "radiobutton",
                                 "units", "normalized",
                                 "string", "Niebieski",
                                 "value", 1,
                                 "callback", @update_plot,
                                 "position", [0.6, 0.55, 0.15, 0.05]);

h.linecolor_czerwony = uicontrol("style", "radiobutton",
                                "units", "normalized",
                                "string", "Czerwony",
                                "value", 0,
                                "callback", @update_plot,
                                "position", [0.8, 0.55, 0.15, 0.05]);

h.linestyle_label = uicontrol("style", "text",
                            "units", "normalized",
                            "string", "Styl linii:",
                            "horizontalalignment", "left",
                            "position", [0.6, 0.50, 0.35, 0.05]);

h.linestyle_popup = uicontrol("style", "popupmenu",
                            "units", "normalized",
                            "string", {"-  linia ciągła", "-- linia przerywana", ":  linia kropkowana", "-. linia kropkowo-kreskowa"},
                            "callback", @update_plot,
                            "position", [0.6, 0.45, 0.35, 0.05]);
# zmiana kształtu punktów, dla każdego elementu regresji
h.markerstyle_label = uicontrol("style", "text",
                              "units", "normalized",
                              "string", "Styl znacznika:",
                              "horizontalalignment", "left",
                              "position", [0.6, 0.40, 0.35, 0.05]);

h.markerstyle_list = uicontrol("style", "listbox",
                             "units", "normalized",
                             "string", {"none", "+  krzyżyk", "o  kółko", "*  gwiazdka", ".  kropka", "x  krzyż", "s  kwadrat", "d  diament", "^  trójkąt w górę"},
                             "callback", @update_plot,
                             "position", [0.6, 0.20, 0.35, 0.20]);

set(gcf, "color", [1,1,1]);
guidata(gcf, h);
update_plot(gcf, true);
