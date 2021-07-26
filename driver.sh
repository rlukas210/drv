#!/bin/bash

set -e
vuser(){
if [ "$(id -u)" != "0" ]; then
echo
echo "Voce deve executar este script como root! "
exit 1
else
echo "Voce e root!"
fi
}

verpasta(){
if [ ! -d /etc/X11/xorg.conf.d ]; then
echo "Pasta xorg.conf.d nao encontrada"
echo "em /etc/X11 ;"
echo "criando pasta..."
sleep 2
mkdir -p /etc/X11/xorg.conf.d
else
echo "Pasta encontrada"
fi
}


crfile(){
echo "Criando arquivo..."

echo 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
EndSection' > /etc/X11/xorg.conf.d/40-libinput.conf

echo "Arquivo criado com sucesso!"
echo "O sistema ira agora"
echo "reiniciar o servidor X"
echo "para carregar as devidas alteracoes."
}

vuser
sleep 2 && clear
verpasta
sleep 2 && clear
crfile

sleep 3
clear
echo "Feche todos os programas"
echo "e salve seu trabalho."
echo ""
echo ""
echo ""
read -p "Pressione qualquer tecla para continuar..."

systemctl restart lightdm
exit

