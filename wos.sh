# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
pacman --noconfirm -S terminus-font &>/dev/null
export LANG=cs_CZ.UTF-8
setfont ter-v22b
loadkeys cz-qwertz

echo -e "\nVítejte v instalačním skriptu pro weakOS\n"
reflector -c Czechia --latest 20 --sort rate --save /etc/pacman.d/mirrorlist 
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
clear



lsblk
printf "\n"
echo "Zadejte disk [ve formátu /dev/sdX (X je písmeno nebo čísdlo disku)]: "
read drive
cfdisk $drive
clear
lsblk $drive
printf "\n"
read -p "Vytvořili jste efi oddíl? [a/n]: " answer
if [[ $answer = a ]] ; then
  printf "\nNapište EFI oddíl (ve formátu /dev/sdXX): "
  read efipartition
fi
printf "\nNapište oddíl, kam chcete nainstalovat linux (ve formátu /dev/sdXX): "
read partition
printf "\nVytvořte uživatele\n"
read -p "Jméno: " user_name
read -s -p "Heslo: " user_password
printf "\n"
echo "user_name="$user_name > wosinstall.conf
echo "user_password="$user_password >> wosinstall.conf
printf "\nJméno počítače (zadávejte malými písmeny): "
read hostname
echo "hostname="$hostname >> wosinstall.conf

mkfs.ext4 $partition
if [[ $answer = a ]] ; then
  mkfs.vfat -F 32 $efipartition
  echo "efi="$efipartition >> wosinstall.conf
fi

mount $partition /mnt 
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' `basename $0` > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
# cp /root/archinstall/test.list /mnt
cp /root/archinstall/wosinstall.conf /mnt
cp -r /root/archinstall/wos /mnt/wos
arch-chroot /mnt ./arch_install2.sh
exit 

#part2
printf '\033c'
source ./wosinstall.conf
pacman -S --noconfirm sed
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
ln -sf /usr/share/zoneinfo/Europe/Prague /etc/localtime
hwclock --systohc
echo "cs_CZ.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=cs_CZ.UTF-8" > /etc/locale.conf
echo "LC_ADDRESS=cs_CZ.UTF-8" >> /etc/locale.conf
echo "LC_IDENTIFICATION=cs_CZ.UTF-8" >> /etc/locale.conf
echo "LC_MEASUREMENT=cs_CZ.UTF-8" >> /etc/locale.conf
echo "LC_MONETARY=cs_CZ.UTF-8" >> /etc/locale.conf
echo "LC_NAME=cs_CZ.UTF-8" >> /etc/locale.conf
echo "LC_NUMERIC=cs_CZ.UTF-8" >> /etc/locale.conf
echo "LC_PAPER=cs_CZ.UTF-8" >> /etc/locale.conf
echo "LC_TELEPHONE=cs_CZ.UTF-8" >> /etc/locale.conf
echo "LC_TIME=cs_CZ.UTF-8" >> /etc/locale.conf
echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment

echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P

pacman --noconfirm -S grub efibootmgr os-prober

mkdir /boot/efi
mount $efi /boot/efi 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
# sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

nc=$(grep -c ^processor /proc/cpuinfo)
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

pacman -Sy --noconfirm --needed - < /wos/lists/test.list
# Proměnná na kontrolu přítomnosti baterie
battery=$(upower -e | grep BAT)
echo $battery
read -r -s -p $"Enter pro pokračování\n"
if [ -n "$battery" ]; then
  echo "Detekována Baterie. Instaluji programy, služby a nastavení pro úsporu baterie"
  read -r -s -p $"Enter pro pokračování\n"
  pacman -S --noconfirm tlp
  systemctl enable tlp.service 
  sed -i 's/\#\*//g' /home/$user_name/.config/qtile/config.py
  echo "xrandr -s 1600x900" > /usr/share/sddm/scripts/Xsetup
fi
read -r -s -p $"Enter pro pokračování\n"


systemctl enable NetworkManager.service 
rm /bin/sh
ln -s dash /bin/sh
sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers
# echo "Enter Username: "
# read username
useradd -m -G sys,log,network,floppy,scanner,power,rfkill,users,video,storage,optical,lp,audio,wheel,adm -s /bin/zsh $user_name
# passwd $username
echo "$user_name:$user_password" | chpasswd
echo "root:$user_password" | chpasswd
cp -a /wos/dotfiles/. /home/$user_name/
# chown $user_name:$user_name /home/$user_name/.zshrc
chown -R $user_name:$user_name /home/$user_name

#[ "$batt" == "yes" ] && sed -i 's/\#\*//g' /home/$user_name/.config/qtile/config.py

echo "KEYMAP=cz-qwertz" >> /etc/vconsole.conf
echo "FONT=ter-v22b" >> /etc/vconsole.conf

# Grafika

printf "\n\nInstaluji Grafické ovladače\n\n"
sleep 5

if lspci | grep -E "NVIDIA|GeForce";then
    pacman -S --noconfirm --needed nvidia
	nvidia-xconfig
elif lspci | grep 'VGA' | grep -E "Radeon|AMD";then
    pacman -S --noconfirm --needed xf86-video-amdgpu
elif lspci | grep 'VGA' | grep -E "Integrated Graphics Controller";then
    pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
elif lspci | grep 'VGA' | grep -E "Intel Corporation";then
    pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
fi
sleep 5
# Rozbalíme témata a ikony
echo -e "\nRozbaluji témata do /usr/share/themes. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf /wos/themes/adapta-nord.tar.gz -C /usr/share/themes/
echo -e "\nRozbaluji iklony do /usr/share/icons. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf /wos/themes/nordarcicons.tar.gz -C /usr/share/icons/
echo -e "\nRozbaluji kurzor do /usr/share/icons. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf /wos/themes/cursor.tar.gz -C /usr/share/icons/
mkdir -p /usr/share/wos/backgrounds
cp -r /wos/backgrounds/* /usr/share/wos/backgrounds

# Nastavíme sddm (Login Manažera)
# =================================================================
# Smažeme wayland verzi pro qtile abychom se mohli přihlašovat pouze do X11
rm /usr/share/wayland-sessions/qtile-wayland.desktop
# Zkopírujeme konfigurační soubor

mkdir -p /etc/sddm.conf.d
cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/
# Nastavíme téma pro sddm
sudo sed -i 's/^Current=*.*/Current=maldives/g' /etc/sddm.conf.d/default.conf
# Pokud se jedná o laptop, tak změníme rozlišení obrazovky

systemctl enable sddm

# Nastavíme aby se zobrazovaly adrasáře jako první ve výběrovém okně pro soubory
sudo -u weak dbus-launch --exit-with-session gsettings set org.gtk.Settings.FileChooser sort-directories-first true
# Nastavíme aby nemo (správce souborů) používal alacritty jako terminál
sudo -u weak dbus-launch --exit-with-session gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty

# Nastavíme českou klávesnici pro X11

echo "Section \"InputClass\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "        Identifier \"system-keyboard\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "        MatchIsKeyboard \"on\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "        Option \"XkbLayout\" \"cz\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "        Option \"XkbModel\" \"pc104\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "        Option \"XkbVariant\" \",qwertz\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "        Option \"XkbOptions\" \"grp:win_space_toggle\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "EndSection" >> /etc/X11/xorg.conf.d/00-keyboard.conf

ai3_path=/home/$user_name/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > $ai3_path
chown $user_name:$user_name $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $user_name
exit 

#part3
printf '\033c'

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ..

yay -S --noconfirm oh-my-zsh-git qt5-styleplugins

sudo ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting /usr/share/oh-my-zsh/custom/plugins/
sudo ln -s /usr/share/zsh/plugins/zsh-autosuggestions /usr/share/oh-my-zsh/custom/plugins/ 


# Uklidíme po sobě
sudo rm -rf /wos
sudo rm -f /wosinstall.conf
sudo rm -f /arch_install2.sh
sudo rm -rf ~/yay


sudo sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
sudo sed -i 's/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers

printf "\nInstalace weakOSu hotová. Můžete restartovat počítač.\n"
rm -f ~/arch_install3.sh
exit