#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH
id1=$(free -h | grep -i mem | awk {'print $4'})
idM=$(echo $id1 |sed 's/[A-Z]//g')
idm=$(echo $idM |sed 's/[a-z]//g')
n=90
tiempo=$(printf '%(%D-%H:%M:%S)T') 
if [ "$n" -gt "$idm" ]; then 
echo $idm "Mbs  -  Limpiando y Reiniciado el " $tiempo >> /root/lm.log
echo $idm "Mbs  -  Limpiando y Reiniciado el " $tiempo >> /var/www/html/log.log
cat 
sudo sync
sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
killall kswapd0 > /dev/null 2>&1
killall ksoftirqd > /dev/null 2>&1
killall menu_inst > /dev/null 2>&1
rm -f /var/log/syslog*
killall -y 5s tcpdump > /dev/null 2>&1
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
rm -rf /tmp/*
sudo apt autoremove -y
sudo rm /var/lib/apt/lists/lock && sudo rm /var/cache/apt/archives/lock && sudo rm /var/lib/dpkg/lock
echo $idm "Mbs  -  LISTO " $tiempo >> /root/lm.log
else 
echo $n "Mbs - Esta bajo el limite " $id1 " el " $tiempo >> /root/lm.log
echo $n "Mbs - Esta bajo el limite " $id1 " el " $tiempo >> /var/www/html/log.log
sudo sync
sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
killall kswapd0
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
rm -rf /tmp/*
sudo apt autoremove -y
fi
[[ -e /bin/ejecutar/autt ]] && 
{ 
[[ -e /bin/ejecutar/autt ]] && name=$(cat < /bin/ejecutar/autt)
echo "Haciendo COPIA DE USUARIOS EN $name " $tiempo >> /root/lm.log
echo "Haciendo COPIA DE USUARIOS EN $name " $tiempo >> /var/www/html/log.log
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/autobackup.sh) 
} || {
[[ -e /var/www/html/backup ]] && rm /var/www/html/backup
echo "NO FileSystem " $tiempo >> /root/lm.log
echo "No FileSystem " $tiempo >> /var/www/html/log.log
}