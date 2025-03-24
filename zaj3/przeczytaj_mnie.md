# Dokumentacja Programu do Dopasowania Prostej

## Spis treści
1. [Wprowadzenie](#wprowadzenie)
2. [Wymagania](#wymagania)
3. [Struktura Programu](#struktura-programu)
4. [Szczegółowy Opis Kodu](#szczegółowy-opis-kodu)
5. [Interfejs Użytkownika](#interfejs-użytkownika)
6. [Obsługa Plików](#obsługa-plików)
7. [Funkcje Matematyczne](#funkcje-matematyczne)

## Wprowadzenie <a name="wprowadzenie"></a>
Program służy do dopasowania prostej do punktów danych metodą regresji liniowej. Posiada graficzny interfejs użytkownika (GUI) umożliwiający:
- Wczytywanie danych z pliku
- Dopasowanie prostej
- Dostosowanie wyglądu wykresu
- Zapisywanie wyników i wykresów

## Wymagania <a name="wymagania"></a>
- GNU Octave
- Pakiet Qt do obsługi grafiki
- Dane wejściowe w formacie tekstowym

## Struktura Programu <a name="struktura-programu"></a>

### 1. Inicjalizacja Programu
```octave
close all;
clear all;
graphics_toolkit qt
```
- `close all` - zamyka wszystkie otwarte okna wykresów
- `clear all` - czyści pamięć ze wszystkich zmiennych
- `graphics_toolkit qt` - ustawia Qt jako bibliotekę graficzną

### 2. Funkcja Pomocnicza merge
```octave
function result = merge(condition, true_value, false_value)
  if (condition)
    result = true_value;
  else
    result = false_value;
  endif
endfunction
```
Funkcja działa jak operator trójargumentowy:
- `condition` - warunek logiczny
- `true_value` - wartość zwracana gdy warunek prawdziwy
- `false_value` - wartość zwracana gdy warunek fałszywy

## Szczegółowy Opis Kodu <a name="szczegółowy-opis-kodu"></a>

### 1. Tworzenie Głównego Okna
```matlab
h.fig = figure("name", "Program do dopasowania prostej",
              "position", [100, 100, 800, 600],
              "color", [1,1,1]);
```
- `figure` - tworzy nowe okno
- `name` - ustawia tytuł okna
- `position` - ustawia pozycję [x, y] i rozmiar [szerokość, wysokość]
- `color` - kolor tła [R, G, B] (białe tło)

### 2. Obszar Wykresu
```matlab
h.ax = axes("position", [0.05, 0.42, 0.5, 0.5]);
```
- `axes` - tworzy obszar wykresu
- `position` - pozycja i rozmiar względny [lewo, dół, szerokość, wysokość]

### 3. Główna Funkcja update_plot
```matlab
function update_plot(obj, init=false)
```
Funkcja obsługująca wszystkie zdarzenia GUI:

#### A. Wczytywanie Danych
```matlab
[filename, filepath] = uigetfile({...})
```
- `uigetfile` - otwiera okno wyboru pliku
- Obsługuje pliki .txt
- Wczytuje dane w formacie: X Y [komentarz]

#### B. Dopasowanie Prostej
```matlab
[p, s] = polyfit(h.data_x, h.data_y, 1);
```
- `polyfit` - dopasowuje wielomian (tutaj stopnia 1 - prosta)
- `p(1)` - współczynnik kierunkowy (a)
- `p(2)` - wyraz wolny (b)

#### C. Obliczanie R²
```matlab
R_squared = 1 - (SS_residual / SS_total);
```
- Oblicza współczynnik determinacji
- `SS_total` - suma kwadratów odchyleń od średniej
- `SS_residual` - suma kwadratów reszt

### 4. Elementy Interfejsu

#### A. Przyciski
```matlab
h.ladowanie_danych = uicontrol("style", "pushbutton", ...)
```
- `uicontrol` - tworzy element interfejsu
- `style` - typ elementu (przycisk, tekst, suwak, etc.)
- `position` - pozycja względna [x, y, szerokość, wysokość]
- `callback` - funkcja wywoływana po kliknięciu

#### B. Pola Tekstowe
```matlab
h.info_text = uicontrol("style", "text", ...)
```
- Wyświetla informacje o stanie programu
- Pokazuje komunikaty o błędach
- Aktualizuje się automatycznie

#### C. Kontrolki Wykresu
1. Suwak Grubości Linii
```matlab
h.line_thickness = uicontrol("style", "slider", ...)
```
- Zakres: 1-5
- Wartość domyślna: 2.5

2. Wybór Koloru
```matlab
h.linecolor_niebieski = uicontrol("style", "radiobutton", ...)
```
- Przyciski radiowe dla wyboru koloru
- Niebieski/Czerwony

3. Style Linii
```matlab
h.linestyle_popup = uicontrol("style", "popupmenu", ...)
```
- Ciągła (-)
- Przerywana (--)
- Kropkowana (:)
- Kropkowo-kreskowa (-.)

4. Znaczniki
```matlab
h.markerstyle_list = uicontrol("style", "listbox", ...)
```
- Różne typy znaczników (o, +, *, etc.)

### 5. Obsługa Plików

#### A. Format Wejściowy
```matlab
X1 Y1 [komentarz]
X2 Y2 [komentarz]
...
```
- Wartości oddzielone spacjami
- Komentarze opcjonalne

#### B. Format Wyjściowy
```
# Wyniki dopasowania prostej
# Data: [timestamp]
# Równanie prostej: y = ax + b
# R² = [wartość]
# Dane wejściowe (x, y):
[dane]
```

### 6. Funkcje Matematyczne

#### A. Dopasowanie Prostej
```octave
[p, s] = polyfit(x, y, 1)
```
- Metoda najmniejszych kwadratów
- Stopień wielomianu = 1 (prosta)
- Zwraca współczynniki a i b

#### B. Obliczanie Punktów Prostej
```octave
y_fit = polyval(p, x_fit)
```
- Oblicza wartości Y dla zadanych X
- Używa współczynników z polyfit

## Użycie Programu

1. Uruchomienie
   - Otworzyć Octave
   - Wczytać skrypt
   - Uruchomić program

2. Wczytywanie Danych
   - Kliknąć "Wczytaj dane z pliku"
   - Wybrać plik .txt
   - Sprawdzić statystyki

3. Dopasowanie
   - Kliknąć "Dopasuj prostą"
   - Sprawdzić wyniki
   - Dostosować wygląd

4. Zapisywanie
   - "Zapisz wyniki" - dane numeryczne
   - "Zapisz wykres" - obraz PNG

## Ważne Funkcje

### 1. guidata
```octave
guidata(gcf, h)
```
- Przechowuje dane GUI
- Umożliwia dostęp między funkcjami

### 2. get/set
```octave
get(h.line_thickness, "value")
set(h.info_text, "string", "tekst")
```
- Pobieranie/ustawianie właściwości
- Aktualizacja interfejsu

### 3. hold
```octave
hold(h.ax, "on")
```
- Zachowuje poprzednie wykresy
- Umożliwia nakładanie grafik




> claude sonnet 3.5 generował ten plik, ja jedynie dopisywałem głupoty, ale dokumentowanie jest zbyt boring ass bym mógł pozwolić sobie na takie rzeczy, jestem fizykiem teoretycznym a nie praktycznym.