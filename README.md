# Vilo - Arch Linux Configuration Extension

<div align="center">

[![Discord Card](https://discord.com/api/guilds/1428713325692190844/widget.png?style=banner1)](https://discord.gg/6naeNfwEtY)

[Features](#features) • [Installation](#installation) • [Documentation](#documentation) • [Community](#community)

</div>

## Overview

Vilo is an automated setup tool for Arch Linux that configures Hyprland and a complete desktop environment. Inspired by Omarchy, it provides a streamlined way to get a working system with minimal manual configuration.

Run one command on a fresh Arch Linux installation, and Vilo handles the rest—installing packages, configuring Hyprland, setting up your desktop components, and applying a cohesive theme.

## What Vilo Does

* **Automated Hyprland Setup**: Configures Hyprland compositor with optimized settings
* **Desktop Environment**: Installs and configures essential desktop components (status bar, launcher, terminal, etc.)
* **Development Tools**: Pre-configures common development environments
* **Theming & Aesthetics**: Applies a cohesive visual theme across all components
* **System Optimization**: Implements performance tweaks and best practices

## Features

* **One-Command Setup**: Transform Arch Linux into a complete desktop environment instantly
* **Ractor Package Manager**: Fast, reliable package management built on top of pacman
* **Rolling Release**: Inherits Arch Linux's rolling release model
* **Minimalist Philosophy**: Clean, bloat-free configuration you can customize
* **Developer Friendly**: Preloaded with essential development tools and configurations
* **Hyprland-Centric**: Optimized specifically for the Hyprland wayland compositor

## Prerequisites

Vilo requires a **base Arch Linux installation**. You must have:

* A working Arch Linux system (installed via archinstall or manual installation)
* An internet connection
* Root or sudo access

## Installation

### System Requirements

* **Base System**: Arch Linux (installed)
* **CPU**: 64-bit (x86_64)
* **RAM**: 2GB minimum (4GB recommended for Hyprland)
* **Storage**: 20GB available
* **Graphics**: GPU with Vulkan support (recommended for Hyprland)

### Quick Start

On your existing Arch Linux installation, run:

```bash
curl -fsSL https://github.com/CyberHuman-bot/Vilo/releases/download/install/install | bash
```

The script will:
1. Install necessary packages
2. Configure Hyprland with optimized settings
3. Set up your desktop environment
4. Apply theming and configurations

Then reboot your system to launch into your configured Hyprland environment.

## What Gets Configured

Vilo automatically configures:

* **Hyprland compositor** with custom keybindings and animations
* **Status bar** (Waybar or similar)
* **Application launcher** (Rofi/Wofi)
* **Terminal emulator** with shell configuration
* **Notification daemon**
* **File manager**
* **Audio system** (PipeWire/WirePlumber)
* **Network management**
* **Display manager** (optional)

## Documentation

Vilo provides comprehensive guides for:

* Pre-installation (setting up Arch Linux)
* Post-installation configuration
* Customizing Hyprland settings
* Package management with Ractor
* Troubleshooting common issues

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
A: No. Vilo is a configuration tool that extends Arch Linux. You need an existing Arch installation.

**Q: Can I use Vilo on other distributions?**  
A: No. Vilo is specifically designed for Arch Linux and relies on its package management system.

**Q: Will this overwrite my existing configurations?**  
A: The installer will back up existing configurations before making changes. Review the installation script before running.

**Q: Can I customize the setup?**  
A: Absolutely! All configurations are stored in standard locations (~/.config, /etc) and can be modified after installation.

## Acknowledgments

Inspired by Omarchy and the Arch Linux philosophy. Special thanks to the Hyprland project and all contributors to the Vilo community.

---

**Built with ❤️ by the Vilo community**

*Vilo: Making Arch + Hyprland setup effortless*
