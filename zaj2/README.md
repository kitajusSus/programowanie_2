# Zajęcia 2

Budowanie aplikacji okienkowych.

## Program testowy. 
**demo_**
Znaleziony w necie, dr. Brancewicz potem nam wyśle. 

Ten program ma wpisane jakies parametry wpisane. 

Otryzmane z pendrive.
[przykladowe gui](demouicontrol.m) 




### Demo_ui_control

```matlab
h.ax=axes("position",[0.05 0.42 0.5 0.5]);
 # tworzy wykres z osiami

h.fcn=@(x)polyval([-0.1 0.5 3 0],x);       # definiuje funkcje anonimowa


#return; #program sie skonczy po tej osi: powinien wyswietlic jedynie osie wykresu.

```


Jakieś obiekty definiujące o co be, 
Przykład robienia obiektu, i dodawania obiektów. (zmiuenne strukturalne) 

Generalnie to robi się zmienna strukturalna taka jakby tablica: 
Każda zmienna strukturalna ma taki jakby identyfikator  (id) ktory mozna identyfikowac lub modytokowac lub zmieniac. itp itd. Elo elo marcin łapie sie za glowe bo nie wie co sie dzieje, juz szuka korepetycji u matemaksa. MATEMATYKA NA MAKSA (maksymalna ilosc punktów) 

```matlab
x.a = 100;
disp(x.a);
#output a == 100
x.b = 120;
disp(x.b);
# output b == 120;
disp(x);
#>> zajecia2
#100
#120
#    a = 100
#   b = 120
```
---


```matlab
h.plot_title_edit = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "Please fill me! (edit)",
                               "callback", @update_plot,
                               "position", [0.6 0.80 0.35 0.06]);

```
Trzeba pilnowac by rozmiary pasowały 

- "callback"  -- co sie stanie jesli klikne to pole, 
- @update_plot -- wyżej zdefiniowana custom funkcja , - zmienia tytuł wykresu. 


```matlab
## grid
h.grid_checkbox = uicontrol ("style", "checkbox",
                             "units", "normalized",
                             "string", "show grid\n(checkbox)",
                             "value", 0,
                             "callback", @update_plot,
                             "position", [0.6 0.65 0.35 0.09]);

```

Pole typu checkbox
- units - znormalizowane jako zakres [0,1]
- string - show grid, (pokaz/ wyłącz siatkę) -- narazie nie jest zdefiniowana siatka,
ale miejsce na jej wyłaczynie juz jest gotowe ;



## Zapisywanie i odczytywanie plików tekstowych. 
[Odczytywanie danych w pliku .txt (plik)](input.txt)
[Skrypt do odczytywania plików .txt](zajecia2.m)

Macierz strukturalna 
```matlab
c = {"jeden"; "dwa"; "trzy"; "cztery"; "piec"; "szesc"};
```

```matlab
plik1 = fopen('input.txt', 'rt');
#{
w - write;
r - read;
wr - write and read;
#}

save_format = '%f %f %s \n';
#{
for  i = 1:length(x):
  fprintf(plik1, sprintf(save_format, x(i), y(i),c(i)));
endfor


disp(plik1);

nie wiem o co be z tym.
#}


data = textscan(plik1, save_format);
fclose(plik1);
disp(data);
```
> Wygląda git ale problemem jest to że każda kolumna jest wyświetlana po kolei a nie obok siebie. 



## Zadanie na zajeciach. 
- wczytywanie danych z pliku, 
- Dodać pole dialogowe pod jaka ma zapisać plik, 
- program sie zapisuje pod taka nazwa, razem z oknami dialogowymi. 
- wczytać dane, wyswetlic
- pytac o dane do zapisu itd
- uruchamiać z okna dialogowego plik. 
