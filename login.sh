#!/bin/bash

logged_in_users=()
login(){
    #daca exista user-ul, apelezi o functie aplicatie, unde poate sa genereze raport doar pentru el

    echo "Introduceti numele de utilizator"
    read nume

    linie=$(grep "$nume" users.csv)
    if [ -n "$linie" ]; then
        echo "Introduceti parola"
        read -s parola
        hash=$(echo $linie | cut -d',' -f4)
        parola=$(echo -n "$parola" | sha256sum | cut -d' ' -f1)
        if [ "$parola" = "$hash" ]; then
            last_login=$(date '+%Y-%m-%d %H:%M:%S')
            id=$(echo "$linie" | cut -d',' -f1)
            nume=$(echo "$linie" | cut -d',' -f2)
            email=$(echo "$linie" | cut -d',' -f3)
            parola=$(echo "$linie" | cut -d',' -f4)

            noua_linie="$id,$nume,$email,$parola,$last_login"

            sed -i "s/$linie/$noua_linie/" users.csv

            logged_in_users+=("$nume")
            echo "Te-ai logat cu succes, ultima logare a fost actualizata"
            cd "./users/$nume/home/"
            touch logout.sh
            echo '#!/bin/bash

            remove_user() {
                to_remove="$1"
                tmp=()
                for user in "${logged_in_users[@]}"; do
                    [[ "$user" != "$to_remove" ]] && tmp+=("$user")
                done
                logged_in_users=("${tmp[@]}")
            }

        logout() {
            echo "Logout pentru: $1"
            remove_user "$1"
            cd ../../../
        }

    logout "$1" '> logout.sh

    calea_curenta="$(pwd)"

    echo '#!/bin/bash
    RAPORT="raport_fisiere_$nume.txt"
    echo "Raport generat: $(date)" > "$RAPORT"
    echo "User: $nume" >> "$RAPORT"

    echo "------------------------------------" >> "$RAPORT"

    if [ -d $calea_curenta ]; then
        echo " Directorul pentru userul \"$USER\" există." >> "$RAPORT"

        COUNT=$(find $calea_curenta -type f 2> /tmp/eroare_find.txt | wc -l)
        COUNT=$((COUNT - 1))
        DIRECTOR=$(find $calea_curenta -type d 2> /tmp/eroare_find.txt | wc -l)
        echo " Număr de fișiere găsite: $COUNT" >> "$RAPORT"
        echo " Număr de directoare găsite: $DIRECTOR" >> "$RAPORT"
        if [ -s /tmp/eroare_find.txt ]; then
            echo "Erori apărute în timpul căutării:" >> "$RAPORT"
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
    cat "$RAPORT"' > report.sh
    chmod +x report.sh
    chmod +x logout.sh

else
    echo "Parola introdusa este gresita"
    return
        fi
    else
        echo "Nu exista utilizatorul cu numele $nume"
    fi
}
