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
sudo dnf install -y \
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
sudo dnf install -y \
  flatpak \
  podman \
  podman-compose \
  distrobox

echo "📦 Installation du window manager 📦"
sudo dnf install -y \
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
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y \
  flathub com.discordapp.Discord \
  flathub com.github.PintaProject.Pinta \
  flathub com.github.tchx84.Flatseal \
  flathub com.vscodium.codium \
  flathub dev.geopjr.Tuba \
  flathub io.freetubeapp.FreeTube \
  flathub io.gitlab.librewolf-community \
  flathub org.chromium.Chromium \
  flathub io.podman_desktop.PodmanDesktop \
  flathub org.gnome.Boxes \
  flathub org.gnome.eog \
  flathub org.gnome.TextEditor \
  flathub org.pulseaudio.pavucontrol \
  flathub org.signal.Signal \
  flathub org.videolan.VLC

echo " Activation des services "
sudo systemctl enable lightdm.service
sudo systemctl set-default graphical.target

echo "🛡️ Renforcement du pare-feu"
sudo firewall-cmd --set-default-zone=block --permanent
sudo firewall-cmd --reload
sudo systemctl restart firewalld.service

echo " Installation de Nix..."
curl -L https://nixos.org/nix/install | sh

. ~/.nix-profile/etc/profile.d/nix.sh

echo "🏠 Installation de Home Manager..."
nix-shell -p home-manager --run 'home-manager init'

echo " Copie de la configuration Home Manager..."
mkdir -p ~/.config/nixpkgs
cp ./home.nix ~/.config/nixpkgs/home.nix

echo " Application de la configuration Home Manager..."
home-manager switch

echo "✅ Installation terminée !"

echo "Redémarrage dans 5 secondes..."
sleep 5
sudo reboot
