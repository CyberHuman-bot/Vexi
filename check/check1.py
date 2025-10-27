import subprocess

# List of packages to check
packages = [
    'hyprland',
    'xdg-desktop-portal-hyprland',
    'qt5-wayland',
    'qt6-wayland',
    'polkit-kde-agent',
    'kitty',
    'dunst',
    'rofi-wayland',
    'swww',
    'grim',
    'slurp',
    'wl-clipboard',
    'cliphist',
    'brightnessctl',
    'playerctl',
    'pavucontrol',
    'network-manager-applet',
    'bluez',
    'bluez-utils',
    'blueman',
    'thunar',
    'pipewire',
    'pipewire-pulse',
    'wireplumber'
]

print("Checking if packages are installed...")

for pkg in packages:
    result = subprocess.run(['pacman', '-Qi', pkg], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if result.returncode == 0:
        print(f'[✔] {pkg} is installed')
    else:
        print(f'[✖] {pkg} is NOT installed')

print("\nCheck completed.")
