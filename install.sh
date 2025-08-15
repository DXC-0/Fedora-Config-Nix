#!/bin/bash

set -e  # Stop on error

# Journalisation :
exec > >(tee -i setup.log)
exec 2>&1

# Script :

echo "🔧 Mise à jour du système..."
sudo dnf update -y

echo "📦 Installation de RPM Fusion 📦"
sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "📦 Installation des drivers Nvidia 📦"
sudo dnf install -y \
  akmod-nvidia \
  xorg-x11-drv-nvidia-cuda

echo "📦 Installation des outils système 📦"
sudo dnf install --setopt=install_weak_deps=False -y \
  git \
  curl \
  neovim \
  tmux \
  btop \
  ddcutil \
  gnome-keyring \
  gvfs \
  gvfs-smb \
  alacritty \
  git

echo "📦 Installation des outils de conteneurisation 📦"
sudo dnf install --setopt=install_weak_deps=False -y \
  flatpak \
  podman \
  podman-compose \
  distrobox

echo "📦 Installation du window manager 📦"
sudo dnf install --setopt=install_weak_deps=False -y \
  swaybg \
  swayidle \
  wl-clipboard \
  nautilus \
  slurp \
  xwayland-satellite \
  wofi \
  niri \
  lightdm-gtk \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-wlr

echo "📦 Installation des applications Flatpak 📦"
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub -y \
  com.discordapp.Discord \
  com.github.PintaProject.Pinta \
  com.github.tchx84.Flatseal \
  com.vscodium.codium \
  dev.geopjr.Tuba \
  io.freetubeapp.FreeTube \
  io.gitlab.librewolf-community \
  org.chromium.Chromium \
  io.podman_desktop.PodmanDesktop \
  org.gnome.Boxes \
  org.gnome.eog \
  org.gnome.TextEditor \
  org.pulseaudio.pavucontrol \
  org.signal.Signal \
  org.videolan.VLC

echo " Activation des services "
sudo systemctl enable lightdm.service
sudo systemctl set-default graphical.target

# Utilisateur non-root
NON_ROOT_USER=$(logname)
USER_HOME=$(eval echo "~$NON_ROOT_USER")

echo "Installation de Nix"
sudo -u "$NON_ROOT_USER" bash -c 'curl -L https://nixos.org/nix/install | sh'
sudo -u "$NON_ROOT_USER" bash -c "
  echo '. \$HOME/.nix-profile/etc/profile.d/nix.sh' >> \"$USER_HOME/.bashrc\"
  echo '. \$HOME/.nix-profile/etc/profile.d/nix.sh' >> \"$USER_HOME/.zshrc\"
"

echo "Installation de Home Manager"
sudo -u "$NON_ROOT_USER" bash -c "
  . \"$USER_HOME/.nix-profile/etc/profile.d/nix.sh\"
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
"

echo "Configuration Home Manager"
sudo -u "$NON_ROOT_USER" bash -c "
  cp ./home.nix \"$USER_HOME/.config/home-manager/home.nix\"
  . \"$USER_HOME/.nix-profile/etc/profile.d/nix.sh\"
  home-manager switch
"

echo "Autologin LightDM"
sudo sed -i 's/^#\?\s*autologin-user=.*/autologin-user=alerion/' /etc/lightdm/lightdm.conf
sudo sed -i 's/^#\?\s*autologin-session=.*/autologin-session=niri/' /etc/lightdm/lightdm.conf

echo "Personnalisation"
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
mv ./wall.png $USER_HOME/.config/niri/wall.png
git clone https://github.com/cbrnix/Flatery.git
sudo -u "$NON_ROOT_USER" bash -c "cd Flatery && bash install.sh"
gsettings set org.gnome.desktop.interface icon-theme 'Flatery-Indigo-Dark'

echo "Installation terminée !"

echo "Redémarrage dans 5 secondes..."
sleep 5
sudo reboot
