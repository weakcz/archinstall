#!/bin/sh
#                       _     ___  ____                       
#   __      _____  __ _| | __/ _ \/ ___|                      
#   \ \ /\ / / _ \/ _` | |/ / | | \___ \                      
#    \ V  V /  __/ (_| |   <| |_| |___) |                     
#     \_/\_/ \___|\__,_|_|\_\\___/|____/                  
#                                                         
#   Nabídka k rychlému otevření konfigurařních 
#   souborů
#                                                             
#   potřebné závislosti:                                        
#      - rofi                                            
#  


menu(){

    echo -en "Qtile <span size='12pt'><i>(Konfigurace pro tiling WM)</i></span>\n"
    echo -en "Autostart <span size='12pt'><i>(Nastavení automatického spouštění aplikací po startu Qtile)</i></span>\n"
	echo -en "Dunst <span size='12pt'><i>(Nastavení zobrazování upozornění)</i></span>\n"
	echo -en "Picom <span size='12pt'><i>(Kompozitor - nastavení průhlednosti a rozmazání)</i></span>\n"
	echo -en "Zsh <span size='12pt'><i>(otevře .zshrc v domovské složce)</i></span>\n"
}

main() {
	choice=$(menu | rofi -dmenu -p "Konfigurační soubory" -theme-str 'entry { placeholder: ""; placeholder-color: grey;}' -markup-rows | cut -d " " -f1)

	case $choice in
		Qtile)
            code $HOME/.config/qtile/config.py
			break
			;;
		Autostart)
			code $HOME/.config/qtile/autostart.sh
			break
			;;
		Dunst)
			code $HOME/.config/dunst/dunstrc
			break
			;;
		Picom)
			code $HOME/.config/picom/picom.conf
			break
			;;
		Zsh)
			code $HOME/.zshrc
			break
			;;
		6)
			
			break
			;;
	esac
}

main