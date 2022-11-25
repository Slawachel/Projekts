#!/bin/env bash
echo " What you want to do?"
select task in ADDUserGroup ADDKatUser DELUser EXIT
do
case $task in
ADDUserGroup)

#awk -F: '$3 ~ /1[0-9][0-9][0-9]/ {print $1;}'/etc/group
read -p "Wybierz grupe podstawowa dla nowego użytkownika"  group
groupadd $group
read -p "Wybierz nazwe nowego użytkownika" user
useradd -m -N -g  $group $user
read -p "Wybierz Hasło nowego użytkownika" pswd
chpasswd<<< "$user:$pswd"
# [[ $? == 0 ]] && echo "Uzytkownik utworzony" && exit 0
;;
ADDKatUser)
read -p "Tworzenie katlogu  " katalog
mkdir -p "/home/$katalog"
read -p "Która użytkownik może edytować nowy katalog  " useremd
read -p "Która grupa użytkowników może odczytać nowy katalog  " grupemd
#echo " $useremd:$grupemd home/$katalog/"
chown aira:aira "/home/$katalog/"


chown $useremd:$grupemd "/home/$katalog/"
chmod -R 750 "/home/$katalog/"
#chmod -R u=rwx
#chmod -R g=wx

#exit 0
;;
DELUser)
read -p "Wybierz nazwe uzytkownika do usuniencia" user
userdel -r $user
#[[ $? ==0 ]] && echo "Uzytkownik usuniety" && exit 0
;;
EXIT)
echo "by!"
 exit 0
;;
*)
echo "Erorr!";;
esac
done


