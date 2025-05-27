#!/bin/bash
remove_user() {
    local user="$1"
    #linie=$(grep -Fq ",$user," users.csv)
    #echo $linie
    #sed -i "/$linie/d" users.csv
    #sed -i "/$user/d" nume.csv
    sed -i "/$user/d" logged_in.csv
}
remove_account() {
    local user="$1"
    echo $user
    cd $file_path
    linie=$(grep -F ",$user," users.csv)
    echo $linie
    sed -i "/$linie/d" users.csv
    sed -i "/$user/d" nume.csv
    sed -i "/$user/d" logged_in.csv
}

logout() {
    echo "Logout user"
    local user="$(pwd)"
    user="${user#*users/}"
    user="${user%%/*}"
    if [[ user != "" ]]; then
        cd "$file_path"
        remove_user $user
    fi
}
logged_in_users=()
login(){
    #daca exista user-ul, apelezi o functie aplicatie, unde poate sa genereze raport doar pentru el
    cd $file_path
    echo "Introduceti email"
    read email
    while (! grep -Fq "$email" "users.csv"); do
        echo "Mailul $email nu exista, introduceti altul"
        read email
    done

    linie=$(grep "$email" "users.csv")
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
        echo $nume >> logged_in.csv
        logged_in_users+=("$nume")
        echo "Te-ai logat cu succes, ultima logare a fost actualizata"
        cd "./users/$nume/home/"
            
    else
        echo "Parola introdusa este gresita"
    fi
}
