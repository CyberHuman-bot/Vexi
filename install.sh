#!/bin/bash

# Vilo Installation Script
# Installs and configures Hyprland + Waybar + Walker

set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Catch errors in pipes

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}→${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_step() {
    echo -e "\n${CYAN}━━━ $1 ━━━${NC}"
}

# Error handler
error_exit() {
    print_error "$1"
    exit 1
}

# Cleanup function
cleanup() {
    if [ $? -ne 0 ]; then
        print_error "Installation failed. Please check the errors above."
    fi
}
trap cleanup EXIT

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    error_exit "Please do not run this script as root"
fi

# Check if running on Arch-based system
if ! command -v pacman &> /dev/null; then
    error_exit "This script requires an Arch-based Linux distribution"
fi

# Welcome banner
clear
echo -e "${BLUE}"
cat << 'EOF'
╔═══════════════════════════════════════╗
║          Vilo Installation            ║
║       Hyprland + Waybar + Walker      ║
╚═══════════════════════════════════════╝
EOF
echo -e "${NC}"

# Show what will be installed
echo -e "${CYAN}This script will install:${NC}"
echo "  • Hyprland (Wayland compositor)"
echo "  • Waybar (Status bar)"
echo "  • Walker (Application launcher)"
echo "  • Essential utilities and dependencies"
echo ""

# Confirm installation
read -p "Continue with installation? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_warning "Installation cancelled by user"
    exit 0
fi

# Update system
print_step "System Update"
print_info "Updating system packages..."
sudo pacman -Syu --noconfirm || error_exit "Failed to update system"
print_success "System updated"

# Install base dependencies
print_step "Installing Base Dependencies"
BASE_DEPS=(
    base-devel
    git
    wget
    curl
)

for dep in "${BASE_DEPS[@]}"; do
    print_info "Installing $dep..."
    sudo pacman -S --needed --noconfirm "$dep" || error_exit "Failed to install $dep"
done
print_success "Base dependencies installed"

# Install Hyprland and related packages
print_step "Installing Hyprland Environment"
HYPRLAND_PKGS=(
    hyprland
    xdg-desktop-portal-hyprland
    qt5-wayland
    qt6-wayland
    polkit-kde-agent
    kitty
    dunst
    rofi-wayland
    swww
    grim
    slurp
    wl-clipboard
    cliphist
    brightnessctl
    playerctl
    pavucontrol
    network-manager-applet
    bluez
    bluez-utils
    blueman
    thunar
    pipewire
    pipewire-pulse
    wireplumber
)

print_info "Installing Hyprland packages (${#HYPRLAND_PKGS[@]} packages)..."
sudo pacman -S --needed --noconfirm "${HYPRLAND_PKGS[@]}" || error_exit "Failed to install Hyprland packages"
print_success "Hyprland environment installed"

# Install Waybar
print_step "Installing Waybar"
WAYBAR_PKGS=(
    waybar
    otf-font-awesome
    ttf-jetbrains-mono-nerd
    ttf-firacode-nerd
)

print_info "Installing Waybar and fonts..."
sudo pacman -S --needed --noconfirm "${WAYBAR_PKGS[@]}" || error_exit "Failed to install Waybar"
print_success "Waybar installed"

# Install yay if not present
print_step "Setting Up AUR Helper"
if ! command -v yay &> /dev/null; then
    print_info "Installing yay AUR helper..."
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    git clone https://aur.archlinux.org/yay.git || error_exit "Failed to clone yay repository"
    cd yay
    makepkg -si --noconfirm || error_exit "Failed to install yay"
    cd "$HOME"
    rm -rf "$TEMP_DIR"
    print_success "yay installed"
else
    print_success "yay already installed"
fi

# Install Walker
print_step "Installing Walker"
print_info "Installing Walker from AUR..."
yay -S --needed --noconfirm walker-git || yay -S --needed --noconfirm walker || error_exit "Failed to install Walker"
print_success "Walker installed"

# Enable services
print_step "Enabling System Services"
print_info "Enabling Bluetooth service..."
sudo systemctl enable bluetooth.service || print_warning "Failed to enable Bluetooth (non-critical)"
print_success "Services configured"

# Create config directories
print_step "Creating Configuration Directories"
CONFIG_DIRS=(
    "$HOME/.config/hypr"
    "$HOME/.config/waybar"
    "$HOME/.config/walker"
    "$HOME/.config/kitty"
    "$HOME/.config/dunst"
)

for dir in "${CONFIG_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        print_info "Created $dir"
    fi
done
print_success "Configuration directories ready"

# Backup existing configs
print_step "Backing Up Existing Configurations"
for dir in "${CONFIG_DIRS[@]}"; do
    config_name=$(basename "$dir")
    if [ -d "$dir" ] && [ "$(ls -A "$dir" 2>/dev/null)" ]; then
        backup_dir="${dir}.backup.$(date +%Y%m%d_%H%M%S)"
        cp -r "$dir" "$backup_dir"
        print_info "Backed up $config_name to $backup_dir"
    fi
done


# Configure Hyprland
print_step "Configuring Hyprland"
print_info "Writing Hyprland configuration..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# Vilo Hyprland Configuration

# Monitor configuration
monitor=,preferred,auto,1

# Execute at launch
exec-once = waybar
exec-once = dunst
exec-once = /usr/lib/polkit-kde-authentication-agent-1
exec-once = swww init
exec-once = nm-applet --indicator
exec-once = blueman-applet
exec-once = wl-paste --type text --watch cliphist store
exec-once = wl-paste --type image --watch cliphist store

# Environment variables
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct
env = QT_QPA_PLATFORM,wayland
env = GDK_BACKEND,wayland
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland

# Input configuration
input {
    kb_layout = us
    follow_mouse = 1
    touchpad {
        natural_scroll = true
        disable_while_typing = true
        tap-to-click = true
    }
    sensitivity = 0
    accel_profile = flat
}

# General settings
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
    allow_tearing = false
}

# Decoration
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
        vibrancy = 0.1696
    }
    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Animations
animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Layouts
dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_status = master
}

# Gestures
gestures {
    workspace_swipe = true
    workspace_swipe_fingers = 3
}

# Misc settings
misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
    mouse_move_enables_dpms = true
    key_press_enables_dpms = true
    vrr = 0
}

# Window rules
windowrulev2 = suppressevent maximize, class:.*
windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(blueman-manager)$
windowrulev2 = float, class:^(nm-connection-editor)$

# Keybindings
$mainMod = SUPER

# Application shortcuts
bind = $mainMod, RETURN, exec, kitty
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, walker
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, F, fullscreen,
bind = $mainMod SHIFT, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

# Move focus with arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Move focus with vim keys
bind = $mainMod, h, movefocus, l
bind = $mainMod, l, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, j, movefocus, d

# Switch workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move window to workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through workspaces
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Resize windows with keyboard
bind = $mainMod CTRL, left, resizeactive, -20 0
bind = $mainMod CTRL, right, resizeactive, 20 0
bind = $mainMod CTRL, up, resizeactive, 0 -20
bind = $mainMod CTRL, down, resizeactive, 0 20

# Screenshots
bind = , Print, exec, grim -g "$(slurp)" - | wl-copy && notify-send "Screenshot" "Copied to clipboard"
bind = SHIFT, Print, exec, grim - | wl-copy && notify-send "Screenshot" "Fullscreen copied to clipboard"
bind = $mainMod, Print, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png && notify-send "Screenshot" "Saved to ~/Pictures/Screenshots/"

# Media keys
bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous

# Brightness
bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
EOF
print_success "Hyprland configured"

# Configure Waybar
print_step "Configuring Waybar"
print_info "Writing Waybar configuration..."
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "spacing": 4,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "battery", "tray"],
    
    "hyprland/workspaces": {
        "disable-scroll": false,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "urgent": "",
            "focused": "",
            "default": ""
        }
    },
    
    "hyprland/window": {
        "format": "{}",
        "max-length": 50
    },
    
    "clock": {
        "format": "{:%H:%M  %d/%m/%Y}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
    },
    
    "battery": {
        "states": {
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": " {capacity}%",
        "format-plugged": " {capacity}%",
        "format-icons": ["", "", "", "", ""]
    },
    
    "network": {
        "format-wifi": " {essid}",
        "format-ethernet": " {ifname}",
        "format-disconnected": "⚠ Disconnected",
        "tooltip-format": "{ifname}: {ipaddr}/{cidr}"
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": " Muted",
        "format-icons": {
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },
    
    "tray": {
        "icon-size": 21,
        "spacing": 10
    }
}
EOF

cat > ~/.config/waybar/style.css << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
    font-size: 13px;
    min-height: 0;
}

window#waybar {
    background: rgba(26, 27, 38, 0.9);
    color: #cdd6f4;
}

#workspaces button {
    padding: 0 5px;
    color: #cdd6f4;
    background-color: transparent;
}

#workspaces button.active {
    color: #89b4fa;
}

#workspaces button.urgent {
    color: #f38ba8;
}

#window,
#clock,
#battery,
#network,
#pulseaudio,
#tray {
    padding: 0 10px;
}

#battery.charging {
    color: #a6e3a1;
}

#battery.warning:not(.charging) {
    color: #f9e2af;
}

#battery.critical:not(.charging) {
    color: #f38ba8;
}

#network.disconnected {
    color: #f38ba8;
}
EOF
print_success "Waybar configured"

# Configure Kitty
print_step "Configuring Kitty Terminal"
cat > ~/.config/kitty/kitty.conf << 'EOF'
# Vilo Kitty Configuration

font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        11.0

background_opacity 0.9
window_padding_width 10

# Color scheme (Catppuccin Mocha)
foreground #cdd6f4
background #1e1e2e
cursor #f5e0dc

color0  #45475a
color1  #f38ba8
color2  #a6e3a1
color3  #f9e2af
color4  #89b4fa
color5  #f5c2e7
color6  #94e2d5
color7  #bac2de
color8  #585b70
color9  #f38ba8
color10 #a6e3a1
color11 #f9e2af
color12 #89b4fa
color13 #f5c2e7
color14 #94e2d5
color15 #a6adc8
EOF
print_success "Kitty configured"

# Create screenshots directory
mkdir -p ~/Pictures/Screenshots
print_info "Created screenshots directory"

# Create session starter
print_step "Creating Session Starter"
SESSION_FILE="$HOME/.local/share/applications/vilo-hyprland.desktop"
mkdir -p "$(dirname "$SESSION_FILE")"

cat > "$SESSION_FILE" << 'EOF'
[Desktop Entry]
Name=Vilo Hyprland
Comment=Hyprland with Vilo configuration
Exec=Hyprland
Type=Application
EOF
print_success "Session starter created"

# Installation complete
clear
echo -e "${GREEN}"
cat << 'EOF'
╔═══════════════════════════════════════╗
║     Vilo Installation Complete!       ║
╚═══════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${CYAN}Installation Summary:${NC}"
print_success "Hyprland environment installed"
print_success "Waybar status bar configured"
print_success "Walker launcher installed"
print_success "All configurations applied"
echo ""

echo -e "${BLUE}Next Steps:${NC}"
echo "  1. Reboot your system or log out"
echo "  2. Select 'Hyprland' from your display manager"
echo "  3. Log in and enjoy Vilo!"
echo ""

echo -e "${YELLOW}Essential Keybindings:${NC}"
echo "  SUPER + RETURN       → Open terminal"
echo "  SUPER + R            → Launch Walker"
echo "  SUPER + Q            → Close window"
echo "  SUPER + M            → Exit Hyprland"
echo "  SUPER + E            → File manager"
echo "  SUPER + F            → Fullscreen"
echo "  SUPER + V            → Toggle floating"
echo "  SUPER + 1-9          → Switch workspace"
echo "  SUPER + SHIFT + 1-9  → Move window to workspace"
echo "  Print                → Screenshot area"
echo "  SHIFT + Print        → Screenshot fullscreen"
echo ""

echo -e "${MAGENTA}Configuration Files:${NC}"
echo "  Hyprland: ~/.config/hypr/hyprland.conf"
echo "  Waybar:   ~/.config/waybar/"
echo "  Kitty:    ~/.config/kitty/kitty.conf"
echo ""

echo -e "${CYAN}Join Our Community:${NC}"
echo "  Discord: https://discord.gg/6naeNfwEtY"
echo ""

print_success "Installation completed successfully!"
echo ""
read -p "Press Enter to exit..."
