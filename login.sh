#!/bin/bash

login(){
#adica folosesti operatorul logic !
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

        echo "Te-ai logat cu succes, ultima logare a fost actualizata"
        cd ./users/$nume/
    else
        echo "Parola introdusa este gresita"
        return
    fi
else
    echo "Nu exista utilizatorul cu numele $nume"
fi
}
