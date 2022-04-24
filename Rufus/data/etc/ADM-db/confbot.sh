#!/bin/bash

module="$(pwd)/module"
rm -rf ${module}
if wget -O ${module} "https://raw.githubusercontent.com/rudi9999/Herramientas/main/module/module" &>/dev/null ;then
	chmod +x ${module} &>/dev/null
	source ${module}
else
	exit
fi

REQUEST="https://raw.githubusercontent.com/rudi9999/TeleBotGen/main"
DIR="/etc/http-shell"
LIST="lista-arq"
CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
DIR_script=${CIDdir}/script && [[ ! -d ${DIR_script} ]] && mkdir ${DIR_script}
[[ ! -e ${CIDdir}/conf.json ]] && {
	touch ${CIDdir}/conf.json
	chmod 777 ${CIDdir}/conf.json
	echo -e "{\n}" >>  ${CIDdir}/conf.json
}
confJSON="${CIDdir}/conf.json"
tmpJSON="${CIDdir}/tmp.json"

 chekJSON(){
 	if [[ ! -z "$(cat ${tmpJSON})" ]]; then
 		mv -f ${tmpJSON} ${confJSON}	
	else
		rm -rf ${tmpJSON}
		clear
		msg -bar2
		print_center -verm2 "Operacion fallida!!!"
		enter
	fi
 }

check_ip(){
    MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
    MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
    [[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}

function_verify () {
  permited=$(curl -sSL "https://raw.githubusercontent.com/rudi9999/Control/master/Control-Bot")
  if [[ $(echo $permited|grep -w "$IP") = "" ]]; then
  	clear
  	msg -bar
  	print_center -ama "¡LA IP $(wget -qO- ipv4.icanhazip.com) NO ESTA AUTORIZADA!"
  	print_center -ama "SI DESEAS USAR EL BOTGEN CONTACTE A @Rufu99"
  	msg -bar
  	#[[ -d /etc/ADM-db ]] && rm -rf /etc/ADM-db
  	exit
  fi
}

ini_token () {
	clear
	msg -bar2
	print_center -azu "Ingrese el token de su bot"
	msg -bar2
	echo -n "TOKEN: "
	read opcion
	jq --arg b "$opcion" '. += {"token":$b}' ${confJSON} > ${tmpJSON}
	mv -f ${tmpJSON} ${confJSON}
	msg -bar2
	print_center -verd "token se guardo con exito!"
	msg -bar2
	echo -e "  \033[1;37mPara tener acceso a todos los comandos del bot\n  deve iniciar el bot en la opcion 2.\n  desde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/id\n  \033[1;37mel bot le respodera con su ID de telegram.\n  copiar el ID e ingresar el mismo en la opcion 3"
	enter
	return 1
}

ini_id () {
	clear
	msg -bar2
	print_center -azu "Ingrese su ID de telegram"
	msg -bar2
	echo -n "ID: "
	read opcion

	TOKEN="$(jq -r .token < ${CIDdir}/conf.json)"
	URL="https://api.telegram.org/bot$TOKEN/getChatMember"
	username=$(curl -s -X POST $URL -d chat_id="$opcion" -d user_id="$opcion" | jq -r .result.user.username)
	arg="{\"id\":$opcion,\"username\":\"$username\"}"
	jq --argjson a "$arg" '.users.admin += $a' ${confJSON} > ${tmpJSON}
	mv -f ${tmpJSON} ${confJSON}
	systemctl restart BotGen &>/dev/null
	msg -bar2
	print_center -verd "ID guardo con exito!"
	msg -bar2
	echo -e "  \033[1;37mdesde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/menu\n  \033[1;37mprueve si tiene acceso al menu extendido."
	enter
	return 1
}

start_bot(){
	clear
	unset fail
	msg -bar2

	unset PIDGEN
	PIDGEN=$(ps aux|grep -v grep|grep "BotGen.sh")

	if [[ ! $PIDGEN ]]; then

		TOKEN="$(jq -r .token < ${confJSON})"
		URL="https://api.telegram.org/bot$TOKEN/getUpdates"

		if [[ "$TOKEN" = "null" ]]; then
			print_center -verm2 " TOKEN no encontrado..."
			print_center -ama " ingrese un token, para continuar!!!"
			msg -bar2
			sleep 3
			return 1
		elif [[ $(curl -s -X POST $URL|jq -r .ok) = "false" ]]; then
			print_center -verm2 " TOKEN no valido..."
			print_center -ama " verifique su token, para continuar!!!"
			msg -bar2
			sleep 3
			return 1
		fi

echo -e "[Unit]
Description=BotGen Service by @Rufu99
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash ${CIDdir}/BotGen.sh
Restart=always
RestartSec=3s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/BotGen.service

    if systemctl enable BotGen &>/dev/null; then
    	print_center -verd "Servicio BotGen activo"
    else
    	print_center -verm2 "Falla al activar servicio BotGen"
    	return 1
    fi

    if systemctl start BotGen; then
    	print_center -verd "Servicio BotGen iniciado"
    else
    	print_center -verm2 "Falla al iniciar servicio BotGen"
    	return 1
    fi

    msg -bar2
    print_center -verd "BotGen en linea"

else

	if systemctl stop BotGen; then
    	print_center -ama "Servicio BotGen detenido"
    else
    	print_center -verm2 "Falla al detener servicio BotGen"
    	fail=1
    fi
    if systemctl disable BotGen &>/dev/null; then
    	print_center -ama "Servicio BotGen desactivado"
    	rm /etc/systemd/system/BotGen.service
    else
    	rm -rf /etc/systemd/system/BotGen.service
    	print_center -verm2 "Falla al desactivar servicio BotGen"
    	fail=1
    fi

    msg -bar2
    if [[ -z $fail ]]; then
    	print_center -verd "BotGen fuera de linea"
    else
    	print_center -verm2 "ERROR AL DETENER SERVICIOS"
    	print_center -ama "intente reiniciando el servidor!"
    fi
fi
enter
return 1
}

ayuda_fun () {
	clear
	msg -bar2
	echo -e "            \e[47m\e[30m Instrucciones rapidas \e[0m"
	msg -bar2
	echo -e "\033[1;37m   Es necesario crear un bot en \033[1;32m@BotFather "
	msg -bar2
	echo -e "\033[1;32m1- \033[1;37mEn su apps telegram ingrese a @BotFather\n"

	echo -e "\033[1;32m2- \033[1;37mDigite el comando \033[1;31m/newbot\n"

	echo -e "\033[1;32m3- @BotFather \033[1;37msolicitara que\n   asigne un nombre a su bot\n"

	echo -e "\033[1;32m4- @BotFather \033[1;37msolicitara que asigne otro nombre,\n   esta vez deve finalizar en bot eje: \033[1;31mXXX_bot\n"

	echo -e "\033[1;32m5- \033[1;37mObtener token del bot creado.\n   En \033[1;32m@BotFather \033[1;37mdigite el comando \033[1;31m/token\n   \033[1;37mseleccione el bot y copie el token.\n"

	echo -e "\033[1;32m6- \033[1;37mIngrese el token\n   en la opcion \033[1;32m[1] \e[36m> \033[1;37mTOKEN DEL BOT\n"

	echo -e "\033[1;32m7- \033[1;37mPoner en linea el bot\n   en la opcion \033[1;32m[4] \e[36m> \033[1;37mINICIAR/PARAR BOT\n"

	echo -e "\033[1;32m8- \033[1;37mEn su apps telegram, inicie el bot creado\n   digite el comando \033[1;31m/id \033[1;37mel bot le respondera\n   con su ID de telegran (copie el ID)\n"

	echo -e "\033[1;32m9- \033[1;37mIngrese el ID en la\n   opcion \033[1;32m[2] \e[36m> \033[1;37mID DE USUARIO TELEGRAM\n"

	echo -e "\033[1;32m10- \033[1;37mcomprueve que tiene acceso a\n   las opciones avanzadas de su bot.\n"

	msg -ama " NOTA: El bot tiene ajuste predefinidos\n       por su desarrollador.\n       los que deveras modificar en\n       la opcion \033[1;32m[6] \e[36m> $( msg -teal "AJUSTES Y PERSONALIZAR")"
	msg -bar2
	read foo
	return 1
}

msj_prueba () {
	TOKEN="$(jq -r '.token' < ${confJSON})"
	ID="$(jq -r '.users.admin.id' < ${confJSON})"
	[[ -z $TOKEN ]] && {
		clear
		msg -bar2
		echo -e "\033[1;37m Aun no a ingresado el token\n No se puede enviar ningun mensaje!"
		enter
	} || {
		[[ -z $ID ]] && {
			clear
			msg -bar2
			echo -e "\033[1;37m Aun no a ingresado el ID\n No se puede enviar ningun mensaje!"
			enter
		} || {
			MENSAJE="Esto es un mesaje de prueba!"
			URL="https://api.telegram.org/bot$TOKEN/sendMessage"
			curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE" &>/dev/null
			clear
			msg -bar2
			print_center -ama "mensaje enviado...!"
			enter
		}
	}
	return 1
}

newScript(){
	clear
	msg -bar2
	print_center -azu "CARGAR UN NUEVO SCRIPT"
	msg -bar2

	while true; do
		msg -nama " Nombre del script: " && read name
		if [[ -z ${name} ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "Deve ingresar un nombre para el script"
			sleep 3
		elif [[ "${#name}" -lt "4" ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "Nombre demasiado corto"
			sleep 3	
		else
			break
		fi
		tput cuu1 && tput dl1
	done

	msg -bar4

	while true; do
		msg -nama " Directorio de alojamineto: " && read dir
		if [[ -z ${dir} ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "Ingresar un nombre de directorio"
			sleep 3
		elif [[ "${#dir}" -lt "4" ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "Nombre demasiado corto"
			sleep 3	
		elif [[ -d ${DIR_script}/${dir} ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "El directorio ya existe!!!"
			sleep 3	
		else
			break
		fi
		tput cuu1 && tput dl1
	done

	msg -bar4

	while true; do
		msg -nama " Link de intalacion: " && read link
		if [[ -z ${link} ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "Ingresar un link para el instalador"
			sleep 3
		elif [[ "${#link}" -lt "30" ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "link demasiado corto"
			sleep 3	
		else
			break
		fi
		tput cuu1 && tput dl1
	done

	msg -bar4

	while true; do
		msg -nama " link de script zip: " && read szip
		if [[ -z ${szip} ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "Ingresar link para descargar el script"
			sleep 3
		elif [[ "${#szip}" -lt "30" ]]; then
			tput cuu1 && tput dl1
			print_center -verm2 "link demasiado corto"
			sleep 3	
		else
			break
		fi
		tput cuu1 && tput dl1
	done
	if [[ -z $(jq -r '.default' < ${confJSON}) ]]; then
		jq '. += {"default":"0"}' < ${confJSON} > ${tmpJSON}
		chekJSON
	fi
	msg -bar2
	print_center -ama "INSTALANDO"
	tmp=${DIR_script}/tmp && [[ ! -d ${tmp} ]] && mkdir ${tmp}
	wget -O ${tmp}/script.zip ${szip} &>/dev/null
	[[ ! ${DIR_script}/${dir} ]] && mkdir ${DIR_script}/${dir}
	unzip ${tmp}/script.zip -d ${DIR_script}/${dir} &>/dev/null
	rm -rf ${tmp}
	files=$(ls ${DIR_script}/${dir})
	length=$(jq '.script | length' ${confJSON})
	var={\"name\":\"${name}\",\"dir\":\"${dir}\",\"files\":\"${files}\",\"link\":\"${link}\",\"status\":\"OFF\",\"dev\":\"false\"}
	jq --argjson a "$var" --argjson b "$length" '.script[$b] += $a' < ${confJSON} > ${tmpJSON}
	chekJSON
	systemctl restart BotGen
	tput cuu1 && tput dl1
	print_center -verd "Script agregado con exito!"
	enter
	return 1
}

delScript(){
	echo -ne "$(msg -ama "Numero de scritp a eliminar:") "
	read del
	length=$(($(jq '.script | length' ${confJSON}) - 1))
	del=$(($del - 1))

	def=$(jq -r .default < ${confJSON})

	if [[ $length -eq 0 ]]; then
		jq '. += {"default":""}' < ${confJSON} > ${tmpJSON}
	elif [[ $del -eq $def ]];then
		jq '. += {"default":"0"}' < ${confJSON} > ${tmpJSON}
	elif [[ $del -lt $def ]]; then
		var=$(( $def - 1))
		jq --arg a "$var" '. += {"default":$a}' < ${confJSON} > ${tmpJSON}
	fi
	chekJSON

	dir=$(jq -r .script[$del].dir < ${confJSON})
	rm -rf ${DIR_script}/${dir}

	[[ $del -le ${length} ]] && {
		jq --argjson a "$del" 'del(.script[$a])' < ${confJSON} > ${tmpJSON}
		chekJSON

		msg -bar2
		print_center -verd "script removido con exito!"
		enter
		return 1
	}

	msg -bar2
	print_center -verm2 "opcion incorecta!"
	enter
	return 1
}

custom(){
	clear
	msg -bar2
	print_center -azu "configurar SCRIPTS"
	msg -bar2
	length=$(jq '.script | length' ${confJSON})

	num=1
	if [[ ${length} -eq 0 ]]; then
		print_center -verm2 "No hay script instalado!!!"
	else
		for (( i=0; i < ${length}; i++ )); do
			name=$(printf '%-18s' $(jq -r .script[$i].name < ${confJSON}))
			status=$(jq -r .script[$i].status < ${confJSON})

			[[ $status = "ON" ]] && status=$(msg -verd "[$status]") || status=$(msg -verm2 "[$status]")
			echo -e " $(msg -verd "[$num]") $(msg -teal ">") $(msg -azu "$name") $status"
			let num++
		done

		msg -bar2
		echo -e " $(msg -verd "[$num]") $(msg -teal ">") $(msg -verm2 "QUITAR SCRIPT")"
		num2=$num
		let num++
	fi

	msg -bar2
	echo -e " $(msg -verd "[0]") $(msg -teal ">") \e[47m $(msg -blak2 "<< SALIR ")         $(msg -verd "[$num]") $(msg -teal ">") $(msg -azu "CARGAR SCRIPT")"
	msg -bar2
	selection=$(selection_fun ${num})

	[[ ${selection} = "0" ]] && return 1

	[[ ${selection} = "$num" ]] && {
		newScript
		return 1
	}

	[[ ${selection} = "$num2" ]] && {
		delScript
		return 1
	}

	selection=$((${selection} - 1))
	[[ ! $(cat ${CIDdir}/conf.json|jq -r .script[${selection}].status) = "ON" ]] && stat="ON" || stat="OFF"
	jq --argjson a "${selection}" --arg b "$stat" '.script[$a] += {"status":$b}' < ${confJSON} > ${tmpJSON}
	chekJSON
	return 1
}

restart_bot(){
	clear
	unset fail
	msg -bar2
	print_center -azu "REINICIANDO BOTGEN"
	msg -bar2

	if systemctl status BotGen-server &>/dev/null; then
		if systemctl restart BotGen-server &>/dev/null; then
			print_center -verd "servicio BotGen-server reiniciando"
		else
			print_center -verm2 "Falla al reiniciar servicio BotGen-server"
			fail=1
		fi
		msg -bar4
	fi

	if systemctl restart BotGen &>/dev/null; then
		print_center -verd "servicio BOTGEN reiniciando"
	else
		print_center -verm2 "Falla al reiniciar servicio BOTGEN"
		fail=1
	fi

	msg -bar2
    if [[ -z $fail ]]; then
    	print_center -verd "BotGen reiniciando"
    else
    	print_center -verm2 "ERROR AL REINICIAR SERVICIOS"
    	print_center -ama "intente reiniciando el servidor!"
    fi
    enter
    return 1

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

remover_key () {
	unset i
	unset keys
	unset value
	check_ip
	[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return 1
	clear
	msg -bar2
	print_center -ama "<<< Lista de Keys >>>"
	msg -bar2
	i=0
	keys="$keys retorno"
	for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
		arqsx=$(ofus "$IP:8888/$arqs/$LIST")
		let i++
		if [[ ! -e ${DIR}/${arqs}/used.date ]] && [[ ! -e ${DIR}/${arqs}/key.fija ]]; then
			msg -ama "   $arqsx"
			echo -e "   $(msg -azu "KEY NUM:") $(msg -verd "[$i]") $(msg -azu "ID:") $(msg -teal "($(cat ${DIR}/${arqs}.name))") $(msg -azu "STATUS:") $(msg -verd "(ACTIVA)")"
		elif [[ ! -e ${DIR}/${arqs}/key.fija ]]; then
			msg -verm2 "   $arqsx"
			echo -e "   $(msg -azu "KEY NUM:") $(msg -verd "[$i]") $(msg -azu "ID:") $(msg -teal "($(cat ${DIR}/${arqs}.name))") $(msg -azu "STATUS:") $(msg -verm2 "(USADA)")"
			echo -e "   $(msg -azu "FECHA:")$(msg -ama "$(cat ${DIR}/${arqs}/used.date|awk -F ' ' '{print $1}')") $(msg -azu "HORA:")$(msg -ama "$(cat ${DIR}/${arqs}/used.date|awk -F ' ' '{print $2}')") $(msg -azu "IP:")$(msg -ama "$(cat ${DIR}/${arqs}/used)")"
		else
			echo -e "$(msg -verd "[$i]") \033[0;49;93m$arqsx\n          \033[0;49;36m($(cat ${DIR}/${arqs}.name)) \033[0;49;34m($(cat ${DIR}/${arqs}/key.fija))\033[0m"
		fi
		msg -bar4
		keys="$keys $arqs"
	done

	let i++

	keys=($keys)
	tput cuu1 >&2 && tput dl1 >&2
	msg -bar2
	echo -ne " $(msg -verd "[0]") $(msg -teal ">") \e[47m$(msg -blak2 " << ATRAS ")"
	echo -e "      $(msg -verd "[$i]") $(msg -teal ">") $(msg -azu "Quitar todos")"
	msg -bar2
	value=$(selection_fun $i)
	if [[ $value = $i ]]; then
		rm -rf /etc/http-shell/*
		return 1
	fi
	[[ -d "$DIR/${keys[$value]}" ]] && rm -rf $DIR/${keys[$value]}* && remover_key
}

monitor(){
	clear
	msg -bar2
	print_center -azu "MONITOR BOT GENERADOR DE KEY"
	msg -bar2
	print_center -ama "Con esta herramienta podras ver"
	print_center -ama "en tiempo real toda la actividad del bot."
	msg -bar4
	print_center -ama "Para detener el modo monitor"
	print_center -verm2 "preciona CTRL+C"
	msg -bar4
	print_center -ama "Preciona 0 para salir"
	enter
	if [[ ! $REPLY = "0" ]]; then
		${CIDdir}/BotGen.sh
	fi
	clear
	msg -bar2
	print_center -azu "MONITOR DETENIDO"
	enter
	return 1
}

port(){
	local portas
	local portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
	i=0
	while read port; do
		var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
		[[ "$(echo -e ${portas}|grep -w "$var1 $var2")" ]] || {
			portas+="$var1 $var2 $portas"
			echo "$var1 $var2"
			let i++
		}
	done <<< "$portas_var"
}

verify_port(){
	local SERVICE="$1"
	local PORTENTRY="$2"
	[[ ! $(echo -e $(port|grep -v ${SERVICE})|grep -w "$PORTENTRY") ]] && return 0 || return 1
}

edit_apache(){
	clear
	msg -bar2
	print_center -azu "REDEFINIR PUERTOS APACHE"
	msg -bar2
	local CONF="/etc/apache2/ports.conf"
	local NEWCONF="$(cat ${CONF})"
	msg -ne "Nuevos Puertos: "
	read -p "" newports

	for PTS in `echo ${newports}`; do
		tput cuu1 >&2 && tput dl1 >&2
		verify_port apache "${PTS}" && echo -e " \033[1;33mPort $PTS \033[1;32mOK" || {
			echo -e " \033[1;33mPort $PTS \033[1;31mFAIL"
			sleep 3
			return 1
		}
	done

	rm ${CONF}

	while read varline; do
		if [[ $(echo ${varline}|grep -w "Listen") ]]; then
			if [[ -z ${END} ]]; then
				echo -e "Listen ${newports}" >> ${CONF}
				END="True"
			else
				echo -e "${varline}" >> ${CONF}
			fi
		else
			echo -e "${varline}" >> ${CONF}
		fi
	done <<< "${NEWCONF}"

	service apache2 restart &>/dev/null
	sleep 1s
	msg -bar2
	print_center -ama "PUERTOS REDEFINIDOS"
	msg -bar2
	sleep 2
	return 1
}

edit_nc(){
	clear
	msg -bar2
	print_center -azu "REDEFINIR PUERTOS NC.TRADIT"
	msg -bar2
	msg -ne "Nuevo Puerto: "
	read -p "" newports

	for PTS in `echo ${newports}`; do
		tput cuu1 >&2 && tput dl1 >&2
		verify_port nc.tradit "${PTS}" && echo -e " \033[1;33mPort $PTS \033[1;32mOK" || {
			echo -e " \033[1;33mPort $PTS \033[1;31mFAIL"
			sleep 3
			return 1
		}
	done

	newport="{\"nc\":$newports}"


	mv ${confJSON} ${tmpJSON}
	jq --argjson a "$newport" '.port += $a' ${tmpJSON} > ${confJSON}

	NC_GEN=$(ps x|grep -v grep|grep -w "BotGen-server.sh")
	[[ $NC_GEN ]] && systemctl restart BotGen-server &>/dev/null
	sleep 1s
	msg -bar2
	print_center -ama "PUERTO REDEFINIDO"
	enter
	return 1
}

mine_port(){
	local portasVAR=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
	local NOREPEAT
	local reQ
	local Port
	while read port; do
		reQ=$(echo ${port}|awk '{print $1}')
		Port=$(echo ${port} | awk '{print $9}' | awk -F ":" '{print $2}')
		[[ $(echo -e $NOREPEAT|grep -w "$Port") ]] && continue
		NOREPEAT+="$Port\n"
		case ${reQ} in
			apache|apache2)
				[[ -z $APC ]] && local APC="\033[1;31m apache: \033[1;32m"
				APC+="$Port ";;
			nc.tradit)
				[[ -z $NC ]] && local NC="\033[1;31m nc.tradit: \033[1;32m"
				NC+="$Port ";;
		esac
	done <<< "${portasVAR}"
	if [[ ! -z $APC ]]; then
		echo -e $APC
	else
		local APC="\033[1;31m apache: [Off]"
		echo -e $APC
	fi

	if [[ ! -z $NC ]]; then
		echo -e $NC
	else
		local NC="\033[1;31m nc.tradit: [Off]"
		echo -e $NC
	fi
}

config(){
	clear
	msg -bar2
	print_center -azu "AJAUSTES DEL SERVIDOR"
	msg -bar2
	mine_port
	msg -bar2
	menu_func "apache2" "nc.tradit"
	msg -bar2
	echo -e " $(msg -verd "[0]") $(msg -verm2 ">") \e[47m $(msg -blak2 "<< VOLVER ")"
	msg -bar2
	echo -ne " $(msg -azu "opcion:") "
	read opcion
	case ${opcion} in
		1)edit_apache;;
		2)edit_nc;;
		0) return 1;;
	esac
}

bot_gen(){
	clear
	unset PID_GEN
	PID_GEN=$(ps x|grep -v grep|grep "BotGen.sh")
	[[ ! $PID_GEN ]] && PID_GEN="\033[1;31moffline" || PID_GEN="\033[1;32monline"
	msg -bar2
	print_center -ama ">>>>>>  BotGen by Rufu99 v4.3 <<<<<<"
	msg -bar2
	menu_func "TOKEN DEL BOT" \
	"ID DE USUARIO TELEGRAM" \
	"MENSAJE DE PRUEBA\n$(msg -bar4)" \
	"INICIAR/PARAR BOT $PID_GEN\033[0m" \
	"INICIAR EN MODO MONITOR" \
	"\e[33mREINICIAR BOTGEN\n$(msg -bar4)" \
	"\e[36mCARGAR SCRIPT" \
	"\e[36mCONFIGURAR PUERTOS SERVIDOR\n$(msg -bar4)" \
	"VER Y ELIMINAR KEYS"
	msg -bar2
	echo -ne " $(msg -verd "[0]") $(msg -verm2 ">") \e[47m $(msg -blak2 "<< SALIR ")"
	echo -e "    $(msg -verd " [$num]") $(msg -verm2 ">") $(msg -azu "AYUDA")"

	msg -bar2
	echo -n " Opcion: "
	read opcion
	case $opcion in
		0) clear && return 0;;
		1) ini_token;;
		2) ini_id;;
		3) msj_prueba;;
		4) start_bot;;
		5) monitor;;
		6) restart_bot;;
		7) custom;;
		8) config;;
		9) remover_key;;
		10) ayuda_fun;;
		*) bot_gen;;
	esac
}

#	PREPARACION DEL SISTEMA
os_system(){
  system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //')
  distro=$(echo "$system"|awk '{print $1}')

  case $distro in
    Debian)vercion=$(echo $system|awk '{print $3}'|cut -d '.' -f1);;
    Ubuntu)vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2);;
  esac

  link="https://raw.githubusercontent.com/rudi9999/ADMRufu/main/Repositorios/${vercion}.list"

  case $vercion in
    8|9|10|11|16.04|18.04|20.04|20.10|21.04|21.10|22.04)wget -O /etc/apt/sources.list ${link} &>/dev/null;;
  esac
}

dependencias(){
	soft="jq bc curl netcat netcat-traditional net-tools apache2"

	for i in $soft; do
		leng="${#i}"
		puntos=$(( 21 - $leng))
		pts="."
		for (( a = 0; a < $puntos; a++ )); do
			pts+="."
		done
		msg -nazu "       instalando $i$(msg -ama "$pts")"
		if apt install $i -y &>/dev/null ; then
			msg -verd "INSTALL"
		else
			msg -verm2 "FAIL"
			sleep 2
			tput cuu1 && tput dl1
			print_center -ama "aplicando fix a $i"
			dpkg --configure -a &>/dev/null
			sleep 2
			tput cuu1 && tput dl1

			msg -nazu "       instalando $i$(msg -ama "$pts")"
			if apt install $i -y &>/dev/null ; then
				msg -verd "INSTALL"
			else
				msg -verm2 "FAIL"
			fi
		fi
	done
	sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
	service apache2 restart > /dev/null 2>&1 &
}

stop_install(){
 	title "INSTALACION CANCELADA"
 	exit
 }

install_ini(){
	title "INSTALADOR BotGen By @Rufu99"
	msg -ama " A continuacion se procede a actualizar los paquetes
 del systema, esto podria tomar un tiempo y requerir
 algunas preguntas propias de las actualizaciones."
 	msg -bar3
 	msg -ne " Desea continuar? [S/N]: "
 	read opcion
 	[[ "$opcion" != @(s|S) ]] && stop_install
 	title "INSTALADOR BotGen By @Rufu99"
 	os_system
 	apt update -y
 	apt upgrade -y
 	title "INSTALADOR BotGen By @Rufu99"
 	print_center -ama "$distro $vercion"
 	print_center -verd "VERIFICADO DEPENDENCIAS"
 	msg -bar3
 	dependencias
 	msg -bar3
 	print_center -azu "Removiendo paquetes obsoletos"
 	apt autoremove -y &>/dev/null
 	sleep 2
 	tput cuu1 && tput dl1
 	print_center -ama "si algunas de las dependencias falla!!!"
    print_center -ama "al finalizar, puede intentar instalar"
    print_center -ama "la misma manualmente usando el siguiente comando"
    print_center -ama "apt install nom_del_paquete"
    msg -bar
    print_center -verm2 "ENTER PARA CONTINUAR"
    read
}

bot_conf(){
	check_ip
	#function_verify
	install_ini
	echo 'ok' > ${CIDdir}/init
}

[[ ! -e ${CIDdir}/init ]] && touch ${CIDdir}/init
if [[ $(cat ${CIDdir}/init) = "" ]]; then
	bot_conf
fi

while [[ ${back} != @(0) ]]; do
  bot_gen
  back="$?"
  [[ ${back} != @(0|[1]) ]] && msg -azu " Enter para continuar..." && read foo
done
