clc;
# czytanie pliku skibidi

a = inputdlg("NAPISZ COŚ NIE WIEM CO:", "Parametr");
filedir = uigetdir(".", "Wybierz katalog z danymi");
cd(FILEDIR);

filename = uigetfile("*.txt", "Wybierz plik do odczytu");
plik1 = fopen(filename, "rt");


save_format = "%f %f %s";
data = textscan(plik1, save_format);
fclose(plik1);

x_values = data{1};
y_values = data{2};
c_values = data{3};
disp("Wczytane dane:");
disp("   liczba1      liczba2      strint");
for i = 1:length(x_values)
  fprintf("%.5f  %.5f  %s\n", x_values(i), y_values(i), c_values{i});
end
filename1 = uiputfile("*.txt", "Wybierz plik do zapisu");
zapisany_file = fopen(filename1, "wt");
for i = 1:length(x_values)
  fprintf(zapisany_file, "%f %f %s\n", x_values(i), y_values(i), c_values{i});
end
fclose(zapisany_file);
disp(["Dane zapisano do pliku: " filename1]);


