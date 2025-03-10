# odczytywanie danych z pliku input.txt




c = {"jeden"; "dwa"; "trzy"; "cztery"; "piec"; "szesc"};


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
disp(data)


