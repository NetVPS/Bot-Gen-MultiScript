#!/bin/bash
#by la casita del terror

#COLORES
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
rst="$(tput sgr0)"


fun_bar () {
#==comando a ejecutar==
comando="$1"

#==interfas==
in='['
en=']'
full_in=">>"
full_en='100%'

bar=( Xoooooooooooooooooooo
o-Xoooooooooooooooooo
oo-Xooooooooooooooooo
ooo-Xoooooooooooooooo
oooo-Xooooooooooooooo
ooooo-Xoooooooooooooo
oooooo-Xooooooooooooo
ooooooo-Xoooooooooooo
oooooooo-Xooooooooooo
ooooooooo-Xoooooooooo
oooooooooo-Xooooooooo
ooooooooooo-Xoooooooo
oooooooooooo-Xooooooo
ooooooooooooo-Xoooooo
oooooooooooooo-Xooooo
ooooooooooooooo-Xoooo
oooooooooooooooo-Xooo
ooooooooooooooooo-Xoo
oooooooooooooooooo-Xo
ooooooooooooooooooo-X
ooooooooooooooooooX-o
oooooooooooooooooX-oo
ooooooooooooooooX-ooo
oooooooooooooooX-oooo
ooooooooooooooX-ooooo
oooooooooooooX-oooooo
ooooooooooooX-ooooooo
oooooooooooX-oooooooo
ooooooooooX-ooooooooo
oooooooooX-oooooooooo
ooooooooX-ooooooooooo
oooooooX-oooooooooooo
ooooooX-ooooooooooooo
oooooX-oooooooooooooo
ooooX-ooooooooooooooo
oooX-oooooooooooooooo
ooX-ooooooooooooooooo
oX-oooooooooooooooooo
OOOOOOOOOOOOOOOOOOOOO );
#==color==
in="\033[1;33m$in\033[0m"
en="\033[1;33m$en\033[0m"
full_in="\033[1;31m$full_in"
full_en="\033[1;32m$full_en\033[0m"

 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
	for i in "${bar[@]}"; do
		echo -ne "\r $in"
		echo -ne " INSTALANDO ] [ \033[1;31m$i "
		echo -ne "$en"
		sleep 0.2
	done
done
echo -e " $full_in $full_en"
sleep 1s
}
clear
if [[ -e /etc/1004 ]]; then
exit
else
echo -e "\n\n\t$red INSTALALANDO COMPLEMENTOS\n\n$srt"
fun_bar 'sudo apt install build-essential make autoconf -y'
fun_bar 'sudo apt install bison -y'
fun_bar 'sudo add-apt-repository ppa:neurobin/ppa -y'
fun_bar 'sudo apt install gcc -y'
fun_bar 'sudo apt install flex -y'
fun_bar 'sudo apt install byacc -y'
fun_bar 'sudp apt install autoconf -y'
fun_bar 'sudo apt install git -y'
cd /tmp/
wget https://ftp.gnu.org/gnu/automake/automake-1.16.tar.gz > /dev/null 2>&1
tar -xzvf automake-1.16.tar.gz > /dev/null 2>&1
cd automake-1.16
./configure > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1
fun_bar 'sleep 1s'
cd /tmp/
wget http://www.datsi.fi.upm.es/~frosal/sources/shc-3.8.7.tgz > /dev/null 2>&1
tar -xvzf shc-3.8.7.tgz > /dev/null 2>&1
cd shc-3.8.7
make > /dev/null 2>&1
echo -e "$blue"
read -p "PRESIONA ENTER PARA CONTINUAR: " 
echo -e "$srt"
echo -e "\n$cyan ESCRIBE (${yellow}yes$cyan) CUANDO SALGA LA LEYENDA\n[$red Do you want to continue?]\n\n$srt"
make install 
cd /tmp/
rm -rf shc-3.8.7 > /dev/null 2>&1
fun_bar 'sleep 1s'
git clone https://github.com/neurobin/shc.git > /dev/null 2>&1
cd shc
./configure > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1
touch /etc/1004
fun_bar 'sleep 1s'
cd $HOME
rm -rf automake-1.16.tar.gz
rm -rf automake-1.16
rm -rf shc-3.8.7.tgz
rm -rf shc-3.8.7
rm -rf shc
rm -rf /etc/1004
fi
rm -rf automake-1.16.tar.gz
rm -rf automake-1.16
rm -rf shc-3.8.7.tgz
rm -rf shc-3.8.7
rm -rf shc
rm -rf /etc/1004
exit