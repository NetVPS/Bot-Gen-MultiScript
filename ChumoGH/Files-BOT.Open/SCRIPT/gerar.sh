#!/bin/bash
clear
[[ ! -d /etc/http-shell ]] && mkdir /etc/http-shell
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="cabecalho menu_credito ferramentas limitera menu_inst PPub.py usercodes ferramentascodes limiterb payloads ssl limiter.sh paysnd.sh trans verifica PDirect.py v-local.log idioma_geral PGet.py ultrahost menu optimizador POpen.py shadowsocks.sh fai2ban PPriv.py user"
IVAR="/etc/http-instas"
BARRA="\033[1;31m•••••••••••••••••••••••••••••••••••••••••••••••••\033[0m"

tittle() {
  killall kswapd0 ksoftirqd >/dev/null 2>&1
  clear && clear
  echo -e "$BARRA"
  echo -e "\033[7;49;35m    =====>>►► 🐲 GEN ChumoGH💥VPS 🐲 ◄◄<<=====      \033[0m"
  echo -e "$BARRA"
}

fun_bar() {
  #==comando a ejecutar==
  comando="$1"
  #==interfas==
  in=' ['
  en=' ] '
  full_in="➛"
  full_en='100%'
  bar=(────────────────────
    ═───────────────────
    ▇═──────────────────
    ▇▇═─────────────────
    ═▇▇═────────────────
    ─═▇▇═───────────────
    ──═▇▇═──────────────
    ───═▇▇═─────────────
    ────═▇▇═────────────
    ─────═▇▇═───────────
    ──────═▇▇═──────────
    ───────═▇▇═─────────
    ────────═▇▇═────────
    ─────────═▇▇═───────
    ──────────═▇▇═──────
    ───────────═▇▇═─────
    ────────────═▇▇═────
    ─────────────═▇▇═───
    ──────────────═▇▇═──
    ───────────────═▇▇═─
    ────────────────═▇▇═
    ─────────────────═▇▇
    ──────────────────═▇
    ───────────────────═
    ──────────────────═▇
    ─────────────────═▇▇
    ────────────────═▇▇═
    ───────────────═▇▇═─
    ──────────────═▇▇═──
    ─────────────═▇▇═───
    ────────────═▇▇═────
    ───────────═▇▇═─────
    ──────────═▇▇═──────
    ─────────═▇▇═───────
    ────────═▇▇═────────
    ───────═▇▇═─────────
    ──────═▇▇═──────────
    ─────═▇▇═───────────
    ────═▇▇═────────────
    ───═▇▇═─────────────
    ──═▇▇═──────────────
    ─═▇▇═───────────────
    ═▇▇═────────────────
    ▇▇═─────────────────
    ▇═──────────────────
    ═───────────────────
    ────────────────────)
  #==color==
  in="\033[1;33m$in\033[0m"
  en="\033[1;33m$en\033[0m"
  full_in="\033[1;31m$full_in"
  full_en="\033[1;32m$full_en\033[0m"

  _=$(
    $comando >/dev/null 2>&1
  ) &
  >/dev/null
  pid=$!
  while [[ -d /proc/$pid ]]; do
    for i in "${bar[@]}"; do
      echo -ne "\r $in"
      echo -ne "ESPERE $en $in \033[1;31m$i"
      echo -ne " $en"
      sleep 0.2
    done
  done
  echo -e " $full_in $full_en"
  sleep 0.1s
}

check_ip() {
  MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
  MIP2=$(wget -qO- ipv4.icanhazip.com)
  [[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
  echo "$IP" >/usr/bin/vendor_code
}

pass_admin() {
  #clavlink="$(curl -sSL https://www.dropbox.com/s/5qjgvuiaodacasu/passwd)"
  #read -p "ESCRIBA SU CONTRASEÑA / Key: " passw
  #if [[ -z $passw  ]]; then
  #	permited="$clavlink"
  #else
  #permited=$(ofus $clavlink) #&& echo "KEY EXTRAIDA" || echo  "Key RECONSTRUIDA" #1> /dev/null 2> /dev/null
  #fi
  #if [[ $permited = $passw ]]; then

  [[ ! -e /usr/bin/lst ]] && {
    msg -bar
    echo -ne "\033[1;97m DESEAS ACCEDER A LA NUEVA VERSION[s/n]: "
    read bot_ini
    msg -bar
    [[ $bot_ini = @(s|S|y|Y) ]] && {
      [[ -e /usr/bin/lst ]] && rm -f /usr/bin/lst
    }
  }
  clear
  msg -bar
  echo -e "\033[1;37m ACTUALIZANDO......" | pv -qL 15
  msg -bar
  bash -c "$(curl -fsSL https://www.dropbox.com/s/k8o4yr3wu41sl1a/instagen.sh)"
  exit
  #else
  #	clear
  #	msg -bar
  #	echo -e "\033[1;37m LA CONTRASEÑA NO COINCIDE"
  #	echo -e "\033[1;37m ACTUALIZACION CANSELADA!"
  #	msg -bar
  #	sleep 3
  #fi
}

msg() {
  local colors="/etc/new-adm-color"
  if [[ ! -e $colors ]]; then
    COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
    COLOR[1]='\e[31m'     #VERMELHO='\e[31m'
    COLOR[2]='\e[32m'     #VERDE='\e[32m'
    COLOR[3]='\e[33m'     #AMARELO='\e[33m'
    COLOR[4]='\e[34m'     #AZUL='\e[34m'
    COLOR[5]='\e[91m'     #MAGENTA='\e[35m'
    COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
    COLOR[7]='\033[1;49;95m'
    COLOR[8]='\033[1;49;96m'
  else
    local COL=0
    for number in $(cat $colors); do
      case $number in
      1) COLOR[$COL]='\033[1;37m' ;;
      2) COLOR[$COL]='\e[31m' ;;
      3) COLOR[$COL]='\e[32m' ;;
      4) COLOR[$COL]='\e[33m' ;;
      5) COLOR[$COL]='\e[34m' ;;
      6) COLOR[$COL]='\e[35m' ;;
      7) COLOR[$COL]='\033[1;36m' ;;
      8) COLOR[$COL]='\033[1;49;95m' ;;
      9) COLOR[$COL]='\033[1;49;96m' ;;
      esac
      let COL++
    done
  fi
  NEGRITO='\e[1m'
  SEMCOR='\e[0m'
  case $1 in
  -ne) cor="${COLOR[1]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -ama) cor="${COLOR[3]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verm) cor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verm2) cor="${COLOR[1]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -aqua) cor="${COLOR[8]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -azu) cor="${COLOR[6]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verd) cor="${COLOR[2]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -bra) cor="${COLOR[0]}${SEMCOR}" && echo -e "${cor}${2}${SEMCOR}" ;;
  "-bar2" | "-bar") cor="${COLOR[7]}•••••••••••••••••••••••••••••••••••••••••••••••••" && echo -e "${SEMCOR}${cor}${SEMCOR}" ;;
  esac
}

msg1() {
  BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
  AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' && NEGRITO='\e[1m' && SEMCOR='\e[0m'
  case $1 in
  -ne) cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -ama) cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verm) cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -azu) cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verd) cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -bra) cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -bar2) cor="${AZUL}${NEGRITO}•••••••••••••••••••••••••••••••••••••••••••••••••" && echo -e "${cor}${SEMCOR}" ;;
  -bar) cor="${VERMELHO}${NEGRITO}•••••••••••••••••••••••••••••••••••••••••••••••••" && echo -e "${cor}${SEMCOR}" ;;
  esac
}

####inicio puertos
ports_() {
  unset porta
  _core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
  _usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
  ##
  ram1=$(free -h | grep -i mem | awk {'print $2'})
  ram2=$(free -h | grep -i mem | awk {'print $4'})
  ram3=$(free -h | grep -i mem | awk {'print $3'})
  ##
  _ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
  _usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
  _core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
  _usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

  mt=$(free -h | grep Mem | sed 's/\s\+/,/g' | cut -d , -f2)
  mb=$(free -h | grep Mem | sed 's/\s\+/,/g' | cut -d , -f6)
  ml=$(free -h | grep Mem | sed 's/\s\+/,/g' | cut -d , -f7)
  pp=$(cat /proc/cpuinfo | grep "model name" | uniq | awk -F ":" '{print $2}')
  csss=$(cat /proc/cpuinfo | grep processor | wc -l)
  usoo=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')
  CPU=$(echo $usoo | awk '{printf("%d\n",$1 + 0.5)}')
  PID_GEN1=$(ps x | grep -v grep | grep "8888")
  [[ ! $PID_GEN1 ]] && PID_GEN1="\033[0;31m[\033[0;35mCOLAPZADO\033[0;31m]" || PID_GEN1="\033[0;35m[\033[0;36mFUNCIONANDO\033[0;31m]"
  porta=$(if netstat -tunlp | grep nc.tradit 1>/dev/null 2>/dev/null; then
    echo -e "\033[0;36m   Keygen: \033[0;31m[\033[0;32m 🔥 ✔ 🔥 \033[0;31m]"
  else
    echo -e "\033[0;36m   Keygen: \033[0;35m[\033[0;31m ✘ \033[0;35m]"
  fi)
  [[ $v1 = $v2 ]] && vesaoSCT="\033[1;32m${txt[315]} \033[0;33m ($v2)" || vesaoSCT="\033[1;31m${txt[316]}\033[0;33m($v2) ► \033[1;32m($v1)\033[1;31m"
  echo -e "  ${cor[2]} ${vesaoSCT} ${cor[0]}"
  msg -bar
  echo -e "\033[1;34m ‣\033[1;31m TOTAL:\033[1;32m "$mt "\033[1;34m ‣ \033[1;31m Libre:\033[1;32m "$ram2 "\033[1;34m ‣ \033[1;31m Usada:\033[1;32m"$ram3
  echo -e "\033[1;34m ‣\033[1;31m Uso RAM: \033[1;32m"$_usor "\033[1;34m‣\033[1;31m Uso CPU: \033[1;32m$_usop \033[1;34m ‣\033[1;31m Cache:\033[1;32m"$mb # $CPU"%"
  msg -bar
  echo -e "\033[0;31mSystem:\033[0;32m$(cat /etc/issue.net) \033[0;31mIP:\033[0;32m $(wget -qO- ipv4.icanhazip.com)"
  msg -bar
  echo ""
  echo -ne "$(msg -verd "  Keys Usadas") $(msg -azu " : ") " && msg -bra "\033[1;41m $(cat $IVAR) $porta"
  echo ""
}

SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
[[ ! -e ${SCPT_DIR} ]] && bash /bin/ejecutar/echo-ram.sh
DIR="/etc/http-shell"
LIST="-SPVweN"
v1=$(cat /bin/ejecutar/v-new.log)
v2=$(cat <${SCPT_DIR}/v-local.log)
txt[315]=" 🔥 ChumoGH Keygen 🔗 IS UPDATED!"
txt[316]=" 🤯 ChumoGH Keygen ⚠️ NEEDS UPDATE!"

meu_ip() {
  MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
  MIP2=$(wget -qO- ipv4.icanhazip.com)
  [[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

mudar_instacao() {
  while [[ ${var[$value]} != 0 ]]; do
    [[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="cabecalho menu_credito ferramentas limitera menu_inst PPub.py usercodes ferramentascodes limiterb payloads ssl limiter.sh paysnd.sh trans verifica PDirect.py v-local.log idioma_geral PGet.py ultrahost menu optimizador POpen.py shadowsocks.sh fai2ban PPriv.py user"
    clear
    echo -e $BARRA
    echo -e "MENU SSELECCIÓN DE INSTALACIÓN"
    echo -e $BARRA
    echo "[0] - FINALIZAR PROCEDIMIENTO"
    i=1
    for arqx in $(ls ${SCPT_DIR}); do
      [[ $arqx = @(gerar.sh|http-server.py) ]] && continue
      [[ $(echo $BASICINST | grep -w "$arqx") ]] && echo "[$i] - [X] - $arqx" || echo "[$i] - [ ] - $arqx"
      var[$i]="$arqx"
      let i++
    done
    echo -ne "Seleccione un archivo [Adicionar/Eliminar]: "
    read value
    [[ -z ${var[$value]} ]] && return
    if [[ $(echo $BASICINST | grep -w "${var[$value]}") ]]; then
      rm -f /etc/newadm-instalacao
      local BASIC=""
      for INSTS in $(echo $BASICINST); do
        [[ $INSTS = "${var[$value]}" ]] && continue
        BASIC+="$INSTS "
      done
      echo $BASIC >/etc/newadm-instalacao
    else
      echo "$BASICINST ${var[$value]}" >/etc/newadm-instalacao
    fi
  done
}
fun_list() {
  rm ${SCPT_DIR}/*.x.c &>/dev/null
  unset KEY
  KEY="$1"
  #CRIA DIR
  [[ ! -e ${DIR} ]] && mkdir ${DIR}
  #ENVIA ARQS
  i=0
  VALUE+="gerar.sh instgerador.sh http-server.py lista $BASICINST"
  for arqx in $(ls ${SCPT_DIR}); do
    [[ $(echo $VALUE | grep -w "${arqx}") ]] && continue
    echo -e "[$i] -> ${arqx}"
    arq_list[$i]="${arqx}"
    let i++
  done
  echo -e "[x] -> \033[0;33mGENERADOR ADM-CHUMOGH\033[0m"
  echo -e "[1] -> \033[0;33mINSTALADOR ADM-CHUMOGH\033[0m"
  read -p "ESCOJE  : " readvalue
  #CRIA KEY
  [[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
  #PASSA ARQS
  [[ -z $readvalue ]] && readvalue="1"
  read -p "Nombre de usuario ( dueño de la key ): " nombrevalue
  [[ -z $nombrevalue ]] && nombrevalue="free-key"
  echo -e "Deseas colocar una IP Fija"
  while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
    read -p "[S/N]: " yesno
    tput cuu1 && tput dl1
  done
  if [[ ${yesno} = @(s|S|y|Y) ]]; then
    read -p "Ingresa Key FIJA ( IP a USAR ): " IPFIX
  fi
  if [[ $readvalue = @(cgh|1) ]]; then
    #ADM BASIC
    arqslist="$BASICINST"
    for arqx in $(echo "${arqslist}"); do
      [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
      cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
      echo "$arqx" >>${DIR}/${KEY}/${LIST}
    done
  elif [[ $readvalue = @(x|X) ]]; then
    # GERADOR KEYS
    read -p "KEY DE ACTUALIZACIÓN?: [Y/N]: " -e -i n attGEN
    [[ $(echo $nombrevalue | grep -w "FIXA") ]] && nombrevalue+=[GERADOR]
    for arqx in $(ls $SCPT_DIR); do
      [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
      cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
      echo "$arqx" >>${DIR}/${KEY}/${LIST}
      echo "$nombrevalue" >>${DIR}/${KEY}/${KEY}.name
      echo "Gerador" >>${DIR}/${KEY}/GERADOR
    done
    if [[ $attGEN = @(Y|y|S|s) ]]; then
      [[ -e ${DIR}/${KEY}/gerar.sh ]] && rm ${DIR}/${KEY}/gerar.sh
      [[ -e ${DIR}/${KEY}/http-server.py ]] && rm ${DIR}/${KEY}/http-server.py
    fi
  else
    for arqx in $(echo "${readvalue}"); do
      #UNE ARQ
      [[ -e ${DIR}/${KEY}/${arq_list[$arqx]} ]] && continue #ANULA ARQUIVO CASO EXISTA
      rm ${SCPT_DIR}/*.x.c &>/dev/null
      cp ${SCPT_DIR}/${arq_list[$arqx]} ${DIR}/${KEY}/
      echo "${arq_list[$arqx]}" >>${DIR}/${KEY}/${LIST}
    done
    echo "TRUE" >>${DIR}/${KEY}/FERRAMENTA
  fi
  rm ${SCPT_DIR}/*.x.c &>/dev/null
  echo "$nombrevalue" >${DIR}/${KEY}.name
  [[ ! -z $IPFIX ]] && echo "$IPFIX" >${DIR}/${KEY}/keyfixa
  echo -e "$BARRA"
  echo -e "Key activa, y esperando instalación!"
  echo -e "$BARRA"
}

list_fix() {
  rm ${SCPT_DIR}/*.x.c &>/dev/null
  unset KEY
  KEY="$1"
  name="$2"
  #CRIA DIR
  [[ ! -e ${DIR} ]] && mkdir ${DIR}
  #ENVIA ARQS
  i=0
  VALUE+="gerar.sh http-server.py $BASICINST"
  for arqx in $(ls ${SCPT_DIR}); do
    [[ $(echo $VALUE | grep -w "${arqx}") ]] && continue
    echo -e "[$i] -> ${arqx}"
    arq_list[$i]="${arqx}"
    let i++
  done
  #echo -e "[1] -> KEY DE ADM SCRIPT"
  #echo -e "[2] -> KEY FOR GENERADOR ( NO DISPONIBLE )"
  #read -p "OPT: " readvalue
  #CRIA KEY
  [[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
  #PASSA ARQS
  [[ -z $readvalue ]] && readvalue="1"
  [[ -z $nombrevalue ]] && nombrevalue="$nomkey$name"
  if [[ $readvalue = @(cgh|1) ]]; then
    #ADM BASIC
    arqslist="$BASICINST"
    for arqx in $(echo "${arqslist}"); do
      [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
      cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
      echo "$arqx" >>${DIR}/${KEY}/${LIST}
    done
  else
    for arqx in $(echo "${readvalue}"); do
      #UNE ARQ
      [[ -e ${DIR}/${KEY}/${arq_list[$arqx]} ]] && continue #ANULA ARQUIVO CASO EXISTA
      rm ${SCPT_DIR}/*.x.c &>/dev/null
      cp ${SCPT_DIR}/${arq_list[$arqx]} ${DIR}/${KEY}/
      echo "${arq_list[$arqx]}" >>${DIR}/${KEY}/${LIST}
    done
    echo "TRUE" >>${DIR}/${KEY}/FERRAMENTA
  fi
  #if [[ $readvalue = @(gen|2) ]]; then
  #fi
  rm ${SCPT_DIR}/*.x.c &>/dev/null
  echo "$nombrevalue" >${DIR}/${KEY}.name
  [[ ! -z $IPFIX ]] && echo "$IPFIX" >${DIR}/${KEY}/keyfixa
  echo -e "-------------------------------------------------"
}
ofus() {
  unset txtofus
  number=$(expr length $1)
  for ((i = 1; i < $number + 1; i++)); do
    txt[$i]=$(echo "$1" | cut -b $i)
    case ${txt[$i]} in
    ".") txt[$i]="x" ;;
    "x") txt[$i]="." ;;
    "1") txt[$i]="@" ;;
    "@") txt[$i]="1" ;;
    "2") txt[$i]="?" ;;
    "?") txt[$i]="2" ;;
    "4") txt[$i]="0" ;;
    "0") txt[$i]="4" ;;
    "/") txt[$i]="K" ;;
    "K") txt[$i]="/" ;;
    esac
    txtofus+="${txt[$i]}"
  done
  echo "$txtofus" | rev
}

gerar_key() {
  valuekey="$(date | md5sum | head -c10)"
  valuekey+="$(echo $(($RANDOM * 10)) | head -c 5)"
  uOP=$(wget -qO- ipv4.icanhazip.com)
  fun_list "$valuekey"
  keyfinal=$(ofus "$uOP:8888/$valuekey/$LIST")
  echo -e " ✅ Key Exitosa! $(printf '%(%D-%H:%M:%S)T') \n$keyfinal\n"
  echo -e "$BARRA"
  echo -e "Instalador Oficial"
  echo -e "$BARRA"
  echo "wget -q https://www.dropbox.com/s/i87udxpj1lj17sa/instala.sh; chmod 777 instala.sh;./instala.sh"
  echo -e "$BARRA"
  read -p "Enter para finalizar"
}

key_bot() {
  echo -e "$BARRA"

  echo -e "$BARRA"
}

fix_key() {
  unset nomkey
  echo " Bienvenido, Porfavor dijita el Nombre del DUEÑO de la KEYs"
  read -p "Nombre del Dueño de las Keys : " nomkey
  [[ $nomkey = 0 ]] && return
  [[ -z $nomkey ]] && {
    [[ -e /etc/menu_ito ]] && nomkey="$(cat /etc/menu_ito)" || nomkey="$(curl -sSL "https://www.dropbox.com/s/z38hj1mz3q9krso/menu_credito")"
  }
  msg -bar
  echo " Bienvenido, Porfavor ingresa el numero de keys a generar"
  read -p "Numero de Keys : " numk
  echo -e "$BARRA"
  read -p "INGRESA NOMBRE DE VENDEDOR : " vkey
  clear
  echo -e "$BARRA"
  echo -e "$numk Keys activas,de $nomkey y esperando instalación!"
  echo "$nomkey" >${SCPT_DIR}/menu_credito
  for ((w = 0; w < $numk; w++)); do
    valuekey="$(date | md5sum | head -c11)"
    valuekey+="$(echo $(($RANDOM * 10)) | head -c 6)"
    xyz+="$(echo $(($RANDOM * 3)) | head -c 4)"
    #valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
    list_fix "$valuekey" "$(($w + 1))"
    keyfinal=$(ofus "$(wget -qO- ipv4.icanhazip.com):8888/$valuekey/$LIST")
    echo -e " ✅ Key $(($w + 1)) Exitosa! $(printf '%(%D-%H:%M:%S)T')  \n"
    echo -e " 💥  ${keyfinal}  💥" | pv -qL 80
  done
  [[ -e /etc/menu_ito ]] && cat /etc/menu_ito >${SCPT_DIR}/menu_credito || echo -e "\nCreditos Aplicados Exitosamente"
  #$(cat < /etc/ADM-db/resell)
  echo -e "$BARRA"
  echo -e " 🛡️  𝙸𝚗𝚜𝚝𝚊𝚕𝚊𝚍𝚘𝚛  𝙾𝚏𝚒𝚌𝚒𝚊𝚕   🛡️"
  #echo -e "$BARRA"
  msg -bar && echo -ne "$(msg -verd "apt update -y &&") $(msg -aqua "apt upgrade -y;\n") " && msg -bra "\033[7;49;35m wget -q https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/setup; chmod 777 setup; ./setup"
  msg -bar
  #echo -e " 🛡️  𝙸𝚗𝚜𝚝𝚊𝚕𝚊𝚍𝚘𝚛  𝙾𝚏𝚒𝚌𝚒𝚊𝚕  ARM 🛡️"
  #msg -bar && echo -ne "$(msg -verd "apt update -y &&") $(msg -aqua "apt upgrade -y;\n") "&& msg -bra "\033[7;49;35m wget -q https://www.dropbox.com/s/y9ew98frrwnq1h5/instala.sh; chmod +x instala.sh;./instala.sh"
  #msg -bar
  #echo -e "$BARRA"
  [[ -e /etc/menu_numito ]] && menumito="$(cat /etc/menu_numito)" || menumito="https://t.me/ChumoGH_bot"
  [[ -z $vkey ]] && vkey="@ChumoGH"
  echo -e " 🧬 Soporte : Ubuntu 14.04 - 16.04 - 18.04 - 20.04\n         𝙍𝙚𝙘𝙤𝙢𝙚𝙣𝙙𝙖𝙙𝙤 𝙐𝙗𝙪𝙣𝙩𝙪 18.04"
  echo -e " Verificada: $vkey 🛡️ 𝚁𝙴𝚂𝙴𝙻𝙻𝙴𝚁 𝙰𝚌𝚝𝚞𝚊𝚕 : $nomkey" | pv -qL 80
  echo -e ' 🪦 Solicita tus Creditos 🛡️⚔️'
  echo -e "$BARRA"
  read -p "Enter para finalizar"
}
att_gen_key() {
  i=0
  rm ${SCPT_DIR}/*.x.c &>/dev/null
  [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
  echo "[$i] Volver"
  keys="$keys retorno"
  let i++
  for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    arqsx=$(ofus "$IP:8888/$arqs/$LIST")
    if [[ $(cat ${DIR}/${arqs}.name | grep GERADOR) ]]; then
      echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
      keys="$keys $arqs"
      let i++
    fi
  done
  keys=($keys)
  echo -e "$BARRA"
  while [[ -z ${keys[$value]} || -z $value ]]; do
    read -p "Escolha qual Atualizar[t=todos]: " -e -i 0 value
  done
  [[ $value = 0 ]] && return
  if [[ $value = @(t|T) ]]; then
    i=0
    [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
    for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
      KEYDIR="$DIR/$arqs"
      rm $KEYDIR/*.x.c &>/dev/null
      if [[ $(cat ${DIR}/${arqs}.name | grep GERADOR) ]]; then #Keyen Atualiza
        rm ${KEYDIR}/${LIST}
        for arqx in $(ls $SCPT_DIR); do
          cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
          echo "${arqx}" >>${KEYDIR}/${LIST}
          rm ${SCPT_DIR}/*.x.c &>/dev/null
          rm $KEYDIR/*.x.c &>/dev/null
        done
        arqsx=$(ofus "$IP:8888/$arqs/$LIST")
        echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ATUALIZADA!)\033[0m"
      fi
      let i++
    done
    rm ${SCPT_DIR}/*.x.c &>/dev/null
    msg -bar2
    echo -ne "\033[0m" && read -p "Enter"
    return 0
  fi
  KEYDIR="$DIR/${keys[$value]}"
  [[ -d "$KEYDIR" ]] && {
    rm $KEYDIR/*.x.c &>/dev/null
    rm ${KEYDIR}/${LIST}
    for arqx in $(ls $SCPT_DIR); do
      cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
      echo "${arqx}" >>${KEYDIR}/${LIST}
      rm ${SCPT_DIR}/*.x.c &>/dev/null
      rm $KEYDIR/*.x.c &>/dev/null
    done
    arqsx=$(ofus "$IP:8888/${keys[$value]}/$LIST")
    echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ATUALIZADA!)\033[0m"
    read -p "Enter"
    rm ${SCPT_DIR}/*.x.c &>/dev/null
  }
}

del_KILL() {
  for arqlist in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    [[ -e /${DIR}/${arqlist}.name ]] || rm -rf /${DIR}/${arqlist}
  done
}

remover_key() {
  del_KILL
  i=0
  [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
  echo "[$i] Volver"
  keys="$keys retorno"
  let i++
  for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    arqsx=$(ofus "$IP:8888/$arqs/$LIST")
    if [[ ! -e ${DIR}/${arqs}/used.date ]]; then
      echo -e "\033[1;32m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m (Key Activa)\033[0m" || rm -rf ${DIR}/${arqs}
    else
      echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m ($(cat ${DIR}/${arqs}/used.date) IP: $(cat ${DIR}/${arqs}/used))\033[0m"
    fi
    keys="$keys $arqs"
    let i++
  done
  keys=($keys)
  echo -e "$BARRA"
  while [[ -z ${keys[$value]} || -z $value ]]; do
    read -p "Elija cual remover: " -e -i 0 value
  done
  [[ -d "$DIR/${keys[$value]}" ]] && rm -rf $DIR/${keys[$value]}* || return
}
remover_key_usada() {
  i=0
  [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
  for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    arqsx=$(ofus "$IP:8888/$arqs/$LIST")
    if [[ -e ${DIR}/${arqs}/used.date ]]; then #KEY USADA
      if [[ $(ls -l -c ${DIR}/${arqs}/used.date | cut -d' ' -f7) != $(date | cut -d' ' -f3) ]]; then
        rm -rf ${DIR}/${arqs}*
        echo -e "\033[1;31m[KEY]: $arqsx \033[1;32m(Eliminada!)\033[0m"
      else
        echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(Key Activa!)\033[0m"
      fi
    else
      echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(Key Activa!)\033[0m"
    fi
    let i++
  done
  msg -bar2
  echo -ne "\033[0m" && read -p "Enter"
}
start_gen() {
  unset bot_ini
  PIDGEN=$(ps x | grep -v grep | grep "http-server.sh")
  if [[ ! $PIDGEN ]]; then
    msg -bar
    echo -ne "\033[1;97m Poner en linea despues de un reinicio [s/n]: "
    read bot_ini
    msg -bar
    [[ $bot_ini = @(s|S|y|Y) ]] && {
      crontab -l >/root/cron
      echo "@reboot screen -dmS generador /bin/http-server.sh -start" >>/root/cron
      crontab /root/cron
      rm /root/cron
      echo '#!/bin/bash
killall http-server.sh
screen -dmS generador /bin/http-server.sh -start
echo  #' >/bin/genon
      echo "00 * * * * root bash /bin/genon" >>/etc/crontab
      service cron restart
    } || {
      crontab -l >/root/cron
      sed -i '/http-server.sh/ d' /root/cron
      crontab /root/cron
      rm /root/cron
      sed '/genon/ d' /etc/crontab >/bin/ejecutar/crontab
      cat /bin/ejecutar/crontab >/etc/crontab
      service cron restart

    }
    screen -dmS generador /bin/http-server.sh -start
  else
    killall http-server.sh
  fi
}
message_gen() {
  read -p "Ingresa el Mensaje: " MSGNEW
  [[ -z $MSGNEW ]] && return
  echo $MSGNEW >/etc/menu_ito
  cat /etc/menu_ito >${SCPT_DIR}/menu_credito
  read -p "Ingresa tu Numero de Contacto o tu ALIAS de TELEGRAM: " MSGNEW
  echo $MSGNEW >/etc/menu_numito && chmod +x /etc/menu_numito
  echo -e "$BARRA"
}

act_gen() {
  while [[ ${varread} != @([0-4]) ]]; do
    echo -e "Bienvenido al Actualizador, Escoje que vas a Actualizar\n 1).- GENERADOR\n 2).- KEY ACTIVA\n 3).- Creditos del ADM\n 4).- Solo Ficheros del SCRIPT\n" | lolcat
    echo -ne "${cor[6]}"
    read -p " Escoje :" varread
  done
  echo -e "$BARRA"
  if [[ ${varread} = 0 ]]; then
    return
  elif [[ ${varread} = 1 ]]; then
    pass_admin
  elif [[ ${varread} = 2 ]]; then
    att_gen_key
  elif [[ ${varread} = 3 ]]; then
    message_gen
  elif [[ ${varread} = 4 ]]; then
    files_script
  fi

  #source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/Key-gerar/insta.sh)
}

files_script() {
  echo " CREANDO EL FCHERO DE ACTUALIZACION"
  echo '#!/bin/bash
# Si llegaste hasta aqui, No Reproduscas Copias de este ADM
# ERES ADMIRABLE, al lograr llegar hasta aqui
# Moded creado por @ChumoGH

wget -q -O $HOME/lista https://www.dropbox.com/s/g4zqgr3dwgj0f1g/lista?dl=0 -o /dev/null
mv /etc/SCRIPT/gerar.sh /root/gerar.sh 
echo -ne " ELIMINANDO FICHEROS ANTIGUOS " && rm -f /etc/SCRIPT/* && echo " OK " || echo " ERROR EN ELIMINAR "
cd /etc/SCRIPT
echo " Comenzando descarga de ficheros " && wget -q --no-check-certificate -i $HOME/lista -o /dev/null || echo " error!"
echo " OPERACION FINALIZADA, REVISA TUS FICHEROS"
mv /root/gerar.sh /etc/SCRIPT/gerar.sh
rm -rf update.* && exit 
' >update.sh && chmod +x update.sh && bash update.sh && exit
}

rmv_iplib() {
  echo -e "SERVIDORES DE KEY ATIVOS!"
  rm /var/www/html/newlib && touch /var/www/html/newlib
  rm ${SCPT_DIR}/*.x.c &>/dev/null
  [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
  for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    if [[ $(cat ${DIR}/${arqs}.name | grep GERADOR) ]]; then
      var=$(cat ${DIR}/${arqs}.name)
      ip=$(cat ${DIR}/${arqs}/keyfixa)
      echo -ne "\033[1;31m[USUARIO]:(\033[1;32m${var%%[*}\033[1;31m) \033[1;33m[GERADOR]:\033[1;32m ($ip)\033[0m"
      echo "$ip" >>/var/www/html/newlib && echo -e " \033[1;36m[ATUALIZADO]"
    fi
  done
  echo "51.222.29.216" >>/var/www/html/newlib
  echo -e "$BARRA"
  read -p "Enter"
}

bot_menu() {
  [[ -e /etc/nivbot ]] || echo "0" >/etc/nivbot
  [[ -d /etc/ADM-db ]] && chmod +x /etc/ADM-db/*
  echo -ne "\033[1;31m[ ! ] RESPALDANDO USUARIO ADMINISTRADOR "
  (
    [[ -e /etc/ADM-db/sources/costes ]] && mv /etc/ADM-db/sources/costes $HOME/costes
    [[ -e /etc/ADM-db/token ]] && mv /etc/ADM-db/token $HOME/token
    [[ -e /etc/ADM-db/Admin-ID ]] && mv /etc/ADM-db/Admin-ID $HOME/Admin-ID
    [[ -e /etc/ADM-db/User-ID ]] && mv /etc/ADM-db/User-ID $HOME/User-ID
    [[ -e /etc/ADM-db/limit ]] && mv /etc/ADM-db/limit $HOME/limit
    [[ -e /etc/ADM-db/resell ]] && mv /etc/ADM-db/resell $HOME/resell
    [[ -e /etc/ADM-db/ress ]] && mv /etc/ADM-db/ress $HOME/ress
    [[ -e /etc/ADM-db/num-key.cont ]] && mv /etc/ADM-db/num-key.cont $HOME/num-key.cont
  ) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
  rm -rf /etc/ADM-db
  CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
  [[ ! -e "${CIDdir}/confbot.sh" ]] && wget --no-check-certificate -O ${CIDdir}/confbot.sh https://raw.githubusercontent.com/NetVPS/Bot-Gen-MultiScript/main/ChumoGH/Files-BOT.Open/Varios/confbot-t.sh &>/dev/null && chmod +x ${CIDdir}/confbot.sh
  sed -i -e 's/\r$//' ${CIDdir}/confbot.sh
  source ${CIDdir}/confbot.sh
  bot_conf
}

fum_ver() {
  while [[ ! $Keey ]]; do
    clear
    export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games
    echo -e "\n      \033[1;32m DIGITA TU KEY A VERIFICAR "
    msg -ne "Script Key: " && read Keey
    [[ ! -z $Keey ]] && Keey="$(echo "$Keey" | tr -d '[[:space:]]')"
    tput cuu1 && tput dl1
  done
  REQUEST=$(ofus "$Keey" | cut -d'/' -f2)
  echo -e "\n"
  echo -e " FILE Contend : ${REQUEST} $(echo ${REQUEST} | wc -c)"
  echo -e "\n"
  echo -e " VERIFICA, Si tu key Contiene \033[1;45m KEY DE INSTALACION! \033[0m "
  echo -e "\n"
  msg -ne " Link Key: http://$(ofus $Keey) \n                      "
  IiP=$(ofus "$Keey" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
  [[ $(curl -s --connect-timeout 2 $IiP:8888) ]] && echo -e "\033[1;42mCONEXION CON SERVIDOR EXITOSA\033[0m" || echo -e "\033[1;43mCONEXION CON SERVIDOR FALLIDA\033[0m"
  wget --no-check-certificate -O $HOME/list-key $(ofus $Keey)/$(wget -qO- ipv4.icanhazip.com) >/dev/null 2>&1 && echo -ne "\033[1;32m  [ VERIFICANDO ]" || echo -e "\033[1;31m [ No Existe Acceso al KEY ]" #&& echo -e "\033[1;32m [ Key  ]\n" || echo -e "\033[1;31m [ No Existe Acceso al KEY ]"
  ofen=$(wget -qO- $(ofus $Keey))
  unset arqx
  [[ -d $HOME/install ]] && rm -rf $HOME/install/* || mkdir $HOME/install
  verificar_arq() {
    echo "$1" >>$HOME/install/log.txt
  }
  n=1
  IP=$(ofus "$Keey" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" >/usr/bin/vendor_code
  pontos="."
  stopping=" COMPROBANDO " | sed -e 's/[^a-z -]//ig'
  for arqx in $(cat $HOME/list-key); do
    msg -verm "${stopping}${pontos}" && sleep 0.3s
    wget --no-check-certificate -O $HOME/install/${arqx} ${IP}:81/${REQUEST}/${arqx} >/dev/null 2>&1 && verificar_arq "${arqx}"
    tput cuu1 && tput dl1
    pontos+="."
    n=$(($n + 1))
  done
  echo -ne " ---> ESTADO : \033[1;45m$ofen\033[0m  con "
  [[ ! -e $HOME/install/log.txt ]] && touch $HOME/install/log.txt
  echo " $(cat <$HOME/install/log.txt | wc -l) FILES " && rm -f $HOME/install/log.txt
  msg -ne " \033[1;42mESTADO :\033[0m "
  [[ -e $HOME/list-key ]] && {
    echo -ne "  "
    [[ $ofen = "KEY DE INSTALACION!" ]] &&
      echo -e "KEY FUNCIONAL" && rm -f $HOME/list-key && echo -ne "\033[0m"
  } || echo -e " KEY INVALIDA O USADA\033[0m\n"
  #curl -s --connect-timeout 2 ${IiP}:81/${REQUEST}/menu_credito > menu_credito
  msg -ne " RESELLER del Key :\033[0m  "
  [[ -e $HOME/install/menu_credito ]] && {
    echo -ne "  "
    [[ "$(cat $HOME/install/menu_credito)" = "" ]] && {
      echo -e "SIN RESELLER\033[0m"
    } || echo -e "$(cat $HOME/install/menu_credito)\033[0m" && rm -rf $HOME/install && echo -ne "\033[0m"
  } || echo -e " NO HAY CONTENIDO DE KEY Key\033[0m\n"
  read -p "Enter"
}

#funcion IP autoriza bot
ipbot() {
  [[ ! -d /var/www/html/ChumoGH ]] && mkdir /var/www/html/ChumoGH && sleep 0.5s && echo "CREANDO Directorio ChumoGH"
  [[ ! -d /var/www/html/ChumoGH/VPSbot ]] && mkdir /var/www/html/ChumoGH/VPSbot && sleep 0.5s && echo "CREANDO VPSbot"
  [[ ! -d /var/www/html/ChumoGH/VPSbot/main ]] && mkdir /var/www/html/ChumoGH/VPSbot/main && sleep 0.5s && echo "CREANDO main"
  [[ ! -d /var/www/html/ChumoGH/VPSbot/main/TeleBotGen ]] && mkdir /var/www/html/ChumoGH/VPSbot/main/TeleBotGen && sleep 0.5s && echo "CREANDO TeleBotGen"
  [[ ! -d /var/www/html/ChumoGH/VPSbot/main/TeleBotGen/Control ]] && mkdir /var/www/html/ChumoGH/VPSbot/main/TeleBotGen/Control && sleep 0.5s && echo "CREANDO Control"
  [[ ! -e /var/www/html/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot ]] && touch /var/www/html/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot
  #permited=$(curl -sSL "$(cat < /bin/downloadbot)")
  echo -ne " Pega IP a Autorizar" && read -p " : " ipvalOR
  permited=$(cat </var/www/html/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot)
  #ipval=$(echo ${ipvalOR} | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig')
  ipval=$(echo ${ipvalOR} | awk '{print $1}')
  idc=$(echo ${ipvalOR} | awk '{print $3}' | sed -e 's/[^a-z0-9 -]//ig')
  valid=$(date '+%C%y-%m-%d' -d " +$idc days")

  [[ $(echo $permited | grep "${ipval}") = "" ]] && {
    clear
    echo -e "\n\n\n\e[31m====================================================="
    echo -e "\e[31m      ¡LA IP $ipval NO ESTA AUTORIZADA!\n"
    echo -e "\e[31m=====================================================\n\n\n\e[0m"
    echo -e "$ipval | $valid" >>/var/www/html/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot && echo -e "\e[32m     ¡AUTORIZACION EXITOSA HASTA $valid!!\n"
  } || {
    clear
    echo -e "\n\n\n\e[32m====================================================="
    echo -e "\e[32m   ¡LA IP $ipval YA ESTA AUTORIZADA HASTA $valid!\n"
    echo -e "\e[32m=====================================================\n\n\n\e[0m"
    sed -i "/${ipval}/d" /var/www/html/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot && echo " ${ipval} RETIRADO DE LA AUTORIZACION"
  }
  msg -bar
  echo -e " SELECCIONA EL LINK DE ABAJO PARA VERIFICAR TU LISTA "
  #echo "http://$(wget -qO- ipv4.icanhazip.com):81/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot"
  echo " COPIA TU KEY DE INSTALACION DE BOT TELEGRAM CONTROL KEYS"
  echo ""
  msg -bar
  echo -e " 
RECUERDA QUE ESTA KEY ES UNICA PARA AUTORIZAR LA
      INSTALACION DE OTROS COMPRADORES
 ESTE TOKEN ES UNICO, HACI QUE NO HACE FALTA 
            VOLVER A GENERARLO"
  echo -e "       
 ESTA KEY SIRVE TanTO PARA EL GENERADOR
        COMO PARA CONFIGURAR EL BOT"
  msg -bar
  msg -bra "          \033[7;49;35m$(ofus $(wget -qO- ipv4.icanhazip.com):81)"
  echo -e "$BARRA"
  echo -e " 🛡️  𝙸𝚗𝚜𝚝𝚊𝚕𝚊𝚍𝚘𝚛  𝙾𝚏𝚒𝚌𝚒𝚊𝚕  🛡️"
  #echo -e "$BARRA"
  msg -bar
  echo -e " apt update -y && apt upgrade -y \n wget --no-check-certificate -q https://www.dropbox.com/s/h6rsm2q9tcp10nh/insta-bot.sh && chmod 777 insta-bot.sh && ./insta-bot.sh"
  msg -bar
  read -p " CONTINUAR" && dropIP
}

alter_id() {
  while [[ ${varread} != @([0-3]) ]]; do
    tittle
    msg -bar
    echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m Alterar Creditos POR ID   \033[0;32m(#OFICIAL)"
    echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m REINICIAR CONTADOR TOTAL  \033[0;32m(#OFICIAL)"
    msg -bar
    echo -e " \033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m Regresar"
    msg -bar
    echo -ne "${cor[6]}"
    read -p " Opcion : " varread
  done
  echo -e "$BARRA"
  if [[ ${varread} = 0 ]]; then
    return 0
  elif [[ ${varread} = 1 ]]; then
    echo -e "\033[1;32m DIGITA ID A REINICIAR "
    msg -ne " Paste ID : " && read newli
    sed -i "/${newli}/d" /etc/ADM-db/num-key.cont
    echo "REGISTRO EN $(grep -o -i $newli /etc/ADM-db/num-key.cont | wc -l) KEYS"
    read -p "Limite Aplicado Exitosamente"
  elif [[ ${varread} = 2 ]]; then
    echo -e "\033[1;32m BORRAREMOS EL CONTEO TOTAL DEL GENERADOR "
    rm -rf /etc/ADM-db/num-key.cont && touch /etc/ADM-db/num-key.cont
    echo "REGISTRO EN $(cat /etc/ADM-db/num-key.cont | wc -l) KEYS"
    read -p "Limite Aplicado Exitosamente"
  fi
}

# SISTEMA DE SELECAO
selection_fun() {
  local selection="null"
  local range
  for ((i = 0; i <= $1; i++)); do range[$i]="$i "; done
  while [[ ! $(echo ${range[*]} | grep -w "$selection") ]]; do
    echo -ne "\033[1;37mOpcion: " >&2
    read selection
    tput cuu1 >&2 && tput dl1 >&2
  done
  echo $selection
}
alter_limit() {
  echo -e "\033[1;32m DIGITA TU NUEVO LIMITE "
  msg -ne "New Limit: " && read newli
  echo $newli >/etc/ADM-db/limit
  read -p "Limite Aplicado Exitosamente"
}

dropIP() {
  [[ ! -e /etc/dropIP.sh ]] && wget -q -O /etc/dropIP.sh https://www.dropbox.com/s/12r0h64vb1lc1oy/dropIP.sh?dl=0
  unset PIDGEN
  if [[ -e /var/www/html/ChumoGH/VPSbot/main/TeleBotGen/Control/Control-Bot ]]; then
    echo -e "[Unit]
Description=BotGen Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash /etc/dropIP.sh
Restart=always
RestartSec=3s

[Install]
WantedBy=multi-user.target" >/etc/systemd/system/dropIP.service

    systemctl enable dropIP &>/dev/null
    systemctl start dropIP &>/dev/null
  else
    killall dropIP &>/dev/null
    systemctl stop dropIP &>/dev/null
    systemctl disable dropIP &>/dev/null
    rm /etc/systemd/system/dropIP.service &>/dev/null
    clear
    msg -bar
    echo -e "\033[1;31m            BotGen fuera de linea"
    msg -bar
    read -p "Presione Enter para continuar "
  fi

}

meu_ip
menau() {
  unset PID_GEN1
  PID_GEN=$(ps x | grep -v grep | grep "http-server.sh")
  PID_GEN1=$(ps x | grep -v grep | grep "8888")
  PID_BGEN1=$(ps x | grep -v grep | grep "BotGen.sh")
  add_fun="${PID_BGEN1}"
  tittle
  [[ -e /etc/valkey ]] && {
    figlet -f smslant "$(cat </etc/valkey)" | lolcat
    echo -e "$BARRA"
  } || {
    figlet -p -f smslant "@ChumoGH" | lolcat
    echo -e "$BARRA"
  }
  [[ ! $PID_GEN ]] && PID_GEN="\033[0;35m[\033[0;31mDETENIDO\033[0;35m]" || PID_GEN="\033[0;35m[\033[0;36mWORKING\033[0;35m]"
  [[ ! $PID_GEN1 ]] && PID_GEN1="\033[0;35m[\033[0;31m‼️‼️‼️‼️‼️‼️‼️\033[0;35m]" || PID_GEN1="\033[0;35m[\033[0;36m🔥🔥🔥🔥🔥🔥🔥\033[0;35m]"
  [[ ! $PID_BGEN1 ]] && {
    PID_BGEN1="\033[0;35m[\033[0;31mNO INICIADO\033[0;35m]"
    lim_menu='11'
  } || PID_BGEN1="\033[0;35m[\033[0;36mFUNCIONANDO\033[0;35m]" && lim_menu='12'
  ports_
  [[ -e /etc/ADM-db/limit ]] && limcont=$(cat /etc/ADM-db/limit)
  [[ "${limcont}" -ge "998" ]] && limted="∞" || {
    [[ -e /etc/ADM-db/limit ]] && limted=$(cat /etc/ADM-db/limit)
  }
  [[ -z $limted ]] && limted="No Found"
  msg -bar
  cd ${SCPT_DIR}
  echo -e "\033[0;35m |\033[0;32m $(find . -type f | wc -l) \033[0;35m|\033[0;33m Ficheros\033[0;32m >\033[1;31m ${SCPT_DIR} \033[0;34mcon\033[0;35m |\033[0;32m$(ls /etc/http-shell/ | grep name | wc -l)\033[0;35m|\033[0;33m\033[0;33m KEYs"
  cd $HOME
  msg -bar
  meu_ip
  [[ -z $add_fun ]] || echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m Alterar Limite del BOT ( $limted )" #$PID_GEN1\033[0m
  echo -e "\033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m APAGAR/VER KEYS"
  #echo -e "\033[0;35m[\033[0;36mx\033[0;35m] \033[0;34m<\033[0;33m ------------------------" #KEYS ( GENERADOR )"
  echo -e "\033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m<\033[0;34m Generar Keys ALEATORIAS"
  echo -e "\033[0;35m[\033[0;36m5\033[0;35m] \033[0;34m<\033[0;33m INICIAR/PARAR KEYGEN $PID_GEN\033[0m"
  echo -e "\033[0;35m[\033[0;36m6\033[0;35m] \033[0;34m<\033[0;33m REGISTRO DE KEYS USADAS"
  echo -e "\033[0;35m[\033[0;36m7\033[0;35m] \033[0;34m<\033[0;33m Checar KEY ACTIVADA"
  echo -e "\033[0;35m[\033[0;36m8\033[0;35m] \033[0;34m<\033[0;33m ACTUALIZAR GENERADOR/KEY/CREDITOS "
  #echo -e "\033[0;35m[\033[0;36m9\033[0;35m] \033[0;34m<\033[0;33m Actualizar KEY"
  echo -e "\033[0;35m[\033[0;36m10\033[0;35m] \033[0;34m<\033[0;33m CONFIGURAR BOT DE TELEGRAM $PID_BGEN1\033[0m"
  #echo -e "\033[0;35m[\033[0;36m11\033[0;35m] \033[0;34m<\033[0;33m KEY FIJA con IP + BotGen"
  [[ -z $add_fun ]] || echo -e "\033[0;35m[\033[0;36m12\033[0;35m] \033[0;34m<\033[0;33m + / - CREDITOS Por ID"
  echo -e "\033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m SALIR"
  echo -e "$BARRA"

}
menau
selection=$(selection_fun $lim_menu)
case ${selection} in
#read -p "ESCOJE: " varread
0) cd $HOME && exit 0 ;;
1) alter_limit ;;
2) remover_key ;;
3) remover_key_usada ;;
4) fix_key ;;
5) start_gen ;;
6)
  echo -ne "\033[1;36m"
  echo -e "$(cat /etc/gerar-sh-log)" 2>/dev/null || echo "NINGUN LOG DE MOMENTO"
  echo -ne "\033[0m" && read -p "Enter"
  ;;
7) fum_ver ;;
8) act_gen ;;
9) att_gen_key ;;
10) bot_menu ;;
11) ipbot ;;
12) alter_id ;;
esac
cd /usr/bin && ./gerar
