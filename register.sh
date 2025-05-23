#!/bin/bash


finduser() {
str="$1"
if grep -q $str users.csv; then
return 0
fi
return 1
}
findname() {
str="$1"
if grep -q $str nume.csv; then
return 0
fi
return 1
}



register() {
 echo "Vei introduce, in ordinea urmatoare, email, parola, nume utilizator"
 echo "Introdu email-ul tau: "
 read email
 while finduser "$email"; do
 echo -e "Acest cont deja exista, pentru iesit tastati exit\n"
 read email
 if [[ $email == "exit" ]]; then
  return
 fi
 done

 echo "Introdu parola"
 read parola
 #crypting
 parola=$(echo -n "$parola" | sha256sum | cut -d' ' -f1)

#citim nume
echo "Introdu numele tau de utilizator"
 read nume
while findname "$nume"; do
 echo -e "Numele deja exista, introdu alt nume\nPentru iesit tastati exit"
 read nume
 if [[ $nume == "exit" ]]; then
   return
 fi
done
 echo $nume >> nume.csv
 id=$(cat users.csv | wc -l)
id=$((id + 1))
 str="$id,$nume,$email,$parola"
 echo $str >> users.csv

 cd users
 if [[ ! -d "$nume" ]]; then
  mkdir "$nume"
  cd "$nume"
  mkdir "home"
  cd "home"
 else
  cd "$nume/home"
 fi
echo "Inregistrare efectuata"

}
