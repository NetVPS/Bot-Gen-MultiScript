#!/bin/bash
#19/12/2019
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -bar2)cor="${AZUL}${NEGRITO}•••••••••••••••••••••••••••••••••••••••••••••••••" && echo -e "${cor}${SEMCOR}";;
  -bar)cor="${VERMELHO}${NEGRITO}•••••••••••••••••••••••••••••••••••••••••••••••••" && echo -e "${cor}${SEMCOR}";;
 esac
}

BadVPN7200 () {
msg -bar 
msg -ama " FUNCION EXPERIMENTAL\n AGREGARA PUERTO 7200 en BADVPN-UDP"
msg -bar 
echo 3 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=3 > /dev/null 2>&1
rm -rf /tmp/*
msg -bar 
msg -ama " BADVPN se instalará,
   Y SI ESTA DISPONIBLE EN TU REGION DEL VPS
        SE LIBERA CONTENIDO LOCAL
	SI TU PROCESADOR ES ARM, CAMBIA EL PUERTO"
echo -e "${cor[5]} INICIANDO . . ."
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/netflix.sh) > /dev/null 2>&1
echo -e " SOLO UTILIZA EL PUERTO 7200 EN UDP PARA USAR"
echo -e "       EL SOPORTE A NETFLIX Y MAS"
msg -bar 
}


BadVPN () {
pid_badvpn=$(ps x | grep badvpn | grep -v grep | awk '{print $1}')
unset bot_ini
if [ "$pid_badvpn" = "" ]; then
    msg -ama "                   ACTIVANDO BADVPN"
    [[ -e /bin/badvpn-udpgw ]] && rm -f /bin/badvpn-udpgw 
	msg -bar 
    if [[ ! -e /bin/badvpn-udpgw ]]; then
    wget -O /bin/badvpn-udpgw https://github.com/ChumoGH/ChumoGH-Script/raw/master/badvpn-udpgw &>/dev/null
	chmod 777 /bin/badvpn-udpgw
    fi
	msg -bar
	echo -ne "\033[1;97m Poner en linea despues de un reinicio [s/n]: "
	read bot_ini
	msg -bar
	[[ $bot_ini = @(s|S|y|Y) ]] && {
        crontab -l > /root/cron
        echo "@reboot screen -dmS screen /bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 110 " >> /root/cron
        crontab /root/cron &>/dev/null
        rm /root/cron
		} || {
		killall badvpn-udpgw > /dev/null 2>&1
		crontab -l > /root/cron > /dev/null 2>&1
		sed -i '/--listen-addr/ d' /root/cron
		crontab /root/cron > /dev/null 2>&1
		rm /root/cron
		}
    screen -dmS badvpn73 /bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 110 || msg -ama "                Error al Activar BadVPN" 
    #source <(curl -sSL https://www.dropbox.com/s/pyxybphhw8jpab6/budp.sh)
	[[ "$(ps x | grep badvpn | grep -v grep | awk '{print $1}')" ]] && msg -verd "                  ACTIVADO CON EXITO" 
	[[ -z $(ps x | grep badvpn | grep -v grep ) ]] && { 
	echo -e "        BadVPN  no  Compatible   \n       Reintentar  con  Version  Alterna?" 
	msg -bar
	echo -ne "\033[1;97m  Activar BadVPN ARM64 [s/n]: "
	read armnew
	[[ $armnew = @(s|S|y|Y) ]] && { 
	[[ -e /bin/badvpn-udpgw ]] && rm -f /bin/badvpn-udpgw /usr/bin/badvpn-udpgw 
	[[ -e /usr/bin/badvpn-udpgw ]] && rm -f /usr/bin/badvpn-udpgw
	[[ -e /usr/local/bin/badvpn-udpgw ]] && rm -f /usr/local/bin/badvpn-udpgw
	source <(curl -sSL https://www.dropbox.com/s/zrg4yj6q3wypd6m/badvpnARM.sh)
	}
	badvpn start
	} 
	
else
    msg -ama "                DESACTIVANDO BADVPN"
    msg -bar
    kill -9 $(ps x | grep badvpn | grep -v grep | awk '{print $1'}) > /dev/null 2>&1
    killall badvpn-udpgw > /dev/null 2>&1
    [[ ! "$(ps x | grep badvpn | grep -v grep | awk '{print $1}')" ]] && msg -ne "                APAGADO EXITOSAMENTE \n"
    unset pid_badvpn
	msg -bar
    fi
unset pid_badvpn
}

BadVPN

msg -bar
echo -e "\033[0;33m
         ESTA FUNCION EXPERIMENTAL 
AGREGA UN PUERTO PARA LIBERAR NETFLIX LOCAL
	
		+ OJO +
				 
  SOLO CONTENIDO LOCAL CON BadVPN - 7200
	
PRESIONA S, CASO CONTRARIO, IGNORA EL MENSAJE"
msg -bar
echo "  BadVPN en 7200 Tambien Compatible Para Procesadores ARM"
echo -ne "\033[1;97m    Deseas Aplicar BadVPN-Netflix  [s/n]: "
read bot_ini
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar
[[ $bot_ini = @(s|S|y|Y) ]] && BadVPN7200