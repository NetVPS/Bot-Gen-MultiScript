#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#	IP DEL SISTEMA
meu_ip_fun(){
	MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
	MIP2=$(wget -qO- ipv4.icanhazip.com)
	[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

meu_ip(){
	MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
	MIP2=$(wget -qO- ipv4.icanhazip.com)
	[[ "$MIP" != "$MIP2" ]] && echo "$MIP2" || echo "$MIP"
}

#	DONAR
donar(){
	bot_retorno="$LINE\n"
	bot_retorno+="El proyecto BotGen requiere\nde fondos para poder continuar\n"
	bot_retorno+="Usted puede realizar una donacion\n"
	bot_retorno+="Paypal\n"
	bot_retorno+="MercadoPago Arg\n"
	bot_retorno+="o bien hacer uso del acortador\nreiteradas veces\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="desde ya muchas gracias\n"
	bot_retorno+="$LINE\n"
	msj_donar
}

donar_OnOff(){
	if [[ ! -e "/etc/donar_active.txt" ]]; then
		echo "on" > /etc/donar_active.txt
		local bot_retorno="$LINE\n"
        bot_retorno+="Donar: <u>ON</u> ✅\n"
        bot_retorno+="$LINE\n"
        msj_fun
    else
    	rm -rf /etc/donar_active.txt
    	local bot_retorno="$LINE\n"
    	bot_retorno+="Donar: <u>OFF</u> ❌\n"
    	bot_retorno+="$LINE\n"
    	msj_fun
    fi
}

#	LISTA DE COMANDOS
extra(){
	bot_retorno="$LINE\n"
	bot_retorno+="Lista de comandos\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="/menu - menu principal\n"
	bot_retorno+="/add - agregar usuarios\n"
	bot_retorno+="/del - eliminar usuarios\n"
	bot_retorno+="/list - lista de usuarioas\n"
	bot_retorno+="/id - tu id de telegram\n"
	bot_retorno+="/instal - link install script\n"
	bot_retorno+="/cache -limpia la ram\n"
	bot_retorno+="/power - reinicia server keys\n"
	bot_retorno+="/reboot - reinicia servidor/VPS\n"
	bot_retorno+="/extra - muestra esta lista\n"
	bot_retorno+="/ayuda - muestra ayuda detallado\n"
	bot_retorno+="$LINE"

	comand_boton "atras"
}

#	AYUDA
ayuda_src(){
	adm="$(jq -r .users.admin.username < ${CIDdir}/conf.json)"
	[[ $adm = "null" ]] && adm=Rufu99
	bot_retorno="$LINE\n"
	bot_retorno+="     🔰 Bot generador de key 🔰\n"
	bot_retorno+="             ⚜ by @Rufu99 ⚜\n"
	bot_retorno+="$LINE\n"
	 if [[ ! "$admin_id" = "${chatuser}" ]]; then
		 if [[ ! $(echo "$user_id"|grep "${chatuser}") = "" ]]; then
			 bot_retorno+=" <u>Script Key</u> (boton)\n genera una key para el\n instalador del script.\n para tener acceso deve enviar\n su ID al admin @${adm}\n"
		 	 bot_retorno+="$LINE\n"
			 bot_retorno+="/menu o (menu boton)\n muestra el menu principal.\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/ayuda o (ayuda boton)\n muestra este menu de ayuda\n"
			 bot_retorno+="$LINE\n"
		 else
		 	 bot_retorno+=" <u>enviar al admin</u> (boton)\n envia su ID de telegram al\n administrador\n"
		 	 bot_retorno+="$LINE\n"
			 bot_retorno+="/id o (ID boton)\n muestra su ID de telegram.\n los nuevos usuarios deven\n enviar este ID al admin @${adm}\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/menu o (menu boton)\n muestra el menu principal.\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/ayuda o (ayuda boton)\n muestra este menu de ayuda\n"
			 bot_retorno+="$LINE"
		 fi
	 else
	 	 bot_retorno+="/menu\n muestra el menu principal.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/add o (add boton)\n añade un nuevo usuarios ID.\n [1]-ingresa el id del usuario.\n [2]-luego el tiempo de duracion\n      en dias.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/del o (del boton)\n elimina usuarios ID.\n selecciona un numero de la\n lista a eliminar.\n se subira una copia de\n seguridad de los usuarios.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/list o (list boton)\n muestra una lista de usuarios ID.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/id o (ID boton)\n muestra su ID de telegram.\n los nuevos usuarios deven\n enviar este ID al admin @${adm}\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="<u>Script Key</u> boton\n genera una key para el\n instalador del script.\n para tener acceso deve enviar\n su ID al admin @${adm}\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/instal\n muestra el link de instalacion\n del script para usar sus key.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/power\n poner o sacar de linea gen-server.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/cache\n limpia ram y el cache contenido\n en la ram.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/reboot\n Reinicia el servidor o vps.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/ayuda\n muestra este menu de ayuda.\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="para restaurar una copia de\nlos id de usuarios.\nRenviar la copia subidad\nal añadir o eliminar usuarios.\n"
		 bot_retorno+="$LINE\n"
	 fi
	 comand_boton "atras"
}

#	MENSAJE DE ERROR
invalido_src(){
	bot_retorno="$LINE\n"
    bot_retorno+="Comando invalido!\n"
    bot_retorno+="$LINE\n"
}

#	INICIAR/DETENER SERVIDOR
start_gen () {
	unset PIDGEN
	PIDGEN=$(ps aux|grep -v grep|grep "BotGen-server.sh")

	if [[ ! $PIDGEN ]]; then

echo -e "[Unit]
Description=BotGen-server Service by @Rufu99
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash ${CIDdir}/BotGen-server.sh -start
Restart=always
RestartSec=3s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/BotGen-server.service

		systemctl enable BotGen-server
    	systemctl start BotGen-server
    	btn_conf
		menu_src
	else
		systemctl stop BotGen-server
		systemctl disable BotGen-server
		rm /etc/systemd/system/BotGen-server.service
		btn_conf
		menu_src
	fi
}

reset_gen(){
	unset PIDGEN
	PIDGEN=$(ps aux|grep -v grep|grep "BotGen-server.sh")

	if [[ $PIDGEN ]]; then
		systemctl restart BotGen-server
		menu_src
	fi
}

#	ADMINISTRACION DE SISTEMA
cache_src(){
	sudo sync
	sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1
	bot_retorno="$LINE\n"
	bot_retorno+=" ✅🗑 Cache\Ram refreez! 🗑✅\n"
	bot_retorno+="$LINE"

	if [[ ${comando[1]} = "edit" ]]; then
		edit_msj
		menu_src
	else
		comando[1]="edit"
		msj_fun
		menu_src
	fi
}

reboot_src(){
	bot_retorno="$LINE\n"
    bot_retorno+="Reiniciando servidor VPS\n"
    bot_retorno+="$LINE\n"
    msj_fun
    sleep 2
    reboot
}

#	GENERADOR DE KEYS
gerar_key () {
	data="${comando[1]}"
	scripts=$(jq .script[$data] < ${confJSON})

	if [[ $(echo "$scripts"|jq -r .status) = "OFF" ]]; then
		bot_retorno="$LINE\n"
		bot_retorno+="Este script no esta disponible\n"
		bot_retorno+="$LINE"
		comand_boton "atras"
		return 0
	fi

	DIR="/etc/http-shell"
	LIST="lista-arq"

	P=$(jq -r '.port.nc' < ${confJSON})
	if [[ "$P" != @("null"|"") ]]; then
		local PORT="$P"
	else
		local PORT="8888"
	fi
	
	name=$(echo "$scripts"|jq -r .name)
	dir=$(echo "$scripts"|jq -r .dir)
	files=$(echo "$scripts"|jq -r .files)
	link=$(echo "$scripts"|jq -r .link|sed 's/;/ \&\&/g')

	time=$(jq -r '.time' < ${confJSON})

	if [[ $time = 'null' ]]; then
		time=4
	fi

	meu_ip_fun
	valuekey="$(date | md5sum | head -c10)"
	valuekey+="$(echo $(($RANDOM*10))|head -c 5)"

	fun_list "$valuekey" "$dir" "$files" "$time"

	keyfinal=$(ofus "$IP:$PORT/$valuekey/$LIST")

	local bot_retorno="$LINE\n"
		  bot_retorno+="✅ Key $name Generada! ✅\n"
		  bot_retorno+="$LINE\n"
		  bot_retorno+="<code>${keyfinal}</code>\n"
		  bot_retorno+="$LINE\n"
		  bot_retorno+="<code>${link}</code>\n"
		  bot_retorno+="$LINE\n"
		  bot_retorno+="Esta key se autodestruira en ${time}hs\npasado este tiempo deve generar una nueva key.\n"
		  bot_retorno+="$LINE\n"

	echo -e $bot_retorno >> ${keytxt}/${name}_${chatuser}.txt

	btn_menukey

	upfile_fun "${keytxt}/${name}_${chatuser}.txt" "botao_key"
	rm ${keytxt}/${name}_${chatuser}.txt

	if [[ ${chatuser} -ne $(jq -r '.users.admin.id' < ${confJSON}) ]]; then
		kn=$(cat ${NID}|grep "${chatuser}")
		kn2=$(echo "$kn"|awk -F ' ' '{print $2}')
		kn3=$(echo "$kn"|awk -F ' ' '{print $3}')
		let kn2++
		sed -i "s/$kn/${chatuser} ${kn2} ${kn3}/g" ${NID}
	fi
}

fun_list () {
	rm ${scriptDIR}/$2/*.x.c &> /dev/null
	unset KEY
	KEY="$1"
	#CRIA DIR
	[[ ! -e ${DIR} ]] && mkdir ${DIR}
	#CRIA KEY
	[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
	#PASSA ARQS
	nombrevalue="${chatuser}"
	#ADM BASIC
	arqslist="$3"
	for arqx in `echo "${arqslist}"`; do
		[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
		cp ${scriptDIR}/$2/$arqx ${DIR}/${KEY}/
		echo "$arqx" >> ${DIR}/${KEY}/${LIST}
	done
	echo "$nombrevalue" > ${DIR}/${KEY}.name
	[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa

	if [[ $4 -gt '0' ]]; then
		at now +$4 hours <<< "rm -rf ${DIR}/${KEY} && rm -rf ${DIR}/${KEY}.name"
	fi
}

ofus () {
	unset server
	server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
	unset txtofus
	number=$(expr length $1)
	for((i=1; i<$number+1; i++)); do
		txt[$i]=$(echo "$1" | cut -b $i)
		case ${txt[$i]} in
			".")txt[$i]="*";;
			"*")txt[$i]=".";;
			"1")txt[$i]="@";;
			"@")txt[$i]="1";;
			"2")txt[$i]="?";;
			"?")txt[$i]="2";;
			"4")txt[$i]="%";;
			"%")txt[$i]="4";;
			"-")txt[$i]="K";;
			"K")txt[$i]="-";;
		esac
		txtofus+="${txt[$i]}"
	done
	echo "$txtofus" | rev
}

#	MENU PRINCIPAL ADMIN/USERS
menu_src(){
	 if [[ ! "$admin_id" = "${chatuser}" ]]; then

		 if [[ $(echo "$user_id"|grep "${chatuser}") = "" ]]; then
		   	bot_retorno="$LINE\n"
		 	bot_retorno+="     🔰 Bot generador de key 🔰\n"
		 	bot_retorno+="             ⚜ by @Rufu99 ⚜\n"
		 	bot_retorno+="$LINE\n"
		 	bot_retorno+="    ⚠️ <u>Aun no tienes acceso</u> ⚠️\n"
		 	bot_retorno+="$LINE\n"
			bot_retorno+="/ID (muestra sus ID)\n"
			bot_retorno+="/menu (muestra este menu)\n"
			bot_retorno+="/ayuda (ayuda de los comandos)\n"
			bot_retorno+="$LINE\n"
			comand_boton "user"
		 else
		 	var=$(echo ${user_id}|grep "${chatuser}")
		 	line=$(echo ${var}|awk '{print $2}')
		 	VPSsec=$(date +%s)
		 	DataSec=$(date +%s --date="$line")
		 	EXPTIME="[$(($(($DataSec - $VPSsec)) / 86400))]"
		 	key_genered=$(cat ${NID}|grep -w "${chatuser}"|awk -F ' ' '{print $2}')
		 	key_used=$(cat ${NID}|grep -w "${chatuser}"|awk -F ' ' '{print $3}')

		 	bot_retorno="$LINE\n"
		 	bot_retorno+="     🔰 Bot generador de key 🔰\n"
		 	bot_retorno+="             ⚜ by @Rufu99 ⚜\n"
		 	bot_retorno+="$LINE\n"
		 	bot_retorno+="<u>TU ID</u>: <code>${chatuser}</code>\n"
		 	bot_retorno+="<u>Dias restantes</u>: $EXPTIME\n"
		 	bot_retorno+="<u>keys generadas</u>: [${key_genered}]\n"
		 	bot_retorno+="<u>keys usadas</u>: [${key_used}]\n"
		 	bot_retorno+="$LINE\n"
			bot_retorno+="/menu (muestra este menu)\n"
			bot_retorno+="/ayuda (ayuda de los comandos)\n"
			bot_retorno+="$LINE"
			user2
			comand_boton "user2"
		 fi
		 
	 else

	 	#HORA Y FECHA
	 	unset _hora
	 	unset _fecha
	 	_hora=$(printf '%(%H:%M:%S)T') 
	 	_fecha=$(printf '%(%D)T') 

	 	#PROCESSADOR
	 	unset _core
	 	unset _usop
	 	_core=$(grep -c cpu[0-9] /proc/stat)
	 	_usop=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')

	 	#MEMORIA RAM
	 	unset _usor
	 	unset ram0
	 	unset ram1
	 	unset ram2
	 	unset ram3
	 	ram0=$(free -h|grep -i mem)
	 	ram1=$(echo "$ram0"|awk {'print $2'})
	 	ram2=$(echo "$ram0"|awk {'print $4'})
	 	ram3=$(echo "$ram0"|awk {'print $3'})
	 	_usor=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')

	 	unset os_sys
	 	os_sys=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //')

		 unset PID_GEN
		 PID_GEN=$(ps x|grep -v grep|grep -w "BotGen-server.sh")
		 [[ ! $PID_GEN ]] && PID_GEN='(Offline) ❌' || PID_GEN='(Online) ✅'

		 unset usadas
		 usadas="$(cat ${CIDdir}/key-use)"
		 [[ ! $usadas ]] && k_used="0" || k_used="$usadas"

		 bot_retorno="$LINE\n"
		 bot_retorno+="Gen $PID_GEN | Keys Used [$k_used]\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="<u>S.O</u>: $os_sys\n"
		 bot_retorno+="<u>Su IP es</u>: $(meu_ip)\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="<u>Ram</u>: $ram1  ||  <u>En Uso</u>: $_usor\n"
		 bot_retorno+="<u>Usada</u>: $ram3  ||  <u>Libre</u>: $ram2\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="<u>CPU</u>: $_core  ||  <u>En Uso</u>: $_usop\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="<u>Fecha</u>: $_fecha  <u>Hora</u>: $_hora\n"
		 bot_retorno+="$LINE\n"

		 btn_conf 'Ingrese un ID'

		 comand_boton "conf"
	 fi	
}

#	ADMINISTRACION DE SCRIPT
#======= INSTALADOR DE SCRIPT ==========
inst_script(){
	case $1 in
	 Nombre)sdata[0]=${message_text} && local bot_retorno="Carpeta";;
	Carpeta)sdata[1]=${message_text} && local bot_retorno="Link";;
	   Link)sdata[2]=${message_text}

	   		if [[ "$(jq -r '.default' < ${confJSON})" = 'null' ]]; then
	   			jq '. += {"default":"0"}' < ${confJSON} > ${tmpJSON}
	   			mv -f ${tmpJSON} ${confJSON}
	   		fi

	   		[[ ! ${scriptDIR}/${sdata[1]} ]] && mkdir ${scriptDIR}/${sdata[1]}
	   		unzip ${scriptDIR}/tmp/script.zip -d ${scriptDIR}/${sdata[1]} &>/dev/null
	   		rm -rf ${scriptDIR}/tmp
	   		sdata[3]=$(ls ${scriptDIR}/${sdata[1]})
	   		length=$(jq '.script | length' ${confJSON})
	   		jq --argjson a "$length" --arg b "${sdata[0]}" --arg c "${sdata[1]}" --arg d "${sdata[3]}" --arg e "${sdata[2]}" '.script[$a] += {"name":$b,"dir":$c,"files":$d,"link":$e,"status":"OFF","dev":"false"}' < ${confJSON} > ${tmpJSON}

	   		if [[ ! -z "$(cat ${tmpJSON})" ]]; then
	   			mv -f ${tmpJSON} ${confJSON}

	   			new=$(jq .script[${length}] < ${confJSON})
	   			name=$(echo $new|jq -r '.name')
	   			dir=$(echo $new|jq -r '.dir')
	   			link=$(echo $new|jq -r '.link'|sed 's/&&/;/g'|sed 's/ ;/;/g')

	   			local bot_retorno="$LINE\n"
	   			bot_retorno+="✅ SCRIPT INSTALADO ✅\n"
	   			bot_retorno+="$LINE\n"
	   			bot_retorno+="<u>Nombre</u>: $name\n"
	   			bot_retorno+="<u>Almacenado</u>: $dir\n"
	   			bot_retorno+="<u>Instalador</u>: <code>$link</code>\n"
	   			bot_retorno+="$LINE"

	   			comand_boton "atras"	
	   		else
	   			rm -rf ${tmpJSON}
	   			local bot_retorno="$LINE\n"
	   			bot_retorno+="❌ SCRIPT NO INSTALADO ❌\n"
	   			bot_retorno+="$LINE"
	   			msj_fun
	   		fi
	   		return 0
	   		;;
		ini)local bot_retorno="Nombre";;
	esac
	reply
}

#======= LINK DE INSTALACION ==========
link_src(){
	def="$(jq -r '.default' < ${confJSON})"
	inst=$(jq .script[${def}] < ${confJSON})

	if [[ $def = "" ]]; then
		link="NO HAY LINK INSTALADO!"
	else
		inst=$(jq .script[${def}] < ${confJSON})
		name=$(echo "$inst"|jq -r '.name')
		link=$(echo "$inst"|jq -r '.link'|sed 's/&&/;/g'|sed 's/ ;/;/g')
		echo "$name"
	fi

	bot_retorno="$LINE\n"
	bot_retorno+="  🔗 LINK DE INSTALACION 🔗\n"
	bot_retorno+="$LINE\n"
	print_center "Script: $name"
	bot_retorno+="$LINE\n"
	bot_retorno+="<code>$link</code>\n"
	bot_retorno+="$LINE"

	comand_boton "atras"
}
#=======================================

key_menu(){
	if [[ $(jq -r '.default' < ${confJSON}) = "" ]]; then
		menu_src	
		return 0
	fi

	btn_keymenu
	def=$(jq -r '.default' < $conf_json)
	def=$(jq -r .script[$def].name < $conf_json)
	bot_retorno="$LINE\n"
	bot_retorno+=" Script default: $def ✅\n"
	bot_retorno+="$LINE"

	comand_boton "keyMenu"
}

conf(){
	var=${comando[1]}
	[[ -z ${var} ]] && return
	if jq --arg a "$var" '. += {"default":$a}' < ${confJSON} > ${tmpJSON} ;then
		mv -f ${tmpJSON} ${confJSON}
	fi
	comando[1]='edit'
	key_menu
}

idden(){
	var=${comando[1]}
	var2=${comando[2]}
	length=$(($(jq '.script | length' ${confJSON}) - 1))
	bot_retorno="$LINE\n"
	bot_retorno+="Script $var2 para los users\n"
	bot_retorno+="$LINE"

	if jq --argjson a "$var" --arg b "$var2" '.script[$a] += {"status":$b}' < ${confJSON} > ${tmpJSON} ;then
		mv -f ${tmpJSON} ${confJSON}
	fi

	comando[1]='edit'

	if [[ $length -eq 0 ]]; then
		edit_msj
		menu_src
	else
		btn_keymenu
		comand_boton "keyMenu"
		sleep 2
		key_menu
	fi
}

quitar(){

	length=$(($(jq '.script | length' ${confJSON}) - 1))
	def=$(jq -r .default < ${confJSON})
	name_del=$(jq -r .script[${comando[1]}].name < ${confJSON})
	dir_del=$(jq -r .script[${comando[1]}].dir < ${confJSON})

	if [[ $length -eq 0 ]]; then
		jq 'del(.default)' < ${confJSON} > ${tmpJSON}
		mv -f ${tmpJSON} ${confJSON}
	elif [[ ${comando[1]} -eq $def ]];then
		jq '. += {"default":"0"}' < ${confJSON} > ${tmpJSON}
		mv -f ${tmpJSON} ${confJSON}
	elif [[ ${comando[1]} -lt $def ]]; then
		var=$(( $def - 1))
		jq --arg a "$var" '. += {"default":$a}' < ${confJSON} > ${tmpJSON}
		mv -f ${tmpJSON} ${confJSON}
	fi

	if jq --argjson a "${comando[1]}" 'del(.script[$a])' < ${confJSON} > ${tmpJSON} ; then
		mv -f ${tmpJSON} ${confJSON}
		rm -rf ${scriptDIR}/${dir_del}
	fi

	local bot_retorno="$LINE\n"
	bot_retorno+="🛑 Script eliminado: $name_del 🗑\n"
	bot_retorno+="$LINE"

	comando[1]='edit'

	if [[ $length -eq 0 ]]; then
		edit_msj
		menu_src
	else
		btn_keymenu
		comand_boton "keyMenu"
		sleep 2
		key_menu
	fi
}

#	ID DE USUARIOS
#===== COPIAS DE SEGURIDAD ========
backup(){
  while read line; do
    var=$(echo "${user_id}"|grep -w "$line")
    var2=$(cat "${NID}"|grep -w "$line"|awk -F ' ' '{print $2}')
    var3=$(cat "${NID}"|grep -w "$line"|awk -F ' ' '{print $3}')
    echo "$var $var2 $var3" >> ${backup}
  done <<< $(echo "${user_id}"|awk -F ' ' '{print $1}')
}

upfile_src(){
	backup
	upfile_fun "$HOME/user-backup" "botao_up"
	rm ${backup}
}
#==================================

listID_src(){

	if [[ ! $(echo ${user_id}) ]]; then
		local bot_retorno="$LINE\n"
		bot_retorno+="NO HAY ID AUTORIZADOS!\n"
		bot_retorno+="$LINE"

		comand_boton "atras"
		return 0
	fi

	VPSsec=$(date +%s)

	if [[ ${comando[0]} = "/del" ]]; then
		bot_retorno="━━━  Eliminar Usuarios  ━━━\n"
	else
		bot_retorno="━━━  Lista de Usuarios  ━━━\n"
	fi

	bot_retorno+="$(printf "%-10s %-20s %-7s" N° User-ID DIAS G/U)\n"
	bot_retorno+="$LINE\n"

	n=1
	while IFS= read -r line
	do
		line1=$(echo ${line}|awk '{print $1}')
		line2=$(echo ${line}|awk '{print $2}')

		DataSec=$(date +%s --date="$line2")

		if [[ "$VPSsec" -gt "$DataSec" ]]; then
			EXPTIME="[Exp]"
		else
			EXPTIME="$(printf "%-8s" "$(($(($DataSec - $VPSsec)) / 86400))")"
		fi

		key_g=$(cat "${NID}"|grep -w "$line1"|awk -F ' ' '{print $2}')
		key_u=$(cat "${NID}"|grep -w "$line1"|awk -F ' ' '{print $3}')

		line3=${#line1}
		line4=$((15 - $line3))
		unset esp
		for (( i = 0; i < ${line4}; i++ )); do
				esp+="  "
		done
		line5="$line1+$esp"

		if [[ (( $n -le 9 )) ]]; then
			bot_retorno+="  $n - ${line5}${EXPTIME}$key_g/$key_u\n"
		else
			bot_retorno+="$n - ${line5}${EXPTIME}$key_g/$key_u\n"
		fi

		let n++
	done <<< $(echo "${user_id}")
	
	bot_retorno+="$LINE\n"

	if [[ ${comando[0]} = "/del" ]]; then
		reply
	elif [[ ${comando[0]} = "/list" ]]; then
		comand_boton "list"
	fi
}

myid_src(){

  var=$(jq -r '.users.admin.username' < ${confJSON})

  bot_retorno="$LINE\n"
  bot_retorno+="     🔰 Bot generador de key 🔰\n"
  bot_retorno+="             ⚜ by @Rufu99 ⚜\n"
  bot_retorno+="$LINE\n"
  bot_retorno+="Recuerda primero debes contactar\n"
  bot_retorno+="a @$var y arreglar el 💸 pago 💸\n"
  bot_retorno+="para asi poder generar keys\n"
  bot_retorno+="$LINE\n"
  bot_retorno+="SU ID: <code>${chatuser}</code>\n"
  bot_retorno+="$LINE"

  sendID
  comand_boton "send_id"
}

deleteID_reply(){
  delid=$(echo $(sed -n ${message_text[$id]}p ${CID})|awk '{print $1}')
  sed -i "${message_text[$id]}d" ${CID}
  sed -i "${message_text[$id]}d" ${NID}
  user_id="$(cat ${CID})"
  del_msj "${return[message_id]}"
  bot_retorno="$LINE\n"
  bot_retorno+="  🗑 ID eliminado con exito! 🗑\n"
  bot_retorno+="$LINE\n"
  bot_retorno+="ID: ${delid}\n"
  bot_retorno+="$LINE\n"


  if [[ -z ${user_id} ]]; then
    comand_boton "atras"
    return 0
  fi
  upfile_src
}

addID_reply(){
  id_exp=$1
  _id=$(echo $id_exp|awk '{print $1}'|awk -F ":" '{print $2}')
  exp=$(echo $id_exp|awk '{print $2}'|awk -F ":" '{print $2}')
  datexp=$(date "+%F" -d "+$exp days")

    echo "$_id $datexp" >> ${CID}
    echo "$_id 0 0" >> ${NID}

    user_id="$(cat ${CID})"

    bot_retorno="$LINE\n"
    bot_retorno+="         ✅  ID agregado   ✅\n"
    bot_retorno+="$LINE\n"
    bot_retorno+="ID:$_id Exp:$(date '+%d/%m/%C%y' -d "+$exp days")\n"
    bot_retorno+="$LINE"

    bot_retor="$LINE\n"
    bot_retor+="     🔰 Bot generador de key 🔰\n"
    bot_retor+="             ⚜ by @Rufu99 ⚜\n"
    bot_retor+="$LINE\n"
    bot_retor+="El Administrador te autorizo a\n"
    bot_retor+="usar el bot generador de keys\n"
    bot_retor+="$LINE\n"
    bot_retor+="Usa el <u>comando</u> o <u>boton</u> menu\n"
    bot_retor+="para actualizar el menu principal\n"
    bot_retor+="$LINE\n"

    upfile_src

    ShellBot.sendMessage  --chat_id $_id \
                    --text "$(echo -e "$bot_retor")" \
                    --parse_mode html \
                    --reply_markup "$(ShellBot.InlineKeyboardMarkup -b "botao_atras")"
                    return 0

}

inf(){
	if [[ ${callback_query_data[$id]} ]]; then
		bot_retorno="inf num list" && reply
	elif [[ ! -z ${comando[1]} ]]; then
		getinf "${comando[1]}"
	else
		invalido_fun
	fi

}

newid(){
	local bot_retorno="Ingrese un ID"
	reply
}

exp_id(){
	if [[ $(echo "${user_id}"|grep -w "$1") ]]; then
		bot_retorno="$LINE\n"
	    bot_retorno+="  ⚠️ Este ID ya existe ⚠️\n"
	    bot_retorno+="$LINE"
	    msj_fun
	    sleep 2
	    ShellBot.deleteMessage  --chat_id ${return[chat_id]} --message_id "${return[message_id]}"
	    return 0
	fi
	local bot_retorno="ID:$1\n\n"
	bot_retorno+="Ingrese una fecha expiracion"
	reply
}

send_admin(){

	local bot_retorno2="$LINE\n"
	bot_retorno2+="🔰 Solicitud de autorizacion 🔰\n"
	bot_retorno2+="$LINE\n"
	bot_retorno2+="<u>Nombre</u>: ${callback_query_from_first_name}\n"
	[[ ! -z ${callback_query_from_username} ]] && bot_retorno2+="<u>Alias</u>: @${callback_query_from_username}\n"
	bot_retorno2+="<u>ID</u>: <code>${callback_query_from_id}</code>\n"
	bot_retorno2+="$LINE"

	bot_retorno="$LINE\n"
	bot_retorno+="     🔰 Bot generador de key 🔰\n"
	bot_retorno+="             ⚜ by @Rufu99 ⚜\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="      ✅ ID enviado al admin ✅\n"
	bot_retorno+="$LINE"
	comand_boton "atras"

	saveID "${callback_query_from_id}"
	var=$(jq -r '.users.admin.id' < ${confJSON})
	ShellBot.sendMessage 	--chat_id $var \
							--text "$(echo -e "$bot_retorno2")" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_save_id')"

	return 0
}

#	COMANDOS ADMIN/USERS
comand(){

	    if [[ ! "$admin_id" = "${chatuser}" ]]; then
	    	if [[ ! $(echo "$user_id"|grep "${chatuser}") = "" ]]; then
	    		Botsec=$(date +%s)
	    		DateExp="$(echo "$user_id"|grep -w "${chatuser}"|awk '{print $2}')"
	    		DataSec=$(date +%s --date="$DateExp")

	    		if [[ "$Botsec" -gt "$DataSec" ]]; then
	    			sed -i "/${chatuser}/ d" ${CID}
	    			user_id="$(cat ${CID})"
	    		fi
	    	fi

	    	if [[ $(echo "$user_id"|grep "${chatuser}") = "" ]]; then
	    		del_msj
	    		if [[ ${callback_query_data[$id]} ]]; then
	    			case ${comando[0]} in
	    				/sendid) send_admin && return 0;;
	    			esac
	    		fi
	    		case ${comando[0]} in
	    			/[Ii]d|/[Ii]D)myid_src &;;
	    			/[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
	    			/[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
	    			/*|*)invalido_fun &;;
	    		esac
	    	else
	    		if [[ ${callback_query_data[$id]} ]]; then
	    			case ${comando[0]} in
	    				/[Kk]eygen)gerar_key  && return 0;;
	    			esac
	    		fi
	    		if [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then
	    			del_msj
	    			case ${comando[0]} in
	    				/[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
	    				/[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
	    				#/[Ii]d|/[Ii]D)myid_src &;;
	    				/*|*)invalido_fun &;;
	    			esac
	    		 fi
	    		 sleep 5
	    		 [[ -e "/etc/donar_active.txt" ]] && donar
	    	fi
	    else
	    	if [[ ${message_reply_to_message_message_id[$id]} ]]; then

	    		opc="${message_reply_to_message_text[$id]}"

	    		case $opc in
	    			[Nn]ombre|[Cc]arpeta|[Ll]ink)inst_script $opc && return 0;;
	    		esac

	    		if [[ ! $(echo "$opc"|grep "Eliminar") = "" ]]; then
	    			opc="del"
	    		elif [[ ! $(echo "$opc"|grep "ID:") = "" ]]; then
	    			opc2=$(echo "$opc"|cut -d '\' -f1)
	    			opc2+=" Exp:${message_text[$id]}"
	    			opc="save"
	    			del_msj "${return[message_id]}"
	    		elif [[ ! $(echo "$opc"|grep "ID") = "" ]]; then
	    			del_msj "${return[message_id]}"
	    			if [[ $(echo "${user_id}"|grep -w "${message_text[$id]}") = "" ]]; then
	    				bot_retorno="ID:${message_text[$id]}\n\n"
	    				bot_retorno+="Ingrese una fecha expiracion"
	    				opc="ID"
	    			else
	    				bot_retorno="$LINE\n"
	    				bot_retorno+="  ⚠️ Este ID ya existe ⚠️\n"
	    				bot_retorno+="$LINE"
	    				msj_fun
	    				sleep 2
	    				message_message_id="${return[message_id]}"
	    				del_msj
	    				return 0
	    			fi
	    		elif [[ ! $(echo "$opc"|grep "inf") = "" ]]; then
	    			del_msj "${message_reply_to_message_message_id[id]}"
	    			inf_id=$(echo $(sed -n ${message_text[$id]}p ${CID})|awk '{print $1}')
	    			getinf "$inf_id"
	    			return 0
	    		fi

				case ${opc} in
					'del')deleteID_reply;;
					'save')addID_reply "${opc2}";;
					'ID')reply;;
					*)invalido_fun;;
				esac

			elif [[ ${message_document_file_id[$id]} ]]; then
					 download_file
	    	elif [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then
	    		length=$(jq '.script | length' ${confJSON})

	    		# comandos solo botones
	    		if [[ ${callback_query_data[$id]} ]]; then
	    			if [[ "$length" -ge "2" ]]; then
	    				case ${comando[0]} in
	    					/[Mm]enukey)key_menu && return 0;;
	    					/[Kk]eygen)gerar_key  && return 0;;
	    				esac
	    			elif [[ "$length" = "1" ]]; then
	    				case ${comando[0]} in
	    					/[Kk]eygen)gerar_key && return 0;;
	    				esac
	    			fi
	    			case ${comando[0]} in
	    				/default) conf && return 0;;
	    				/idden) idden && return 0;;
	    				/quitar) quitar && return 0;;
	    				/sendid) send_admin && return 0;;
	    				/saveid)exp_id "${comando[1]}" && return 0;;
	    			esac
	    		fi

	    		del_msj

	    		PIDGEN=$(ps aux|grep -v grep|grep -w "BotGen-server.sh")
	    		if [[ $PIDGEN ]]; then
	    			case ${comando[0]} in
	    				/[Rr]eset)reset_gen && return 0;;
	    			esac
	    		fi

		 		case ${comando[0]} in
					 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
					 /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
					 /[Ii]d|/[Ii]D)myid_src &;;
					 /[Aa]dd) newid;;
					 /[Dd]el)listID_src;;
					 /[Pp]ower)start_gen &;;
			 		 /[Ll]ist)listID_src &;;
					 /[Rr]eboot)reboot_src &;;
			 		 /[Ii]nstal)link_src &;;
			 		 /[Cc]ache)cache_src &;;
					 /[Dd]onar)donar_OnOff &;;
					 /[Ee]xtra)extra &;;
					 /[Ii]nfo)inf &;;
			 		 /*|*)invalido_fun &;;
				esac
			fi
	    fi
}