#  CERN SIMULATOR

**Przedmiot**: Programowanie 2 |semestr letni 2025 fizyka ogólna|

**Indeks**: 89219,

**Opis projektu**:
1.  stosując paradygmat programowania obiektowego w GNU/Octave:
2. program prezentujący zderzanie się cząstek i ich zachowanie z skutek zderzania, (rozpad itd), 
3. zderzanie typu cyklotron (cząstki są na jakimś relatywnie takim samym torze (*zasada nieoznaczoności heisenberga??*) i się rozpędzają -> na siebie.(**opcja 1**), jedna cząstka jest w miejscu.(**Opcja 2**) )
4.  możliwości: 
- wybór prędkości dla cząstki 1 i cząstki 2,
- tak samo możliwośc zmiany masy dla obu cząstek. 
5. Stworzenie GUI do tego. 
6. Wizualizacja wszystkiego. 

*Otrzymamy plik od dr. Brancewicza dotyczący opisu projektu przez nas.*
- zmienić imie i nazwisko, bez polskich liter,
- robic etapy, rozplanowanie według dokumentacji własnej, 
- 



## Rozplanowanie prac, 
**Ważne linki**:
- [Link do opisu zderzeń pdf](http://newton.ftj.agh.edu.pl/~tobola/informatyka/wyklady/W5/Zderzenia.pdf)
- [Opis jak tworzyć klasy](https://docs.octave.org/v4.2.1/Creating-a-Class.html#Creating-a-Class)
- [Octave dokumentacja](https://docs.octave.org/latest/)
### Etap 1:
Tworzenie potrzebnego aparatu matematycznego. 
1. Zachowanie pędu?
- jak to opisać? jak to obliczyć dla dwóch cząstek w octave? 
- dla przykładu jedna z nich jest nieruchoma a druga porusza się w strone tej pierwszej z jakąś prędkością.  
**Zachowanie pędu:**
$$m_1v_1 + m_2v_2 =m_1v_1' + m_2v_2' $$
**Zachowanie energii dla zdarzeń idealnie sprężystych:**
$$(\frac{1}{2})[m_1v_{1}^{2}+ m_2v_{2}^{2} = m_1v_{1}'^{2}+ m_2v_{1}'^{2}]$$
2. Kierunek, zwroty, wektory: 
- *Jak  wyliczyć położenie cząstki, po odbiciu? przed odbiciem?*
- *kiedy następuje zderzenie?*

**Klasa `particle`**


#### Notatki dotyczące rzeczy: 
**Jak tworzyć klasy?**
Bazując na poradniku ze strony octave; 
```octave
classdef nazwa_klasy
  properties 
  % tutaj są własciwosci typu private z cpp
  endproperties

  methods
  % co się dzieje z tą klasa, co mozna z nią zrobić???
  % zbiór różnych function
  % example:
    function disp(value)

  endmethods
endclassdef
```
W Pliku [klasy.m został pokazany](src/klasy.m) przyklad klasy, ktora wyswietla i tworzy wielomiany. 
by uruchomić trzeba: 
```bash 
>> p = klasy ([1,2,2,5])
p =

 1 + 2 * X + 2 * X ^ 2 + 5 * X ^ 3
```
> Jak widać liczby w nawiasie kwadratowym odpowadają wartości wspólczynników w wielomianie.

$$p = 1 + 2x + 2x^2 + 5x^3$$
