#!/bin/bash
#Script By Mohammad Fauzan R (fauzan121998@gmail.com) (0895703796928)
if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# cek ip
vps="mfauzan";
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
wget -q -O mfauzan https://raw.githubusercontent.com/mfauzan199812/Deb1/master/ip.txt
if ! grep -w -q $MYIP mfauzan; then
	echo "Maaf, hanya IP yang terdaftar yang bisa menggunakan script ini!"
	if [[ $vps = "mfauzan" ]]; then
		echo "Hubungi: Mohammad Fauzan R atau (0895703796928)"
	else
		echo "Hubungi: Mohammad Fauzan R atau (0895703796928)"
	fi
	rm /root/mfauzan
	rm -f /root/mfauzan
	exit
fi
MYIP=$(wget -qO- ipv4.icanhazip.com)

echo "---------------------- HAPUS AKUN SSH & OVPN -----------------------" | lolcat
echo "          DEVELOPED BY Mohammad Fauzan R (0895703796928)            " | lolcat
echo ""

# begin of user-list
echo "-----------------------------------" | lolcat
echo "USERNAME              EXP DATE     " | lolcat
echo "-----------------------------------" | lolcat

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo "-----------------------------------" | lolcat
echo ""
# end of user-list

read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p "Apakah Anda benar-benar ingin menghapus akun [$username] [y/n]: " -e -i y REMOVE
	if [[ "$REMOVE" = 'y' ]]; then
		passwd -l $username
		userdel $username
		echo ""
		echo "Akun [$username] berhasil dihapus!"
	else
		echo ""
		echo "Penghapusan akun [$username] dibatalkan!"
	fi
else
	echo "Username [$username] belum terdaftar!"
	exit 1
fi
