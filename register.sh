#!/bin/bash


finduser() {
str="$1 $2"
if grep -q $str users.csv; then
return 1
fi
return 0
}
findname() {
str="$1"
if grep -q $str nume.csv; then
return 0
fi
return 1
}



register() {
 echo "Vei introduce, in ordinea urmatoare, Numele din aplicatie, Numele pentru login, Parola"
 echo "Introduce numele tau: "
 read name
 while findname "$name"; do
 echo -e "Nume folosit deja\n"
 read name
 done
 echo $name >> nume.csv
 #verifica daca exista deja numele
 echo "Introduce username-ul"
 read user
 echo $user >> users.csv
 echo "Introduce parola"
 read parola
 #crypting
 #verifica daca exista deja contul


}
