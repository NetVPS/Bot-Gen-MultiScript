#!/bin/bash

barra="\033[0;31m•••••••••••••••••••••••••••••••••••••••••••••••••\033[0m"
domain_check() {
[[ -e /root/name ]] && figlet -p -f smslant < /root/name | lolcat || echo -e "\033[7;49;35m    =====>>►► 🐲 New ChumoGH💥VPS 🐲 ◄◄<<=====      \033[0m"
echo -e "$barra"
echo -e " COLOCA TU DOMINIO ENLAZADO A TU VPS\n"
    read -rp "Coloca tu dominio (Ej: midominio.com):" domain
    domain_ip=$(ping "${domain}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')
    echo -e "Obteniendo información de IP de la red pública, espere... "
    local_ip=$(curl https://api-ipv4.ip.sb/ip)
    echo -e "IP de resolucion dns de su dominio：${domain_ip}"
    echo -e "Su IP local: ${local_ip}"...
    sleep 0.5
    if [[ $(echo "${local_ip}" | tr '.' '+' | bc) -eq $(echo "${domain_ip}" | tr '.' '+' | bc) ]]; then
        echo -e "La IP de resolución dns de su dominio coincide con la IP local"
        sleep 0.5
    else
        echo -e "Asegúrese de que se agrego el registro A correcto al nombre de dominio, de lo contrario, V2ray no se puede utilizar normalmente "
        echo -e "La IP de resolución DNS de su dominio no coincide con la IP local. ¿Quieres continuar con la instalación?（y/n）" && read -r install
        case $install in
        [yY][eE][sS] | [yY])
            echo -e "Continuando con la instalacion... "
            sleep 0.5
            ;;
        *)
            echo -e "instalacion canselada... "
            exit 2
            ;;
        esac
    fi
}

port_exist_check() {
    if [[ 0 -eq $(lsof -i:"$1" | grep -i -c "listen") ]]; then
        echo -e "puerto $1 no esta ocupado"
        sleep 1
    else
        echo -e "Se detecto que el puerto $1 esta ocupado"
        lsof -i:"$1"
        echo -e "en 3 segundos se intentara liberar el puerto"
        sleep 3
        lsof -i:"$1" | awk '{print $2}' | grep -v "PID" | xargs kill -9
        echo -e "el puerto se libero"
        sleep 1
    fi
}

ssl_judge_and_install() {
    if [[ -f "/data/cert.key" || -f "/data/cert.crt" ]]; then
        echo -e "En la ruta /data Ya existe un certificado"
        echo -ne "Deseas eliminarlo ? [Y/N] : "
        read -r ssl_delete
        case $ssl_delete in
        [yY][eE][sS] | [yY])
            rm -rf /data/*
            echo -e "eliminado"
            ;;
        *) ;;

        esac
    fi

    if [[ -f "/data/cert.key" || -f "/data/cert.crt" ]]; then
        echo "El archivo de certificado ya existe"
    elif [[ -f "$HOME/.acme.sh/${domain}_ecc/${domain}.key" && -f "$HOME/.acme.sh/${domain}_ecc/${domain}.cer" ]]; then
        echo "El archivo de certificado ya existe"
        "$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath /data/cert.crt --keypath /data/cert.key --ecc
        echo "Certificado aplicado"
    else
        ssl_install
        acme
    fi
}

ssl_install() {
    apt install socat netcat -y

    curl https://get.acme.sh | sh
}

acme() {
    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force --test; then
        echo -e "SSL La prueba del certificado se emite con éxito y comienza la emisión oficial"
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        sleep 0.5
    else
        echo -e "Error en la emisión de la prueba del certificado SSL"
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        exit 1
    fi

    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force; then
        echo -e "SSL El certificado se genera con éxito"
        sleep 0.5
        mkdir /data
        if "$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath /data/cert.crt --keypath /data/cert.key --ecc --force; then
            echo -e "La configuración del certificado es exitosa"
            sleep 0.5
        fi
		echo "${domain}" > /data/domain
    else
        echo -e "Error al generar el certificado SSL"
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        exit 1
    fi
}


		echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas validar tu certificado creado en ZEROSSL"
		echo -e "     Coloca tu correo registrado en ZEROSSL!"
		echo -e "         Caso Contrario Presiona enter"
		echo -e "\033[0m"
		echo -e $barra
tempcorr="$(date | md5sum | head -c15)@gmail.com"
	echo -e "   Ingrese Correo Temporal o Fijo \n  Para Validar su Cerficicado SSL " 
	read -p " Ejemplo > mi-correo@chumogh.com : " -e -i $tempcorr crreo
	
	[[ $crreo = $tempcorr ]] && {
	echo -e $barra
	wget -O -  https://get.acme.sh | sh -s email=$crreo
	} || {
	echo -e $barra
	$HOME/.acme.sh/acme.sh  --register-account  -m $crreo --server zerossl
	}
	
	

domain_check
port_exist_check 80
port_exist_check 443
ssl_judge_and_install