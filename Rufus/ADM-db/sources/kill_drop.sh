#!/bin/bash
# -*- ENCODING: UTF-8 -*-

CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
SRC="${CIDdir}/sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
CID="${CIDdir}/User-ID" && [[ ! -e ${CID} ]] && echo > ${CID}
keytxt="${CIDdir}/keys" && [[ ! -d ${keytxt} ]] && mkdir ${keytxt}
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ ! -e "/bin/ShellBot.sh" ]] && wget -O /bin/ShellBot.sh https://raw.githubusercontent.com/ChumoGH/VPSbot/main/ShellBot.sh &> /dev/null
[[ -e /etc/texto-bot ]] && rm /etc/texto-bot
LINE=" ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"


# Importando API
source ShellBot.sh

msj_add () {
          ShellBot.sendMessage --chat_id ${1} \
                            --reply_to_message_id "${1}" \
                            --text "<i>$(echo -e $bot_retor)</i>" \
                            --parse_mode html
}

#FUNCION DESTRUIR ID
unset i
for i in $(cat /etc/ADM-db/User-ID | awk '{print $3}'); do 
[[ $(date -d $i +%s) -ge $(date -d $(date '+%C%y-%m-%d') +%s) ]] || {
idlog=$(cat /etc/ADM-db/User-ID | grep "$i" | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig')
sed -i "/${idlog}/d" /etc/ADM-db/User-ID
          bot_retor="  🎊 𝙱𝚒𝚎𝚗𝚟𝚎𝚗𝚒𝚍𝚘  Nuevamente 𝚊𝚕  𝙱𝚘𝚝𝙶𝚎𝚗  𝙲𝚑𝚞𝚖𝚘𝙶𝙷-𝙰𝙳𝙼  🎊\n"
          bot_retor+="Desafortunadamente tu Membresia ha Finalizado\n"
          bot_retor+="Fecha de Corte : $i \n"
          bot_retor+="Si tienes Dudas, Contacta con $(cat < /etc/ADM-db/resell)\n"
          bot_retor+="$LINE\n"
          bot_retor+="Recuerda adquirir creditos, o Realizar una Colaboracion\n $(cat < /etc/mpayu) \n"
          bot_retor+="Para mantener tu acceso al BotGen Recuerda Mostrar tu Token de Donacion o Compra\n"
          bot_retor+="$LINE\n"
msj_add ${idlog}
}
done