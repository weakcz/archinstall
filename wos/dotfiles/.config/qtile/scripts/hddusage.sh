#!/bin/bash


#                       _     ___  ____                       
#   __      _____  __ _| | __/ _ \/ ___|                      
#   \ \ /\ / / _ \/ _` | |/ / | | \___ \                      
#    \ V  V /  __/ (_| |   <| |_| |___) |                     
#     \_/\_/ \___|\__,_|_|\_\\___/|____/                      
#                                                             
#      Skript na zobrazení využití disku                           
#                                                             
#   Potřebné závislosti:                                        
#       - awk                                                       
                                                             


root="/"
home="/home/$USER"

r_free=$(df -h $root | awk '/[0-9]%/{print $(NF-2)}')
r_used=$(df -h $root | awk '/[0-9]%/{print $(NF-3)}')
r_total=$(df -h $root | awk '/[0-9]%/{print $(NF-4)}')

h_free=$(df -h $home | awk '/[0-9]%/{print $(NF-2)}')
h_used=$(df -h $home | awk '/[0-9]%/{print $(NF-3)}')
h_total=$(df -h $home | awk '/[0-9]%/{print $(NF-4)}')

printf "/: $r_used/$r_total  /home: $h_used/$h_total"
