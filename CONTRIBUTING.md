# Contributing to Vilo

Thank you for your interest in contributing to Vilo! We welcome contributions from the community and appreciate your support in improving the project.

## Table of Contents

* [Code of Conduct](#code-of-conduct)
* [How Can I Contribute?](#how-can-i-contribute)
* [Getting Started](#getting-started)
* [Development Setup](#development-setup)
* [Contribution Guidelines](#contribution-guidelines)
* [Pull Request Process](#pull-request-process)
* [Reporting Bugs](#reporting-bugs)
* [Suggesting Enhancements](#suggesting-enhancements)
* [Community](#community)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for everyone. Be kind, professional, and constructive in all interactions.

## How Can I Contribute?

Ways to contribute:

* **Bug Reports**: Help identify and fix issues across different distributions
* **Feature Requests**: Suggest new features or improvements
* **Code Contributions**: Submit patches, bug fixes, or new features
* **Documentation**: Improve guides, tutorials, and documentation
* **Testing**: Test new releases on different distributions and provide feedback
* **Distribution Support**: Help improve support for various Linux distributions
* **Package Maintenance**: Help maintain packages across different package managers
* **Community Support**: Assist other users on Discord or forums

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:

   ```bash
   git clone https://github.com/CyberHuman-bot/Vilo.git
   cd Vilo
   ```
3. **Add the upstream repository**:

   ```bash
   git remote add upstream https://github.com/CyberHuman-bot/Vilo.git
   ```
4. **Create a feature branch**:

   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

### System Requirements

* 64-bit x86_64 processor
* 4GB RAM (minimum 2GB)
* 20GB available storage
* Vulkan-compatible GPU (recommended for Hyprland)
* One of the supported distributions: Arch Linux, Fedora 40+, Ubuntu 24.10+

### Setting Up Development Environment

1. **Install Vilo** following the installation guide:

   ```bash
   curl -fsSL https://github.com/CyberHuman-bot/Vilo/releases/download/install/install | bash
   ```

2. **Install development tools based on your distribution**:

   **Arch Linux:**
   ```bash
   sudo pacman -S base-devel git
   ```

   **Fedora:**
   ```bash
   sudo dnf groupinstall "Development Tools"
   sudo dnf install git
   ```

   **Ubuntu/Debian:**
   ```bash
   sudo apt-get install build-essential git
   ```

3. **Set up your development environment** according to the component you're working on.

### Testing on Multiple Distributions

When contributing features that affect installation or distribution-specific behavior:

* Test on at least **Arch Linux** (primary platform)
* If possible, test on **Fedora** (secondary platform)
* For Debian/Ubuntu changes, test on **Ubuntu 24.10+** or document limitations
* Use virtual machines or containers for testing multiple distributions

## Contribution Guidelines

### Code Style

* Follow existing project code style
* Use meaningful variable and function names
* Comment complex logic, especially distribution-specific code
* Keep functions modular and focused
* Add distribution detection when adding platform-specific features

### Shell Script Best Practices

* Use `set -e` and `set -u` for error handling
* Quote variables properly
* Use functions for reusable code
* Test scripts on multiple distributions
* Handle package manager differences gracefully

### Commit Messages

```
[Component] Brief description of change

Detailed explanation of what changed and why. Include relevant context or issue numbers.
Mention distributions affected if applicable.

Fixes #123
```

Examples:

* `[Install] Add support for Fedora package installation`
* `[Docs] Update installation guide for Ubuntu 24.10`
* `[Hyprland] Fix config issues on Debian-based systems`

### Branch Naming

* `feature/add-feature`
* `bugfix/fix-issue`
* `docs/update-guide`
* `distro/distribution-name` (for distribution-specific changes)
* `refactor/module`

### Documentation

* Update relevant documentation for changes
* Add comments to code where necessary
* Include usage examples for new features
* Document distribution-specific behavior or limitations
* Update README if support changes

## Pull Request Process

1. **Update fork** with latest upstream changes:

   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Test changes thoroughly**
   - Test on your primary distribution
   - If changes affect installation, test on other distributions when possible
   - Document any distribution-specific issues

3. **Push changes**:

   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create a Pull Request** with clear title and description
   - Mention distributions tested
   - Note any distribution-specific behavior
   - Link related issues

5. **Respond to feedback** promptly

6. **Squash commits** if requested

### PR Checklist

* [ ] Code follows style guidelines
* [ ] All tests pass
* [ ] Documentation updated
* [ ] Commit messages clear
* [ ] No merge conflicts
* [ ] PR description explains changes
* [ ] Tested on at least one supported distribution
* [ ] Distribution-specific behavior documented

## Reporting Bugs

### Before Submitting

* Check existing issues
* Test on latest Vilo version
* Gather system info including distribution and version
* Test on a clean installation if possible

### Submitting a Bug Report

**Required Information:**
* **Distribution**: (e.g., Arch Linux, Fedora 40, Ubuntu 24.10)
* **Vilo Version**: Output of relevant version commands
* **Title**: Clear bug description
* **Description**: 
  - Expected vs. actual behavior
  - Steps to reproduce
  - System info (distribution, kernel version, etc.)
  - Relevant logs
  - Screenshots if applicable

**Example:**
```
Distribution: Fedora 40
Kernel: 6.8.5
Vilo Version: Latest from main branch

**Description:**
Waybar fails to start on Fedora 40 after installation...
```

## Suggesting Enhancements

* Check existing feature requests
* Describe feature in detail
* Explain use case
* Consider impact on different distributions
* Provide examples or alternatives
* Note if enhancement is distribution-specific

## Component-Specific Guidelines

### Installation Scripts

* Support all officially supported distributions
* Gracefully handle unsupported distributions with clear messages
* Use distribution detection functions
* Test package installation on multiple platforms
* Provide fallbacks when packages are unavailable
* Document distribution-specific workarounds

### System Components

* Maintain backward compatibility
* Document breaking changes
* Test on clean installations across distributions
* Consider different package managers (pacman, dnf, apt)

### Package Management

* **Arch Linux**: Follow Arch packaging guidelines, use AUR when appropriate
* **Fedora**: Use DNF best practices, consider Copr repositories
* **Ubuntu/Debian**: Use APT conventions, handle PPA additions carefully
* Test package installation and removal
* Verify dependencies are available across distributions
* Document when packages have different names on different distributions

### Configuration Files

* Ensure configs work across distributions
* Handle distribution-specific paths
* Test on different versions of dependencies
* Document any distribution-specific config requirements

## Distribution Support

### Adding Support for New Distributions

When adding support for a new distribution:

1. Update distribution detection in installation scripts
2. Add package manager logic
3. Map package names to distribution equivalents
4. Test thoroughly on the new distribution
5. Update documentation (README, CONTRIBUTING)
6. Add to supported distributions list
7. Note any limitations or special requirements

### Improving Existing Distribution Support

* Test on latest distribution versions
* Update package lists as dependencies change
* Document workarounds for known issues
* Improve error messages and user guidance

## Community

* **Discord**: [Join the server](https://discord.gg/6naeNfwEtY)
* **GitHub Issues**: For bugs and feature requests
* **GitHub Discussions**: General discussion and help

## Additional Resources

* [Vilo Documentation](#)
* [Arch Linux Wiki](https://wiki.archlinux.org/)
* [Fedora Documentation](https://docs.fedoraproject.org/)
* [Ubuntu Documentation](https://help.ubuntu.com/)
* [Hyprland Wiki](https://wiki.hyprland.org/)

## Recognition

Contributors recognized in README, release notes, and website where applicable.

## Questions?

* Ask on Discord
* Open a discussion on GitHub
* Contact maintainers

---

Thank you for contributing to Vilo!

**Built with ❤️ by the Vilo community**
