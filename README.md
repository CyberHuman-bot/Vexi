# Vilo - Linux Desktop Environment Setup

<div align="center">

[![Discord Card](https://discord.com/api/guilds/1428713325692190844/widget.png?style=banner1)](https://discord.gg/6naeNfwEtY)

[Features](#features) • [Installation](#installation) • [Documentation](#documentation) • [Community](#community)

</div>

## Overview

Vilo is an automated setup tool that configures Hyprland and a complete desktop environment. Inspired by Omarchy, it provides a streamlined way to get a working system with minimal manual configuration.

Run one command on your Linux installation, and Vilo handles the rest—installing packages, configuring Hyprland, setting up your desktop components, and applying a cohesive theme.

## Supported Distributions

Vilo now supports multiple Linux distributions:

* **Arch Linux** - Full native support with AUR integration ✅
* **Fedora 40+** - Full support with official Hyprland packages ✅
* **Ubuntu 24.10+** - Limited support ⚠️ (Hyprland in universe repo, but outdated)
* **Ubuntu 24.04 and older** - Very limited support ⚠️⚠️ (Must build from source)
* **Linux Mint** - Very limited support ⚠️⚠️ (Debian-based, must build from source)
* **Debian** - Very limited support ⚠️⚠️ (Extremely outdated packages)

**Important Notes:**
- **Debian/Ubuntu**: According to Hyprland developers, Debian and Ubuntu's Hyprland packages are "extremely outdated" and not recommended. Building from source is required for older Ubuntu versions.
- **Ubuntu 24.10+**: Has Hyprland in the universe repository but may still be outdated.
- **Recommended distributions**: Arch Linux (best support) or Fedora 40+ (official packages) for the most stable experience.

## What Vilo Does

* **Automated Hyprland Setup**: Configures Hyprland compositor with optimized settings
* **Desktop Environment**: Installs and configures essential desktop components (status bar, launcher, terminal, etc.)
* **Development Tools**: Pre-configures common development environments
* **Theming & Aesthetics**: Applies a cohesive visual theme across all components
* **System Optimization**: Implements performance tweaks and best practices

## Features

* **One-Command Setup**: Transform your Linux system into a complete desktop environment instantly
* **Multi-Distro Support**: Works across Arch, Ubuntu, Fedora, and more
* **Ractor Package Manager**: Fast, reliable package management (Arch Linux)
* **Minimalist Philosophy**: Clean, bloat-free configuration you can customize
* **Developer Friendly**: Preloaded with essential development tools and configurations
* **Hyprland-Centric**: Optimized specifically for the Hyprland wayland compositor

## Prerequisites

Vilo requires a **base Linux installation**. You must have:

* A working Linux system (Arch, Ubuntu, Fedora, or Debian-based)
* An internet connection
* Root or sudo access on a normal user

## Installation

### System Requirements

* **Base System**: Supported Linux distribution (installed)
* **CPU**: 64-bit (x86_64)
* **RAM**: 2GB minimum (4GB recommended for Hyprland)
* **Storage**: 20GB available
* **Graphics**: GPU with Vulkan support (recommended for Hyprland)

### Quick Start

On your existing Linux installation, run:

```bash
curl -fsSL https://github.com/CyberHuman-bot/Vilo/releases/download/install/install | bash
```

The script will:
1. Detect your Linux distribution
2. Install necessary packages using the appropriate package manager
3. Configure Hyprland with optimized settings
4. Set up your desktop environment
5. Apply theming and configurations

Then reboot your system to launch into your configured Hyprland environment.

### Distribution-Specific Notes

#### Arch Linux
* Full support with AUR packages
* Fastest installation experience
* Walker launcher installed from AUR
* **Recommended for best experience**

#### Fedora 40+
* Uses dnf package manager
* Official Hyprland packages available
* Full support from repositories
* All features supported
* **Recommended alternative to Arch**

#### Ubuntu 24.10+ (Oracular Oriole)
* ⚠️ **Limited support**
* Hyprland available in universe repository
* May still be outdated compared to upstream
* Uses apt package manager
* JetBrains Mono Nerd Font installed manually
* Rofi used as fallback launcher

#### Ubuntu 24.04 and older / Linux Mint / Debian
* ⚠️⚠️ **Very limited support - NOT RECOMMENDED**
* According to Hyprland developers: packages are "extremely outdated"
* Requires building Hyprland from source
* Installation process is complex and may fail
* Script attempts automatic build but success not guaranteed
* Many dependencies may be too old
* **Strongly recommended**: Use Arch or Fedora instead

## What Gets Configured

Vilo automatically configures:

* **Hyprland compositor** with custom keybindings and animations
* **Status bar** (Waybar)
* **Application launcher** (Walker/Rofi/Wofi depending on availability)
* **Terminal emulator** (Kitty) with shell configuration
* **Notification daemon** (Dunst)
* **File manager** (Thunar)
* **Audio system** (PipeWire/WirePlumber)
* **Network management** (NetworkManager)
* **Bluetooth support** (BlueZ/Blueman)
* **Screenshot tools** (Grim/Slurp)

## Documentation

Vilo provides comprehensive guides for:

* Pre-installation (setting up your Linux distribution)
* Post-installation configuration
* Customizing Hyprland settings
* Package management
* Troubleshooting common issues
* Distribution-specific tips

Visit our [documentation portal](#) for tutorials and detailed instructions.

## Community

Connect with the Vilo community:

* **Discord**: [Join the server](https://discord.gg/6naeNfwEtY)
* **GitHub**: Report issues, suggest features, or contribute code
* **Forum**: Participate in discussions and support

## License

This project is licensed under the **MIT License**. You are free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of this software, as long as the original copyright notice is included.

See the [LICENSE](LICENSE) file for full details.

## Contributing

Vilo is open-source and welcomes contributions to improve the configuration and setup process.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## Frequently Asked Questions

**Q: Is Vilo a Linux distribution?**  
A: No. Vilo is a configuration tool that extends existing Linux distributions. You need an existing installation.

**Q: Can I use Vilo on other distributions not listed?**  
A: The script supports Arch, Debian-based (Debian, Ubuntu, Linux Mint), Fedora, and their derivatives. Other distributions may work if they're based on these, but are not officially tested.

**Q: Will this overwrite my existing configurations?**  
A: The installer will back up existing configurations before making changes. Backups are stored with timestamps (e.g., `.backup.20250101_120000`).

**Q: Can I customize the setup?**  
A: Absolutely! All configurations are stored in standard locations (~/.config, /etc) and can be modified after installation.

**Q: Why is Debian-based support limited?**  
A: According to the official Hyprland documentation, Debian and Ubuntu's packaged versions are "extremely outdated" and building from source is recommended. This makes installation complex and unreliable. Fedora 40+ and Arch have up-to-date official packages.

**Q: Which distribution do you recommend?**  
A: **Best**: Arch Linux (most up-to-date, AUR support). **Good**: Fedora 40+ (official packages). **Not recommended**: Debian, Ubuntu <24.10, Linux Mint (outdated packages, requires building from source).

**Q: I'm on Ubuntu, should I switch?**  
A: If you're on Ubuntu 24.10+, it may work but expect some issues. If you're on older versions, you'll need to build from source which is complex. For the best Hyprland experience, consider Arch or Fedora.

## Acknowledgments

Inspired by Omarchy and the Arch Linux philosophy. Special thanks to the Hyprland project, all supported Linux distributions, and all contributors to the Vilo community.

---

**Built with ❤️ by the Vilo community**

*Vilo: Making Hyprland setup effortless across Linux distributions*
