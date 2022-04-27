#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH
barra="≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×≠×"
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
rootpass () {
clear
[[ "$(whoami)" != "root" ]] && {
	clear
	echo -e "\033[1;31mEXECULTE COMO USUARIO ROOT, \033[1;32m(\033[1;33msudo -i\033[1;32m)\033[0m"
	exit
}
unset yesno
echo -e "\033[7;49;35m    =====>>►► 🐲 New ChumoGH💥VPS 2022 🐲 ◄◄<<=====      \033[0m"
msg -bar
echo -e "${cor[5]} ESTA HERRAMIENTA LIBERA ACCESO root EN VPS "
echo -e "${cor[4]}    ESPECIAL PARA (AWS,GOOGLE,AZURE,ETC)
PRESIONA S, CASO CONTRARIO, PRESIONA N"
echo -ne "\033[1;32m   ESTAS SEGURO? [S/N]: "; read yesno
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
#Parametros Aplicados
echo " RESPALDANDO AJUSTES PREVIOS "
echo '#######CONFIG NATURAL' >> /bin/ejecutar/sshd_config
cat /etc/ssh/sshd_config >> /bin/ejecutar/sshd_config
#Inicia Procedimentos
echo -e "\033[1;33mAPLICANDO CONFIGURACIONES"
fun_bar
[[ $(grep -c "prohibit-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/prohibit-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "without-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PermitRootLogin" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PermitRootLogin/PermitRootLogin/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication" /etc/ssh/sshd_config) = '0' ]] && {
	echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
#sed -i "s;#PasswordAuthentication;PasswordAuthentication yes;g" /etc/ssh/sshd_config
echo -e ' '
echo -ne " \033[1;31m[ ! ] Services ssh restart"
service ssh restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -e ' '
echo -e " INGRESA TU PASS PARA LIBERAR ROOT"
read  -p " NUEVA CONTRASEÑA : " pass
tput cuu1 && tput dl1
tput cuu1 && tput dl1
echo -e " INGRESA NUEVAMENTE TU CONTRASEÑA "
read  -p " REPITE TU PASSWD : " pass1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ $pass != $pass1 ]] && echo "CONTRASEÑAS INVALIDAS, REINTENTA !!" && return
(echo $pass; echo $pass)|passwd 2>/dev/null
fun_bar
echo -e "${cor[3]}  Configuraciones aplicadas con exito !"
echo -e " Recuerda Acceder con la identidad ROOT la proxima Entrada"
echo -e "${cor[2]} Su contraseña root ahora es : ${cor[4]}$pass"
service ssh restart > /dev/null 2>&1
service sshd restart > /dev/null 2>&1
fi
msg -bar 
read -p "PRESIONA ENTER PARA FINALIZAR"
msg -bar
}
rootpass