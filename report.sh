#!/bin/bash

report() {
if [[ $1 == "" ]]; then
    local user="$(get_user)"
else
    local user="$1"
fi

echo "Raport generat: $(date)"
echo "User: $user"

echo "------------------------------------"

COUNT=$(find $file_path/users -type f | wc -l)
DIMENSIUNE_TOTALA=$(du -sb | cut -f1)
DIRECTOR=$(find $file_path/users -type d | wc -l)
TOTAL_COMENZI=$(wc -l < "$file_path/comenzi.log")
echo " Număr de fișiere găsite: $COUNT"
echo " Dimensiunea tuturor fisierelor utilizatorului sunt: $DIMENSIUNE_TOTALA bytes"
echo " Număr de directoare găsite: $DIRECTOR"
echo " Totalul comenzilor facute in aplicatie sunt: $TOTAL_COMENZI"

echo "------------------------------------"

}
