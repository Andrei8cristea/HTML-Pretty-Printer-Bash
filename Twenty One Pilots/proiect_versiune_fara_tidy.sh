#!/bin/bash

#3. HTMLPrettyPrinter (1–2 student, i) – Scrieti un program (script)
# shell care primeste ca input un fisier HTML si il formateaza a.i.
# sa reflecte vizual structura ierarhica si nivelul de imbricare al
# resurselor folosite prin indentarea corespunzatoare a tag-urilor
# si strigurilor.

# verfic daca s a citit ceva
if [ $# -eq 0 ]; then
  echo "EROARE: nu s-a citit niciun fișier!"
  exit 1
fi

# asociez o variabila primului argument
input_file=$1

# verfic daca s a citit ceva valid
if [ ! -f "$input_file" ]; then
  echo "EROARE: fișierul '$input_file' nu există!"
  exit 1
fi

# functia pentru indentare
indent() {
  local level=$1
  local line=$2
  printf "%*s%s\n" $((level * 2)) "" "$line"
  # se insereaza doua spatii pt fiecare nivel(tab = 2 spaces)
}

# scrierea input file ului pe linii multiple(toate incep de la level 0)
formatted_lines=$(echo "$(cat "$input_file")" | sed 's/</\n</g' | sed 's/>/>\n/g')
# '|' directioneaza output ul catre sed(stream editor)
# fiecare tag de inceput sau de sfarsit este scris pe cate un rand separat
#substitute global
# < este inlocuit cu \n< si > este inlocuit cu >/n


# formatarea fisierului
level=0
while IFS= read -r line; do #Internal Field Separator imi citeste textul pe linii
  # verific daca linia arata asa <nume_tag>
  # ^ -> inceputul liniei
  # < -> tag de deschidere
  # ([a-zA-Z]+) -> unul sau mamulte caractere litere (mari sau mici)
  #[^>]* -> orice caractere care nu sunt ">"
  # > -> inchderea tag ului
  # $ -> sfarsitul liniei

  if echo "$line" | grep -qP '^<([a-zA-Z]+)[^>]*>$'; then
    indent $level "$line"
    ((level++))
  # verific daca linia arata asa </nume_tag>
  elif echo "$line" | grep -qP '^<\/([a-zA-Z]+)[^>]*>$'; then
    ((level--))
    indent $level "$line"
  # verific daca linia arata asa <nume_tag/>
  elif echo "$line" | grep -qP '^<.*\/>$'; then
    indent $level "$line"
  else
  # altfel linia este text si se indenteaza la nivelul curent
    indent $level "$line"
  fi

  # folosesc formated lines ca date de intrare pentru loop si le returnez formatate
  # intr un file nou
  # daca nu specificam unde, s ar fi afisat in stdout
done <<< "$formatted_lines" > "pretty_$input_file"

echo "SUCCES: Fișierul '$input_file' a fost formatat și salvat ca 'pretty_$input_file'."
