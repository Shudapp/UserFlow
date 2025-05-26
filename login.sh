#!/bin/bash
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
            id=$(echo "$linie" | cut -d' ' -f1)
            nume=$(echo "$linie" | cut -d' ' -f2)
            email=$(echo "$linie" | cut -d' ' -f3)
            parola=$(echo "$linie" | cut -d' ' -f4)

            noua_linie="$id,$nume,$email,$parola,$last_login"

            sed -i "s/$linie/$noua_linie/" users.csv

            logged_in_users+=("$nume")
            echo "Te-ai logat cu succes, ultima logare a fost actualizata"
            cd "./users/$nume/home/"
else
    echo "Parola introdusa este gresita"
    return
        fi
    else
        echo "Nu exista utilizatorul cu numele $nume"
    fi
return id
}
