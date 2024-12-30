#!/bin/bash

#3. HTMLPrettyPrinter (1–2 student, i) – Scrieti un program (script)
# shell care primeste ca input un fisier HTML si il formateaza a.i.
# sa reflecte vizual structura ierarhica si nivelul de imbricare al
# resurselor folosite prin indentarea corespunzatoare a tag-urilor
# si strigurilor.

# verfic daca s a citit ceva
if [ $# -eq 0 ]; then
  echo "EROARE: nu s-a citit niciun fisier!"
  exit 1
fi

# asociez o variabila primului argument
input_file=$1

# verfic daca s a citit ceva valid
if [ ! -f "$input_file" ]; then
  echo "EROARE: fisierul '$input_file' nu exista!"
  exit 1
fi

# formatez fisierul
tidy -indent -wrap 80 -quiet -modify $input_file
# indent -> activeaza indentare automata
# wrap 80 -> numarul maxim de caractere pe un rand
# quiet -> nu imi afiseaza warning urile
# modify -> modifica fisierul curent(fara el s-ar afisa in stdout)

#daca vreau sa il scriu intr un alt fisier:
#tidy -indent -wrap 80 -quiet $input_file > pretty_"$input_file"

# verific daca am reusit sa editez continutul fisierului
if [ $? -eq 0 ]; then   #$? = codul de iesire al ultimei operatii efectuate
  echo "SUCCES: fisierul '$input_file' a fost formatat si salvat!"
else
  echo "EROARE: fisierul '$input_file' nu a putut fi formatat!"
fi
