# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
pacman --noconfirm -S terminus-font &>/dev/null
export LANG=cs_CZ.UTF-8
setfont ter-v22b
loadkeys cz-qwertz
echo "Vítejte v instalačním skriptu pro weakOS"
reflector -c Czechia --latest 20 --sort rate --save /etc/pacman.d/mirrorlist 
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
lsblk
echo "Zadejte disk [ve formátu /dev/sdX (X je písmeno nebo čísdlo disku)]: "
read drive
cfdisk $drive 
read -p "Vytvořili jste efi oddíl? [a/n]" answer
echo "Napište oddíl, kam chcete nainstalovat linux: "
read partition
echo "Vytvořte uživatele"
read -p "Jméno: " user_name
read -s -p "Heslo: " user_password
printf "\n"
echo "user_name="$user_name >> wosinstall.conf
echo "user_password="$user_password >> wosinstall.conf
echo "Jméno počítače (zadávejte malými písmeny): "
read hostname
echo "hostname="$hostname >> wosinstall.conf

mkfs.ext4 $partition 
if [[ $answer = a ]] ; then
  echo "Napište EFI oddíl: "
  read efipartition
  mkfs.vfat -F 32 $efipartition
  echo "efi="$efipartition > wosinstall.conf
fi

mount $partition /mnt 
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' `basename $0` > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
cp /root/archinstall/test.list /mnt
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
#echo "Jméno počítače: "
#read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
# passwd
pacman --noconfirm -S grub efibootmgr os-prober
#echo "Napište EFI oddíl: " 
#read efipartition
mkdir /boot/efi
mount $efi /boot/efi 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

nc=$(grep -c ^processor /proc/cpuinfo)
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

pacman -Sy --noconfirm --needed - < test.list

systemctl enable NetworkManager.service 
rm /bin/sh
ln -s dash /bin/sh
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# echo "Enter Username: "
# read username
useradd -m -G sys,log,network,floppy,scanner,power,rfkill,users,video,storage,optical,lp,audio,wheel,adm -s /bin/zsh $user_name
# passwd $username
echo "$user_name:$user_password" | chpasswd
echo "root:$user_password" | chpasswd
cp -a /wos/dotfiles/. /home/$user_name/
# chown $user_name:$user_name /home/$user_name/.zshrc
chown -R weak:weak /home/weak
# Nastavíme Klávesnici na českou
localectl set-x11-keymap cz
localectl set-keymap cz

echo "KEYMAP=cz-qwertz" > /etc/vconsole.conf
echo "FONT=ter-v22b" >> /etc/vconsole.conf
# Rozbalíme témata a ikony
echo -e "\nRozbaluji témata do /usr/share/themes. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf /wos/themes/adapta-nord.tar.gz -C /usr/share/themes/
echo -e "\nRozbaluji iklony do /usr/share/icons. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf /wos/themes/nordarcicons.tar.gz -C /usr/share/icons/
echo -e "\nRozbaluji kurzor do /usr/share/icons. Tohle může chvíli trvat, mějte strpení\n"
sudo tar -xf /wos/themes/cursor.tar.gz -C /usr/share/icons/
cp -r /wos/backgrounds/* /usr/share/wos/backgrounds
ai3_path=/home/$user_name/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > $ai3_path
chown $user_name:$user_name $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $user_name
exit 

#part3
printf '\033c'
# sudo chown -R weak:weak /home/weak
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ..
yay -S --noconfirm oh-my-zsh-git
sudo ln -s /usr/share/zsh/plugins/zsh-syntax-highlighting /usr/share/oh-my-zsh/custom/plugins/
sudo ln -s /usr/share/zsh/plugins/zsh-autosuggestions /usr/share/oh-my-zsh/custom/plugins/ 
printf "\nInstalace weakOSu hotová. Můžete restartovat počítač.\n"
exit