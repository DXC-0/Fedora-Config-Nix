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

# Utilisateur non root (le script nix n'accepte pas sudo)
NON_ROOT_USER=$(logname)

echo " Installation de Nix..."
sudo -u "$NON_ROOT_USER" bash -c 'curl -L https://nixos.org/nix/install | sh'

echo "🏠 Installation de Home Manager..."
sudo -u "$NON_ROOT_USER" bash -c '
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  nix-shell -p home-manager --run "home-manager init"
  mkdir -p "$HOME/.config/nixpkgs"
  cp ./home.nix "$HOME/.config/nixpkgs/home.nix"
  home-manager switch
'

echo "✅ Installation terminée !"

echo "Redémarrage dans 5 secondes..."
sleep 5
sudo reboot
