#!/bin/bash

#date
file_path=$(pwd)
numeglobal=""
logat=0
#functii
get_user(){
    local user="$(pwd)"
    user="${user#*users/}"
    user="${user%%/*}"
    echo $user
}
clearusers(){
    cd $file_path
    rm users.csv
    touch users.csv
    rm nume.csv
    touch nume.csv
    rm logged_in.csv
    touch logged_in.csv
    rm -r users
    mkdir users
    echo "Users si nume sters!"
}

main(){

    if [[ ! -f users.csv ]]; then
        touch users.csv
    fi

    if [[ ! -f nume.csv ]]; then
        touch nume.csv
    fi

    if [[ ! -d users ]]; then
        mkdir users
    fi
    if [[ ! -f logged_in.csv ]]; then
        touch logged_in.csv
    fi

    source $file_path/register.sh
    source $file_path/login.sh
    source $file_path/report.sh

    FM="Welcome !\n 1.Register\n 2.Login\n 3.Report\n 4.Help\n 5.Exit\n"


    echo -e $FM

    read text
    text=${text,,}

    if [[ $text == "clearusers" ]]; then
        clearusers
    fi
    touch comenzi.log
    echo $text >> comenzi.log
    if [[ $text == "1" || $text == "register" || $text == "inregistreaza" ]]; then
        echo "Te inregistrezi"
        register
        numeglobal=$(tail -n 1 $file_path/logged_in.csv)
        logat=1
    elif [[ $text == "2" || $text == "login" || $text == "logheaza" ]]; then
        echo "Te loghezi"
        login
        numeglobal=$(tail -n 1 $file_path/logged_in.csv)
        logat=1
    elif [[ ( $text == "3" || $text == "report" || $text == "raport" ) && ( $logat -eq 1 ) ]]; then
        echo "Genereaza raport"
        user=$(echo $text | cut -d' ' -f2)
        if [[ ("$user" == "$text") && ("$numeglobal" != "") ]]; then
            report $numeglobal
        elif [[ "$numeglobal" == "admin" ]]; then
            report $user
        else
            echo "Raport invalid"
        fi
    elif [[ $text == "4" || $text == "help" ]]; then
        echo -e "Ajutor:\n 1 sau 'register'–inregistrare\n 2 sau 'login'–autentificare\n 3 sau 'report'–genereaza raport (dupa login)\n 4 sau 'help'–afiseaza acest mesaj\n 5 sau 'exit'-iese din script"

    elif [[ $text == "5" || $text == "exit" ]]; then
        exit 0
    else 
        echo "Comanda gresita"
    fi

    #echo $file_path
}



main
