#!/bin/bash

#==============================================================================
# CONFIGURATION VARIABLES
#
# All file paths and patch identifiers are defined here for easy management.
#==============================================================================
HYPR_KEYBIND_CONFIG="$HOME/.config/hypr/hyprland/keybinds.conf"
HYPR_GENERAL_CONFIG="$HOME/.config/hypr/hyprland/general.conf"
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"
MIMEAPPS_CONFIG="$HOME/.config/mimeapps.list"

VIM_KEYBIND_PATCH_ID="# VIM-PATCH-APPLIED"
MONITOR_SETUP_PATCH_ID="# MONITOR-SETUP-APPLIED"

#==============================================================================
# STAGE 1: INSTALL ADDITIONAL PROGRAMS
#==============================================================================
echo "--- Installing packages... ---"
yay -S --noconfirm \
  ark \
  base-devel \
  btop \
  brave-bin \
  fzf \
  git \
  qview \
  konsole \
  gimp \
  llama.cpp-hip \
  mpv \
  mpvpaper \
  nano \
  neovide \
  neovim \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra \
  npm \
  obs-studio \
  ollama-rocm \
  prismlauncher \
  proton-vpn-gtk-app \
  protonup-qt-bin \
  spotify \
  steam \
  vulkan-radeon \
  yazi \
  ffmpegthumbs \
  cava \
  fastfetch \
  zathura \
  zathura-pdf-mupdf

#==============================================================================
# STAGE 2: SET DEFAULT APPLICATIONS
#==============================================================================
echo "--- Setting default applications... ---"
curl -fsSL \
  https://raw.githubusercontent.com/nonetrix/end4-post-install/refs/heads/main/mimeapps.list \
  -o "$MIMEAPPS_CONFIG"

#==============================================================================
# STAGE 3: INSTALL NEOVIM CONFIGURATION
#==============================================================================
echo "--- Installing Neovim configuration... ---"
git clone https://github.com/NvChad/starter ~/.config/nvim

#==============================================================================
# STAGE 4: PATCH KITTY CONFIGURATION
#==============================================================================
echo "--- Patching Kitty configuration... ---"
if ! grep -q "background_opacity 0.9" "$KITTY_CONFIG"; then
  echo "background_opacity 0.9" >> "$KITTY_CONFIG"
  echo "Added 'background_opacity 0.9' to kitty.conf"
else
  echo "'background_opacity 0.9' already exists in kitty.conf"
fi

#==============================================================================
# STAGE 5: APPLY VIM KEYBINDS FOR HYPRLAND
#==============================================================================
echo "--- Applying Vim keybinds for Hyprland... ---"
# Check if the file is already patched by grepping for the patch identifier
if grep -q "$VIM_KEYBIND_PATCH_ID" "$HYPR_KEYBIND_CONFIG"; then
    echo "Vim keybind patch is already applied. No changes were made."
else
    echo "Applying Vim keybind patch..."
    # Append the keybinding configuration
    cat <<EOF >> "$HYPR_KEYBIND_CONFIG"
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

#==============================================================================
# STAGE 6: APPLY MONITOR SETUP FOR HYPRLAND
#==============================================================================
echo "--- Applying monitor setup for Hyprland... ---"
# Check if the file is already patched by grepping for the patch identifier
if grep -q "$MONITOR_SETUP_PATCH_ID" "$HYPR_GENERAL_CONFIG"; then
    echo "Monitor setup is already applied. No changes were made."
else
    echo "Applying monitor setup..."
    # Append the monitor configuration block to the end of the file
    cat <<EOF >> "$HYPR_GENERAL_CONFIG"

# MONITOR-SETUP-APPLIED
# The following lines were added by a script to configure the dual monitor layout.
monitor=DP-1,1920x1080@165,0x0,1,vrr,0
monitor=DP-3,1920x1200@60,1920x0,1
EOF
    echo "Monitor configuration applied successfully."
fi

echo "--- Script finished. ---"
