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
 rm users.csv
 touch users.csv
 rm nume.csv
 touch nume.csv
 rm logged_in.csv
 touch logged_in.csv
 rm -r users
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

FM="Welcome !\n 1.Register\n 2.Login\n 3.Report\n 4.Help\n"


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
elif [[ ( $text == "3" || $text == "Report" || $text == "Raport" ) && ( $logat -eq 1 ) ]]; then
    echo "Genereaza raport"
    user=$(echo $text | cut -d' ' -f2)
    if [[ ("$user" == "$text") && ("$numeglobal" != "") ]]; then
        report $numeglobal
    elif [[ "$numeglobal" == "admin" ]]; then
        raport $user
    else
        echo "Raport invalid"
    fi
fi

#echo $file_path
}



main
