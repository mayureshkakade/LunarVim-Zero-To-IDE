## Overview

This repository contains the configuration files for setting up LunarVim, a customizable and extensible Neovim configuration. LunarVim aims to provide a modern and feature-rich development environment.

## Folder Structure

- `lvim/`
  - `config.lua`: Main configuration file for LunarVim.
  - `user/`
    - `options.lua`: Contains custom options and settings.
    - `keymaps.lua`: Defines custom key mappings.
    - `which-key.lua`: Configuration for the `which-key` plugin.
    - `plugins.lua`: List and configuration of additional plugins.
    - `lsp.lua`: Language Server Protocol (LSP) configurations.

## Configuration Files

### `lvim/config.lua`

This is the main configuration file for LunarVim. It includes references to other configuration files located in the `user` directory. The file also provides useful links to documentation, example configurations, video tutorials, forum, and Discord community.

### `user/options.lua`

This file contains custom options and settings for Neovim. It allows you to tweak various aspects of the editor to suit your preferences.

### `user/keymaps.lua`

Defines custom key mappings to enhance your workflow. You can add, remove, or modify key bindings as needed.

### `user/which-key.lua`

Configuration for the `which-key` plugin, which provides a popup displaying available key bindings in Neovim. This helps in discovering and remembering key mappings.

### `user/plugins.lua`

Lists and configures additional plugins to extend the functionality of LunarVim. You can add new plugins or configure existing ones here.

### `user/lsp.lua`

Contains configurations for the Language Server Protocol (LSP). This file is used to set up language servers, enabling features like code completion, linting, and more.

## Getting Started

To get started with this configuration:

1. Clone the repository.
2. Install LunarVim by following the [installation guide](https://www.lunarvim.org/docs/installation).
3. Copy the contents of this repository to your LunarVim configuration directory (usually `~/.config/lvim`).
4. Launch LunarVim and enjoy your customized development environment.

## Resources

- [LunarVim Documentation](https://www.lunarvim.org/docs/configuration)
- [Example Configurations](https://github.com/LunarVim/starter.lvim)
- [Video Tutorials](https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6)
- [LunarVim Forum](https://www.reddit.com/r/lunarvim/)
- [LunarVim Discord](https://discord.com/invite/Xb9B4Ny)
