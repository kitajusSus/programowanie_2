classdef zajecia_1
    properties
        Imie
        Nazwisko
        Wiek
    end

    methods
        % Konstruktor
        function obj = Osoba(imie, nazwisko, wiek)
            if nargin > 0
                obj.Imie = imie;
                obj.Nazwisko = nazwisko;
                obj.Wiek = wiek;
            end
        end

        % Metoda do wyświetlania pełnych danych osoby
        function przedstaw_sie(obj)
            disp(['Cześć, mam na imię ' obj.Imie ' ' obj.Nazwisko ', mam ' num2str(obj.Wiek) ' lat.']);
        end

        % Metoda do obliczania wieku za X lat
        function wiek_za_iles_lat(obj, lata)
            przyszly_wiek = obj.Wiek + lata;
            disp(['Za ' num2str(lata) ' lat będę miał/a ' num2str(przyszly_wiek) ' lat.']);
        end
    end
end



