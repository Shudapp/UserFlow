#!/bin/bash

report() {
 read -p "Introduceti numele userului: " USER
 FAKE_HOME="./fake_home/$USER"
 RAPORT="raport_fisiere_$USER.txt"
 mkdir "$FAKE_HOME"
 mkdir "FAKE_HOME"/fane
touch "$FAKE_HOME"/fisier1.txt "$FAKE_HOME"/fisier2.txt "$FAKE_HOME"/document.doc
 echo  "Raport generat: $(date)" > echo "User simulat: $USER" >> "$RAPORT"
echo "Director analizat: $FAKE_HOME" >> "$RAPORT"
echo "------------------------------------" >> "$RAPORT"

if [ -d "$FAKE_HOME" ]; then
    echo " Directorul pentru userul \"$USER\" există." >> "$RAPORT"

    COUNT=$(find "$FAKE_HOME" -type f 2> /tmp/eroare_find.txt | wc -l)
    DIRECTOR=$(find "$FAKE_HOME" -type d 2> /tmp/eroare_find.txt | wc -l)
  echo " Număr de fișiere găsite: $COUNT" >> "$RAPORT"
   echo " Număr de directoare găsite: $DIRECTOR" >> "$RAPORT"
    if [ -s /tmp/eroare_find.txt ]; then
        echo " Erori apărute în timpul căutării:" >> "$RAPORT"
        cat /tmp/eroare_find.txt >> "$RAPORT"
    else
        echo " Nicio eroare detectată în timpul căutării." >> "$RAPORT"
    fi

    rm -f /tmp/eroare_find.txt
else
    echo "Directorul pentru userul \"$USER\" NU există." >> "$RAPORT"
fi

echo "------------------------------------" >> "$RAPORT"
echo "Raport generat local în: $RAPORT"
cat "$RAPORT"
help="Lista de comenzi:\n 1.report nume\n 2.raport nume\n 3.nume\n"
read comanda
if [[ $comanda == "-help" || $comanda == "help" ]]; then
 echo -e $help
 report
fi
#verifici daca user-ul are login de admin, daca il are, atunci poate sa genereze orice raport folosind comanda 
#report nume sau raport nume DACA NU ARE, atunci poate doar sa foloseasca numele lui, adica trebuie sa cauti
#numele lui, dupa report sau raport, ai 1000 de moduri in care sa faci asta, dar ai grija sa fie error prone
#raport-ul e ce vrei tu, fie generezi data cand s-a logat si adaugi la login acolo un timestamp,
#fie adaugi numarul de comenzi puse cu un contor acolo de fiecare data cand s-a apelat o comanda
#adica bagi o variabila cnt in main pe care o cresti de fiecare data cand face user-ul ceva, si o updatezi
#CREATIVITATE!!!!!!!!!!!!!!!

}
