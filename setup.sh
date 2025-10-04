#!/bin/bash

# Install additional programs
yay -S --noconfirm \
  ark \
  base-devel \
  btop \
  firefox \
  fzf \
  git \
  imv \
  krita \
  llama.cpp-hip \
  nano \
  neovim \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra \
  npm \
  obs-studio \
  ollama-rocm \
  prismlauncher \
  protonup-qt-bin \
  spotify \
  steam \
  vulkan-radeon \
  yazi \
  mpv \
  mpvpaper \
  neovide \
  konsole \
  zathura \
  zathura-pdf-mupdf

# Set default apps
curl -fsSL \
  https://raw.githubusercontent.com/nonetrix/end4-post-install/refs/heads/main/mimeapps.list \
  -o "$HOME/.config/mimeapps.list"

# Install Neovim configs
git clone https://github.com/NvChad/starter ~/.config/nvim

# Patch Kitty configs
if ! grep -q "background_opacity 0.9" ~/.config/kitty/kitty.conf; then
  echo "background_opacity 0.9" >> ~/.config/kitty/kitty.conf
  echo "Added 'background_opacity 0.9' to kitty.conf"
else
  echo "'background_opacity 0.9' already exists in kitty.conf"
fi
