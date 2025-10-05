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

# Use Vim bindings for window stuff
KEYBIND_CONFIG_FILE="$HOME/.config/hypr/hyprland/keybinds.conf"
# A unique comment to check if the patch has already been applied
PATCH_COMMENT="# VIM-PATCH-APPLIED"

# Check if the file is already patched by grepping for the comment
if grep -q "$PATCH_COMMENT" "$KEYBIND_CONFIG_FILE"; then
    echo "Vim keybind patch is already applied. No changes were made."
else
    echo "Applying Vim keybind patch..."
    # Append a block that first unbinds conflicting keys,
    # then rebinds their original actions elsewhere,
    # and finally sets up the new vim-style keybindings.
    cat <<EOF >> "$KEYBIND_CONFIG_FILE"
# VIM-PATCH-APPLIED
# This block was added by a script to enable Vim-style window movement.

#!
##! Patched Vim Window Controls
# Unbind the keys we are about to overwrite to prevent duplicate actions
unbind = Super, J
unbind = Super, K
unbind = Super, L
unbind = Super+Shift, L

# Rebind original actions to new key combinations
bindd = Super+Alt, J, Toggle bar, global, quickshell:barToggle # Rebound from Super+J
bindd = Super+Alt, K, Toggle on-screen keyboard, global, quickshell:oskToggle # Rebound from Super>
bindd = Super+Alt, L, Lock, exec, loginctl lock-session # Rebound from Super+L
bindld = Super+Ctrl, L, Suspend system, exec, systemctl suspend || loginctl suspend

# Add new Vim-style bindings for focus and movement
bind = Super, h, movefocus, l
bind = Super, j, movefocus, d
bind = Super, k, movefocus, u
bind = Super, l, movefocus, r

bind = Super+Shift, h, movewindow, l
bind = Super+Shift, j, movewindow, d
bind = Super+Shift, k, movewindow, u
bind = Super+Shift, l, movewindow, r
EOF
    echo "Patch applied successfully. Please reload Hyprland for changes to take effect."
fi
