#!/bin/sh
#                       _     ___  ____                       
#   __      _____  __ _| | __/ _ \/ ___|                      
#   \ \ /\ / / _ \/ _` | |/ / | | \___ \                      
#    \ V  V /  __/ (_| |   <| |_| |___) |                     
#     \_/\_/ \___|\__,_|_|\_\\___/|____/                  
#                                                         
#   Ukáže menu s mými oblíbenými aplikacemi
#                                                             
#   potřebné závislosti:                                        
#      - rofi                                            
#                                             


menu(){

	echo -en "Firefox\x00icon\x1ffirefox\n"
	echo -en "Steam\x00icon\x1fsteam\n"
	echo -en "Lutris\x00icon\x1flutris\n"
	# echo "<span lang='meetup' face='Font Awesome'>&#xf2cc;</span> ahoj"
}

main() {
	choice=$(menu | rofi -dmenu -p "Oblíbené" -theme-str 'entry { placeholder: "Hledat mezi oblíbenými"; placeholder-color: grey;}' -i -markup-rows -show-icons )

	case $choice in
		Firefox)
            firefox
			break
			;;
		2)
			
			break
			;;
		3)
			
			break
			;;
		4)
			
			break
			;;
		5)
			
			break
			;;
		6)
			
			break
			;;
	esac
}

main