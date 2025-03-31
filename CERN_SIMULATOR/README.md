#  CERN SIMULATOR

**Przedmiot**: Programowanie 2 |semestr letni 2025 fizyka ogólna|

**Indeks*: 89219,


**Opis projektu**:
1.  stosując paradygmat programowania obiektowego w GNU/Octave:
2. program prezentujący zderzanie się cząstek i ich zachowanie z skutek zderzania, (rozpad itd), 
3. zderzanie typu cyklotron (cząstki są na jakimś relatywnie takim samym torze (*zasada nieoznaczoności heisenberga??*) i się rozpędzają -> na siebie.(**opcja 1**), jedna cząstka jest w miejscu.(**Opcja 2**) )
4.  możliwości: 
- wybór prędkości dla cząstki 1 i cząstki 2,
- tak samo możliwośc zmiany masy dla obu cząstek. 


## Rozplanowanie prac, 
**Ważne linki**:
- [Link do opisu zderzeń pdf](http://newton.ftj.agh.edu.pl/~tobola/informatyka/wyklady/W5/Zderzenia.pdf)
### Etap 1:
1. Zachowanie pędu?
- jak to opisać? jak to obliczyć dla dwóch cząstek w octave? 
- dla przykładu jedna z nich jest nieruchoma a druga porusza się w strone tej pierwszej z jakąś prędkością.  
**Zachowanie pędu:**
$$m_1v_1 + m_2v_2 =m_1v_1' + m_2v_2' $$
**Zachowanie energii dla zdarzeń idealnie sprężystych:**
$$(\frac{1}{2})[m_1v_{1}^{2}+ m_2v_{2}^{2} = m_1v_{1}'^{2}+ m_2v_{1}'^{2}]$$
2. 