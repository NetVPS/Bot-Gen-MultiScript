#!/bin/bash
#Instalador del BOT
coo=1
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
#[[ -e /etc/http-instas ]] && 

add-apt-repository universe
apt update -y; apt upgrade -y

fun_a(){
texto=`if netstat -tunlp |grep apache2 1> /dev/null 2> /dev/null; then
echo -e "ON"
else
echo -e "OFF"
fi`;
if [[ $texto = "ON" ]];then
echo "Apache2 Instalado y Activo"
#sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
#service apache2 restart > /dev/null 2>&1
else
#apache2
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 }
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install apache2......... $ESTATUS "

fi
}


install_ini () {
clear
echo -e "$BARRA"
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
echo -e "$BARRA"
ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
echo -e "\033[97m  # Instalando  UTF...................... $ESTATUS "
apt-get install gawk -y > /dev/null 2>&1
#bc
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
apt-get install bc -y &>/dev/null
apt-get install screen -y &>/dev/null
apt-get install nano -y &>/dev/null
apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#netcat-traditional
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || apt-get install netcat-traditional -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat-traditional... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install cowsay............... $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
#lolcat
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install lolcat............... $ESTATUS "
#PV
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] || apt-get install pv -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install PV   ................ $ESTATUS "
fun_a

echo -e "$BARRA"
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
echo -e "$BARRA"
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}

msg () {
local colors="/etc/new-adm-color"
if [[ ! -e $colors ]]; then
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[91m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
else
local COL=0
for number in $(cat $colors); do
case $number in
1)COLOR[$COL]='\033[1;37m';;
2)COLOR[$COL]='\e[31m';;
3)COLOR[$COL]='\e[32m';;
4)COLOR[$COL]='\e[33m';;
5)COLOR[$COL]='\e[34m';;
6)COLOR[$COL]='\e[35m';;
7)COLOR[$COL]='\033[1;36m';;
esac
let COL++
done
fi
NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)ccor="${COLOR[1]}${NEGRITO}" && echo -ne "${ccor}${2}${SEMCOR}";;
  -ama)ccor="${COLOR[3]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verm)ccor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verm2)ccor="${COLOR[1]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -azu)ccor="${COLOR[6]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -verd)ccor="${COLOR[2]}${NEGRITO}" && echo -e "${ccor}${2}${SEMCOR}";;
  -bra)ccor="${COLOR[0]}${SEMCOR}" && echo -e "${ccor}${2}${SEMCOR}";;
  -bar2)ccor="${COLOR[1]}◈ ━━━━━━━━━━━━━━ 🪐 - 🪐 ━━━━━━━━━━━━━━━ ◈" && echo -e "${SEMCOR}${ccor}${SEMCOR}";;
  -bar)ccor="${COLOR[1]}•••••••••••••••••••••••••••••••••••••••••••••••••" && echo -e "${SEMCOR}${ccor}${SEMCOR}";;
  
 esac
}

check_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
function_verify () {
unset keybot
#github="https://raw.githubusercontent.com"
echo -e "\033[7;49;35m    =====>>►► 🐲 GEN ChumoGH💥VPS 🐲 ◄◄<<=====      \033[0m"
msg -bar
# [[ "$(echo "$(cat < /etc/nivbot)")" < "3" ]] && {
# [[ -e /bin/downloadbot ]] && {
# [[ -z $(cat < /bin/downloadbot) ]] && read -p " Ingresa tu Key de Autorizacion : " keybot || unset keybot
# } 
# } || read -p " Key de Autorizacion : " keybot 
# [[ -z $keybot ]] && {
# [[ -e /bin/downloadbot ]] && link="$(cat < /bin/downloadbot)" || link='https://raw.githubusercontent.com'
# [[ $link = 'https://raw.githubusercontent.com' ]] && echo "CONTROL MEDIANTE GitHub" || echo "CONTROL EXTERNO"
# permited=$(curl -sSL "${link}/NetVPS/Bot-Gen-MultiScript/main/Control-IP") 
# } || {
# permited=$(curl -sSL "$(ofus $keybot)/NetVPS/Bot-Gen-MultiScript/main/Control-IP")
# [[ -z $keybot ]] && echo $link > /bin/downloadbot  || echo -e "$(ofus $keybot)" > /bin/downloadbot 
# }
permited=$(curl -sSL "https://raw.githubusercontent.com/NetVPS/Bot-Gen-MultiScript/main/Control-IP") 
 [[ $(echo $permited|grep "${IP}") = "" ]] && {
  clear
  echo -e "\n\n"
  msg -bar
  echo -e "\n"
  echo -e "\e[31m      ¡LA IP $(wget -qO- ipv4.icanhazip.com) FUE RECHAZADA!"
  echo -e " $link No AUTORIZADA el ACCESO "
  echo -e " SI DESEAS USAR EL BOTGEN CONTACTE A @ChumoGH"
  echo -e "\e[31m=====================================================\n\n\n\e[0m"
  [[ -e "/bin/ShellBot.sh" ]] && rm /bin/ShellBot.sh
  [[ -e /bin/downloadbot ]] && rm -f /bin/downloadbot
  echo -e "\n"
  msg -bar
    exit 1
  } || {
 ### INTALAR VERCION DE SCRIPT
 clear
  echo -e "\n\n\n\e[32m====================================================="
  echo -e "\e[32m     ¡LA IP $(wget -qO- ipv4.icanhazip.com) ESTA AUTORIZADA!"
  echo -e "   Mediante $link Autorida por @ChumoGH"
  echo -e "      SI DESEAS USAR EL BOTGEN CONTACTE A @ChumoGH"
  echo -e "\e[32m=====================================================\n\n\n\e[0m"
  v1=$(curl -sSL "https://www.dropbox.com/s/blxo0jifysvyrey/v-new.log")
  [[ ! -e /bin/downloadbot ]] && {
  [[ $link = 'https://raw.githubusercontent.com' ]] && echo "https://raw.githubusercontent.com" > /bin/downloadbot || echo "$(ofus $keybot)" > /bin/downloadbot
  chmod +x /bin/downloadbot
  }
  [[ -e /etc/nivbot ]] && { 
  i=$(cat < /etc/nivbot)
  lv=$(($i+1))
  echo $lv > /etc/nivbot
  } || echo "1" > /etc/nivbot
  echo $Key > /etc/valkey && chmod +x /etc/valkey
  [[ -e /usr/bin/lst ]] || echo 'https://www.dropbox.com/s/g4zqgr3dwgj0f1g/lista?dl=0' > /usr/bin/lst && chmod 777 /usr/bin/lst
  }
}

[[ ! -e /etc/http-instas ]] && echo '0' > /etc/http-instas || let sd=$(cat < /etc/http-instas)-$coo && echo $sd > /etc/http-instas
[[ -d $SCPT_DIR ]] && rm -rf $SCPT_DIR
SCPresq="aHR0cHM6Ly93d3cuZHJvcGJveC5jb20vcy9wNXYyaGV2cmZqM3BkeGIv"
SUB_DOM='base64 -d'
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
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
while true; do
for((i=0; i<18; i++)); do
echo -ne "\033[1;31m≛"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[1;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m EXITO !\033[1;37m"
tput cnorm
}
update_pak () {
permited=$(ofus $(curl -sSL "https://www.dropbox.com/s/5qjgvuiaodacasu/passwd"))
return
}
clear
update_pak

#CORES
cor[1]="\033[1;36m"
cor[2]="\033[1;32m"
cor[3]="\033[1;31m"
cor[4]="\033[1;33m"
cor[0]="\033[1;37m"

#TEXTOS
txt[206]="Archivito(s) Actualizado(s)!"
txt[208]="Invalid Key, Contact the Script Admin!"
txt[207]="Valid!!!"
txt[203]="☹"
txt[204]="㋡--->"
txt[205]="Actualizado"

#COMPARA
fun_filez () {
fup="$HOME/update"
echo "$1" >> $HOME/files.log
[[ $1 = 'http-server.py' ]] && mv -f ${fup}/$1 /bin/http-server.sh && chmod +x /bin/http-server.sh
[[ -e $1 ]] && mv -f ${fup}/$1 /etc/SCRIPT/$1
#[[ "$1" = "gerar.sh" ]] && mv -f ${fup}$1 /bin/http-server.sh && chmod +x /bin/http-server.sh
}


clear
rm $(pwd)/$0 > /dev/null 2>&1 && echo -e "\e[32m- \033[1;32mExito!" || echo -e "\033[1;31m- \033[1;31mFallo"
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}

DOWS () {
wget --no-check-certificate -i $HOME/lista-arq
}

function aguarde() {
	sleep 1
	fun_ejec=$1
	helice() {
		DOWS >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m TRASLADANDO FILES \033[1;32mSCRIPT \033[1;37me \033[1;32mAUTOGEN\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1D REALIZADO"
}

atualiza_fun () {
msg -bar
[[ -d ./update ]] && rm -rf ./update/* || mkdir ./update
cd ./update/
aguarde
unset arqs
n=1
rm -f $HOME/files.log
for arqs in `ls $HOME/update`; do
echo -ne "\033[1;33m FILE \e[32m [${n}.gen] \e[0m "
fun_filez $arqs > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;31m $arqs (no Trasladado!)" || echo -e "\033[1;31m- \033[1;32m $arqs Trasladado!"
n=$(($n + 1))
done
cd $HOME
  [[ -e $HOME/lista ]] && rm $HOME/lista
  [[ -d $HOME/update ]] && rm -rf $HOME/update
[[ "$lista_atualizados" != "" ]] && echo -e "${cor[5]} $lista_atualizados ${txt[206]}"
}

veryfy_fun () {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
unset ARQ
case $1 in
"gerar.sh")
ARQ="/usr/bin/";;
"http-server.py")
ARQ="/bin/";;
*)ARQ="${SCPT_DIR}/";;
esac
mv -f /update/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

unset Key
install_ini
clear
check_ip
function_verify #-----------------------------------------------------------------------------------------------------
 msg -bar
echo -e "\033[1;36m  # ☆ KEY GENERATOR BY @ChumoGH ☆ # \033[0m"
 msg -bar
 echo -e " \nPara Finalizar, Solo agrega tu Nombre, o IP \n"
 msg -bar
read -p "Ingrese Su Hostname/IP : " Key
[[ -z $Key ]] && Key="@ChumoGH"
#[[ $permited = $Key ]]
msg -bar
[[ ! $Key ]] && {
 msg -bar
echo -e "\033[1;33mKey inválida! llamame "
unset key > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mExito!" || echo -e "\033[1;31m- \033[1;31mFallo" > error.log
figlet " Key Fail" | boxes -d stone -p a2v1 > error.log
#cowsay  "☆ChumoGH☆ $(source trans -b pt:${id} "ADM SCRIPT Te agradece por preferirnos, pero desafortunadamente tu Key es INVALIDA")" > error.log
echo "$(source trans -b pt:${id} " Utiliza otro Key, O Reintenta con la misma!")" >> error.log
echo " =============================================" >> error.log
echo "   Error con Generador - Port : 81 - 8888" >> error.log
echo " =============================================" >> error.log
echo "$(source trans -b pt:${id} " Key Invalida, Contacta con el Desarrolador")" >> error.log
echo "$(source trans -b pt:${id} "  ● Compra Keys al +593987072611 ")" >> error.log
echo "$(source trans -b pt:${id} "  ● BOT Telegram @ChumoGH_bot ")" >> error.log
echo -e ' t.me/ChumoGH  - @ChumoGH' >> error.log
echo " =============================================" >> error.log
cat error.log | lolcat
killall bash > /dev/null
msg -bar2
exit
}

echo -e "\033[1;33m VERIFICANDO KEY DE ACCESO . . . .  " | pv -qL 20
wget --no-check-certificate -q -O $HOME/lista-arq "$(cat < /usr/bin/lst)" && echo -e "\033[1;33m Key Verificada!! "
echo "$Key" > /etc/valkey && chmod +x /etc/valkey

meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}

meu_ip


[[ -e $HOME/lista-arq ]] && {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ -d /etc/SCRIPT ]] && rm -rf /etc/SCRIPT/* || mkdir /etc/SCRIPT
[[ -d /bin/ejecutar ]] && rm -f /bin/ejecutar/echo-ram.sh || mkdir /bin/ejecutar
cd 
atualiza_fun
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR2
rm $HOME/lista-arq
wget --no-check-certificate -O /etc/SCRIPT/gerar.sh -q https://www.dropbox.com/s/25g993sfwayphr8/menu-gerar.sh && chmod +x /etc/SCRIPT/gerar.sh
echo 'cd /etc/SCRIPT && ./gerar.sh' > /usr/bin/gerar
echo 'source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/free-men.sh)' > /bin/ejecutar/echo-ram.sh
echo 'wget -q -O /bin/ejecutar/v-new.log https://www.dropbox.com/s/8tizr516cvkwss6/v-new.log?dl=0' >> /bin/ejecutar/echo-ram.sh && bash /bin/ejecutar/echo-ram.sh
chmod +x /bin/ejecutar/echo-ram.sh && bash /bin/ejecutar/echo-ram.sh
wget --no-check-certificate -q -O /var/www/html/index.html https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/html/index.html
chmod +x /usr/bin/gerar
echo "cd /etc/SCRIPT && ./gerar.sh" > /usr/bin/keygen && chmod +x /usr/bin/keygen
echo -e "\033[1;33m Perfecto, utilize el comando \033[1;31mkeygen o gerar \033[1;33mpara administrar sus keys y
 actualizar la base del servidor"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e " Recuerda Generar 1 Key manual, luego de terminar la Instalacion "
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey ACCESIBLE!" $1
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
} || {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey inválida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
}
echo "qra-atsilK%95@@978c@6@be9K8888:%%?+?5@+69+%" > /etc/key-gerador
echo -ne "\033[0m" 
