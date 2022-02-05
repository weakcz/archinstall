# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
echo "Vítejte v instalačním skriptu pro weakOS"
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist --protocol https --download-timeout 5
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
lsblk
echo "Zadejte disk: "
read drive
cfdisk $drive 
echo "Oddíl, kam chcete nainstalovat linux: "
read partition
mkfs.ext4 $partition 
read -p "Vytvořili jste efi oddíl? [a/n]" answer
if [[ $answer = a ]] ; then
  echo "napište EFI oddíl: "
  read efipartition
  mkfs.vfat -F 32 $efipartition
fi
echo "Vytvořte uživatele"
read -p "Jméno: " user_name
read -s -p "Heslo: " user_password
printf "\n"
echo "user_name="$user_name >> wosinstall.conf
echo "user_password="$user_password >> wosinstall.conf
echo "Jméno počítače (zadávejte malými písmeny): "
read hostname
echo "hostname="$hostname >> wosinstall.conf
mount $partition /mnt 
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' `basename $0` > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
cp /root/archinstall/wosinstall.conf /mnt
arch-chroot /mnt ./arch_install2.sh
exit 

#part2
printf '\033c'
source ./wosinstall.conf
pacman -S --noconfirm sed
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo "Jméno počítače: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
# passwd
pacman --noconfirm -S grub efibootmgr os-prober
echo "Napište EFI oddíl: " 
read efipartition
mkdir /boot/efi
mount $efi /boot/efi 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop \
     noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome \
     sxiv mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  \
     fzf man-db xwallpaper python-pywal youtube-dl unclutter xclip maim \
     zip unzip unrar p7zip xdotool papirus-icon-theme brightnessctl  \
     dosfstools ntfs-3g git sxhkd zsh pipewire pipewire-pulse \
     vim emacs arc-gtk-theme rsync firefox dash \
     xcompmgr libnotify dunst slock jq \
     dhcpcd networkmanager rsync pamixer \
     zsh-syntax-highlighting xdg-user-dirs

systemctl enable NetworkManager.service 
rm /bin/sh
ln -s dash /bin/sh
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# echo "Enter Username: "
# read username
useradd -m -G wheel -s /bin/zsh $user_name
# passwd $username
echo "$user_name:$user_password" | chpasswd
echo "root:$user_password" | chpasswd
echo "Pre-Installation Finish Reboot now"
ai3_path=/home/$username/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > $ai3_path
chown $username:$username $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $username
exit 

#part3
printf '\033c'
cd $HOME
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/bugswriter/dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
git clone --depth=1 https://github.com/Bugswriter/dwm.git ~/.local/src/dwm
sudo make -C ~/.local/src/dwm install
git clone --depth=1 https://github.com/Bugswriter/st.git ~/.local/src/st
sudo make -C ~/.local/src/st install
git clone --depth=1 https://github.com/Bugswriter/dmenu.git ~/.local/src/dmenu
sudo make -C ~/.local/src/dmenu install
git clone --depth=1 https://github.com/Bugswriter/baph.git ~/.local/src/baph
sudo make -C ~/.local/src/baph install
baph -inN libxft-bgra-git

ln -s ~/.config/x11/xinitrc .xinitrc
ln -s ~/.config/shell/profile .zprofile
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.oh-my-zsh ~/.config/zsh/oh-my-zsh
rm ~/.zshrc ~/.zsh_history
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dots config --local status.showUntrackedFiles no
exit