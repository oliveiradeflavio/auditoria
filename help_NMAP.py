#!/usr/bin/python
#-*- encoding: utf-8 -*-
#23/08/2016

import os

help=["1) Analisar Vários IP's",
          "2) Analisar toda Rede ",
          "3) Excluir Alvos da Analise",
          "4) Detectar o Sistema Operacinal",
          "5) Detectar Alvo, mesmo com Firewall ON",
          "6) Host's Conectado em um range de IP",
          "7) Análise Rápida",
          "8) Dizer pq a Porta está Aberta",
          "9) Apenas mostrar a Porta Aberta",
          "10) Analisar uma porta específica",
          "11) Analisar duas portas",
          "12) Analisar de x a x portas",
          "13) Analisar portas mais conhecidas",
          "14) Analisar programa e versão que está na porta"]

def cabecalho():
	
    os.system("clear")
    print("====================================")
    print("Flávio Oliveira Consultoria em T.I")
    print("http://www.flaviodeoliveira.com.br")
    print("====================================")
    print("")   
    print("Algumas funções que utilizo usando o programa NMAP")
    print("")
    for i in help:
    	print(i)
        
while True:
    cabecalho()
    print("")
    try:
        escolha=int(input("Escolha o número referente ao exemplo (0 == sair).: "))

        if escolha == 0:
            break
    
        elif escolha > 14 or escolha < 0:
            print("Números inválidos")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 1:
            print(help[1-1])
            print("nmap 192.168.1.1, 192.168.1.2")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 2:
            print(help[2-1])
            print("nmap 192.168.1.0/24")
            input("\nTecle ENTER para continuar")
            
        elif escolha == 3:
            print(help[3-1])
            print("nmap 192.168.1.0/24 --exclude 192.168.1.5")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 4:
            print(help[4-1])
            print("nmap -v -A 192.168.1.245, nmap -O 192.168.1.1")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 5:
            print(help[5-1])
            print("nmap -PN 192.168.1.1")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 6:
            print(help[6-1])
            print("nmap -sP 192.168.0.1/24")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 7:
            print(help[7-1])
            print("nmap -F 192.168.1.1")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 8:
            print(help[8-1])
            print("nmap --reason 192.168.2.2")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 9:
            print(help[9-1])
            print("nmap --open 192.168.4.4")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 10:
            print(help[10-1])
            print("nmap -p 80 192.168.4.2")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 11:
            print(help[11-1])
            print("nmap -p 80,443 192.168.1.10")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 12:
            print(help[12-1])
            print("nmap -p 80-200 192.168.4.120")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 13:
            print(help[13-1])
            print("nmap --top-ports 10 192.168.1.1")
            input("\nTecle ENTER para continuar")
        
        elif escolha == 14:
            print(help[14-1])
            print("nmap -sv 192.168.1.1")
            input("\nTecle ENTER para continuar")

    except:
        print("Somente números")
        os.system("sleep 1")
