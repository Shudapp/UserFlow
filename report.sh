#!/bin/bash

report() {
echo "Raport generat: $(date)"
echo "User: $1"

echo "------------------------------------"

COUNT=$(find $(pwd) -type f | wc -l)
COUNT=$((COUNT - 1))
DIMENSIUNE_TOTALA=$(du -sb | cut -f1)
DIRECTOR=$(find $(pwd) -type d | wc -l)
echo " Număr de fișiere găsite: $COUNT"
echo " Dimensiunea tuturor fisierelor, fara script, este: $DIMENSIUNE_TOTALA bytes"
echo " Număr de directoare găsite: $DIRECTOR"

echo "------------------------------------"

}
