#!/bin/bash
xsetroot -cursor_name left_ptr &

# Spustíme kompozitor (umožňuje grafické efekty jako je průhlednost, stíny a tak dále)
picom --experimental-backends --backend glx &

# Polkit (abysme mohli zadávat hesla)
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Spustíme zámek obrazovky
wos-locker &

# Pozadí plochy
nitrogen --restore &

# Program na automatické připojování disků
udiskie &

# Zobrazování notifikací
dunst &

# tray ikony
killall pamac-tray &
pamac-tray &
nm-applet &
blueman-applet &

sleep 0.5
