#!/bin/bash

yay -S \
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
  neovide

curl -fsSL \
  https://raw.githubusercontent.com/nonetrix/end4-post-install/refs/heads/main/mimeapps.list \
  -o "$HOME/.config/mimeapps.list"
