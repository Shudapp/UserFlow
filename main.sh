#!/bin/bash




main(){

if [[ ! -f users.csv ]]; then
 touch users.csv
fi


source register.sh
source login.sh
source report.sh


FM="Welcome !\n 1.Register\n 2.Login\n 3.Report\n 4.Help\n"


echo -e $FM

read text
text=${text,,}
if [[ $text == "1" || $text == "register" || $text == "inregistreaza" ]]; then
    echo "Te inregistrezi"
    register
elif [[ $text == "2" || $text == "login" || $text == "logheaza" ]]; then
    echo "Te loghezi"
    login
elif [[ $text == "3" || $text == "Report" || $text == "Raport" ]]; then
    echo "Genereaza raport"
    report
else
   main
fi


}



main
