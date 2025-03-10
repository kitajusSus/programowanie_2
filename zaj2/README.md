# Zajęcia 2

Budowanie aplikacji okienkowych.

## Program testowy. 
**demo_**
Znaleziony w necie, dr. Brancewicz potem nam wyśle. 

Ten program ma wpisane jakies parametry wpisane. 

Otryzmane z pendrive.
[demouicontrol.m] (Demo_control)

(demouicontrol.m)(Democtorl)


### Demo_ui_control

```matlab
h.ax=axes("position",[0.05 0.42 0.5 0.5]);
 # tworzy wykres z osiami

h.fcn=@(x)polyval([-0.1 0.5 3 0],x);       # definiuje funkcje anonimowa


#return; #program sie skonczy po tej osi: powinien wyswietlic jedynie osie wykresu.

```
Jakieś obiekty definiujące o co be, 
Przykład robienia obiektu, i dodawania obiektów. 
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


## Zadanie na zajeciach. 
- wczytywanie danych z pliku, 
- 