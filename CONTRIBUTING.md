# Contributing to Vilo

Thank you for your interest in contributing to Vilo! We welcome contributions from the community and appreciate your support in improving the distribution.

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

* **Bug Reports**: Help identify and fix issues
* **Feature Requests**: Suggest new features or improvements
* **Code Contributions**: Submit patches, bug fixes, or new features
* **Documentation**: Improve guides, tutorials, and documentation
* **Testing**: Test new releases and provide feedback
* **Package Maintenance**: Help maintain packages in the Ractor repository
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
* OpenGL 3.0+ compatible GPU

### Setting Up Development Environment

1. **Install Vilo** following the installation guide:

   ```bash
   curl -fsSL https://github.com/CyberHuman-bot/VILO-BASE-DEV/releases/download/viloinstall/install | bash
   ```
2. **Install development tools**:

   ```bash
   sudo pacman -S base-devel git
   ```
3. **Set up your development environment** according to the component you're working on.

## Contribution Guidelines

### Code Style

* Follow existing project code style
* Use meaningful variable and function names
* Comment complex logic
* Keep functions modular and focused

### Commit Messages

```
[Component] Brief description of change

Detailed explanation of what changed and why. Include relevant context or issue numbers.

Fixes #123
```

Examples:

* `[Package] Update system dependencies`
* `[Docs] Improve installation guide clarity`

### Branch Naming

* `feature/add-feature`
* `bugfix/fix-issue`
* `docs/update-guide`
* `refactor/module`

### Documentation

* Update relevant documentation for changes
* Add comments to code where necessary
* Include usage examples for new features

## Pull Request Process

1. **Update fork** with latest upstream changes:

   ```bash
   git fetch upstream
   git rebase upstream/main
   ```
2. **Test changes thoroughly**
3. **Push changes**:

   ```bash
   git push origin feature/your-feature-name
   ```
4. **Create a Pull Request** with clear title and description
5. **Respond to feedback** promptly
6. **Squash commits** if requested

### PR Checklist

* [ ] Code follows style guidelines
* [ ] All tests pass
* [ ] Documentation updated
* [ ] Commit messages clear
* [ ] No merge conflicts
* [ ] PR description explains changes

## Reporting Bugs

### Before Submitting

* Check existing issues
* Test on latest Vilo version
* Gather system info

### Submitting a Bug Report

* **Title**: Clear bug description
* **Description**: Expected vs. actual behavior, steps to reproduce, system info, logs, screenshots if applicable

## Suggesting Enhancements

* Check existing feature requests
* Describe feature in detail
* Explain use case
* Provide examples or alternatives

## Component-Specific Guidelines

### System Components

* Maintain backward compatibility
* Document breaking changes
* Test on clean installations

### Package Management

* Follow Arch Linux packaging guidelines
* Test package installation/removal
* Verify dependencies and metadata

## Community

* **Discord**: [Join the server](https://discord.gg/6naeNfwEtY)
* **GitHub Issues**: For bugs and feature requests
* **GitHub Discussions**: General discussion and help

## Additional Resources

* [Vilo Documentation](#)
* [Arch Linux Wiki](https://wiki.archlinux.org/)
* [Pacman Documentation](https://wiki.archlinux.org/title/Pacman)

## Recognition

Contributors recognized in README, release notes, and website where applicable.

## Questions?

* Ask on Discord
* Open a discussion on GitHub
* Contact maintainers

---

Thank you for contributing to Vilo!

**Built with ❤️ by the Vilo community
