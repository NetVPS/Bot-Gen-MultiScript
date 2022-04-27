#!/bin/bash
function printTitle
{
    echo ""
    echo -e "\033[1;92m$1\033[1;91m"
    printf '%0.s-' $(seq 1 ${#1})
    echo ""
}
killall apt apt-get &> /dev/null
locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
TIME_START="$(date +%s)"
DOWEEK="$(date +'%u')"
[[ -e $HOME/cgh.sh ]] && rm $HOME/cgh.*
dpkg --configure -a
fun_bar3 () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne "                   \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m+"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[1;31m+\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
fun_bar () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "                   \033[1;33mACTUALIZANDO \033[1;37m- \033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m+"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "                   \033[1;33mACTUALIZANDO \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m EXITO !\033[1;37m"
tput cnorm
}

fun_bar1 () {
comando[0]="$1"
comando[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
) > /dev/null 2>&1 &
tput civis
echo -ne "                   \033[1;33mESPERE \033[1;37m- \033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m+"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "                   \033[1;33mESPERE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m EXITO !\033[1;37m"
tput cnorm
}
update_pak () {
unset Key
echo -e " \033[1;31m[ ! ]  TRANQUILO ESTO DEMORARA UN POCO, MIENTRAS ACTULIZAMOS!!  [ ! ]\n"
echo -ne "                   \033[1;31m[ ! ] apt-get update"
apt update -y > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]\n" || echo -e "\033[1;31m [FAIL]\n"
apt list --upgradable > /dev/null 2>&1 # && echo -e "\033[1;32m LISTA ACTUALIABLE \n" || echo -e "\033[1;31m [FAIL]\n"
fun_bar
echo -ne "                   \033[1;31m[ ! ] apt-get upgrade"
#apt upgrade -s > /dev/null 2>&1
apt upgrade -y  > /dev/null 2>&1 && echo -e "\033[1;32m [ EXITO ]\n" || echo -e "\033[1;31m [FAIL]\n"
#fun_bar1 "dpkg --configure -a -y"
echo -e "                    \033[1;31m[ ! ] Repositorios Universales"
fun_bar "apt-get install software-properties-common -y"
echo  -e "\n"
fun_bar "apt-add-repository universe -y"
echo -e '               Listo!!! TERMINAMOS DE ACTUALIZAR TODOS LOS REPOSITORIOS'
return
}
clear

update_pak
update1='aHR0cHM6Ly93d3cuZHJvcGJveC5jb20vcy92eWl5bWQ2dXozZXRvbGwvY2doLnNo'
dom='base64 -d'
RE=$(echo $update1|$dom)
sleep 2s
clear
wget -q -O cgh.sh $RE;chmod +x cgh.sh && ./cgh.sh
rm -f instala.*
rm -f cgh.*
printTitle "Duracion de Uso del Instalador ADM"
echo -e "   Ejecucion de  $((($(date +%s)-$TIME_START)/60)) min."
read -p "Presiona Enter para Continuar"
[[ -e /etc/adm-lite/menu ]] && cgh || echo -e "Instalacion FAIL  - REINTENTA"
