#!/bin/bash


#                       _     ___  ____                       
#   __      _____  __ _| | __/ _ \/ ___|                      
#   \ \ /\ / / _ \/ _` | |/ / | | \___ \                      
#    \ V  V /  __/ (_| |   <| |_| |___) |                     
#     \_/\_/ \___|\__,_|_|\_\\___/|____/                  
#                                                         
# Skript na zopbrazení počtu aktualizací ve stavovém řádku
#                                                             
# potřebné závislosti:                                        
#   pacman-contrib                                            
#                                                            


updates=$(checkupdates | wc -l)

if (($updates >= 1 && $updates <= 4))
then
  update_text="aktualizace"
fi
if (($updates >= 4))
then
  update_text="auktualizací"
fi
if (($updates == 0))
then
  updates="Žádná"
  update_text="aktualizace"
fi

echo "$updates $update_text"

