#!/bin/bash
file_path=$(pwd)
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


source register.sh
source login.sh
source report.sh


FM="Welcome !\n 1.Register\n 2.Login\n 3.Report\n 4.Help\n"


echo -e $FM

read text
text=${text,,}
check=$(echo "$text" | cut -d' ' -f1)
nume=$(echo "$text" | cut -d' ' -f2)
if [[ $text == "clearusers" ]]; then
 echo > users.csv
 echo > nume.csv
 echo "Users si nume sters!"
fi
if [[ $text == "1" || $text == "register" || $text == "inregistreaza" ]]; then
    echo "Te inregistrezi"
    nume="$(register)"
    #id=(find_id "$nume")
elif [[ $text == "2" || $text == "login" || $text == "logheaza" ]]; then
    echo "Te loghezi"
    nume="$(login)"
    id=(find_id "$nume")
elif [[ $text == "3" || $text == "Report" || $text == "Raport" ]]; then
    echo "Genereaza raport"
    if [[ $nume != "null"  && $nume != $check ]]; then
        id=$(find_id $nume)
        report $id
    else
        echo -e "Raport nul, incearca din nou\n"
    fi
fi
main

}



main
