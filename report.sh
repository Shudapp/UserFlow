

report() {

#Aici introduci codul !!!
help="Lista de comenzi:\n 1.report nume\n 2.raport nume\n 3.nume\n"
read comanda
if [[ $comanda == "-help" || $comanda == "help" ]]; then
 echo -e $help
 report
fi
#verifici daca user-ul are login de admin, daca il are, atunci poate sa genereze orice raport folosind comanda 
#report nume sau raport nume DACA NU ARE, atunci poate doar sa foloseasca numele lui, adica trebuie sa cauti
#numele lui, dupa report sau raport, ai 1000 de moduri in care sa faci asta, dar ai grija sa fie error prone
#raport-ul e ce vrei tu, fie generezi data cand s-a logat si adaugi la login acolo un timestamp,
#fie adaugi numarul de comenzi puse cu un contor acolo de fiecare data cand s-a apelat o comanda
#adica bagi o variabila cnt in main pe care o cresti de fiecare data cand face user-ul ceva, si o updatezi
#CREATIVITATE!!!!!!!!!!!!!!!

}
