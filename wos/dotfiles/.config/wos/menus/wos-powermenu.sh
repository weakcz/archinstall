#!/bin/sh
#                       _     ___  ____                       
#   __      _____  __ _| | __/ _ \/ ___|                      
#   \ \ /\ / / _ \/ _` | |/ / | | \___ \                      
#    \ V  V /  __/ (_| |   <| |_| |___) |                     
#     \_/\_/ \___|\__,_|_|\_\\___/|____/                  
#                                                         
#   Skript zobrazující nabídku pro vypnutí 
#   nebo restart počítače
#                                                             
#   potřebné závislosti:                                        
#      - rofi                                            
#   



rofi_command="rofi -i -markup-rows -theme $HOME/.config/wos/rofi/themes/$1.rasi"

# Power Options
reboot="<span lang='meetup' face='mononoki Nerd Font'>&#xf021;</span>   Restartovat"
shutdown="<span lang='meetup' face='mononoki Nerd Font'>&#xf011;</span>   Vypnout"
logout="<span lang='meetup' face='mononoki Nerd Font'>&#xf090;</span>   Odhlásit se"
lock="<span lang='meetup' face='mononoki Nerd Font'>&#xf840;</span>  Zamknout"
task="<span lang='meetup' face='mononoki Nerd Font'>&#xf68c;</span>   Správce úkolů"

options="$shutdown\n$reboot\n$lock\n$logout\n$task"

chosen=$(echo -en "$options" | $rofi_command -dmenu)

case $chosen in
    $shutdown)
        poweroff
    ;;
    $reboot)
        systemctl reboot
    ;;
    $lock)
        wos-lock
    ;;
    $task)
        alacritty -e htop
    ;;
    $logout)
        user=$(who | cut -d " " -f1)
        pkill -Kill -u $user
    ;;
esac
