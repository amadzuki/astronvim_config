# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is an **AstroNvim v5+** configuration repository. AstroNvim is a community distribution of Neovim that provides a highly customizable foundation with excellent defaults.

## Key Architecture

### Plugin Management
- Uses **Lazy.nvim** for plugin management
- Plugin specifications are organized in `/lua/plugins/` directory
- Main lazy setup is in `lua/lazy_setup.lua`
- Community plugins imported via `lua/community.lua`

### Configuration Structure
```
├── init.lua              # Bootstrap script, calls lazy_setup and polish
├── lua/
│   ├── lazy_setup.lua    # Core Lazy.nvim configuration and AstroNvim setup
│   ├── polish.lua        # Customizations that run last (currently disabled)
│   ├── community.lua     # AstroCommunity imports (Lua pack, Catppuccin theme)
│   └── plugins/          # Individual plugin configurations
│       ├── user.lua      # User plugins and customizations
│       ├── claudecode.lua # Claude Code integration
│       ├── astrocore.lua # Core AstroNvim features (currently disabled)
│       └── [other].lua   # Other AstroNvim plugin configs
```

### Key Configuration Files
- **`lua/lazy_setup.lua`**: Main configuration entry point with AstroNvim opts
- **`lua/plugins/user.lua`**: Active user customizations including dashboard and plugin configurations
- **`lua/plugins/claudecode.lua`**: Claude Code integration with keybindings
- **`lua/community.lua`**: Community plugin imports (Lua language pack, Catppuccin colorscheme)

## Development Workflow

### Plugin Management Commands
```bash
# Update all plugins
:nvim -c "Lazy update"

# Clean unused plugins
:nvim -c "Lazy clean"

# Install missing plugins
:nvim -c "Lazy install"

# Check plugin status
:nvim -c "Lazy status"
```

### Configuration Management
- Most user customizations go in `lua/plugins/user.lua`
- To enable currently disabled configs, remove the `if true then return {} end` lines
- The `polish.lua` file runs last in the setup process for final customizations

### Key Features Enabled
- **Leader key**: Space (`<leader>`)
- **LocalLeader**: Comma (`<localleader>`)
- **Relative line numbers**: Enabled
- **Autopairs**: Enabled
- **Code completion**: Enabled (blink.cmp)
- **Git integration**: Gitsigns
- **File tree**: Neo-tree
- **Theme**: Catppuccin
- **Claude Code integration**: Full keybinding setup

### Claude Code Integration
Key mappings (all under `<leader>a` prefix):
- `<leader>ac` - Toggle Claude
- `<leader>af` - Focus Claude
- `<leader>ar` - Resume Claude
- `<leader>aC` - Continue Claude
- `<leader>am` - Select Claude model
- `<leader>ab` - Add current buffer
- `<leader>as` - Send selection to Claude
- `<leader>aa` - Accept diff
- `<leader>ad` - Deny diff

## Plugin Categories

### Core AstroNvim Plugins
- **astrocore**: Core functionality and configuration
- **astrolsp**: LSP configuration and management
- **astroui**: UI components and theming
- **mason**: LSP server and tool installation

### Language Support
- **Lua**: Full language pack via AstroCommunity
- **Treesitter**: Syntax highlighting for multiple languages
- **LSP**: Configured language servers via mason

### UI/UX
- **Catppuccin**: Colorscheme
- **Snacks**: Dashboard (customized with ASCII art header)
- **Heirline**: Statusline
- **Neo-tree**: File explorer
- **Toggleterm**: Terminal management

### Development Tools
- **Claude Code**: AI assistant integration
- **Gitsigns**: Git integration
- **Todo-comments**: TODO highlighting
- **nvim-autopairs**: Auto bracket pairing
- **LuaSnip**: Snippet engine

## Disabled Features
Several configuration files are currently disabled (return early) and can be enabled by removing the guard line:
- `lua/polish.lua` - Final customizations
- `lua/plugins/astrocore.lua` - Custom core features, mappings, and options

## Installation/Setup
This configuration assumes:
- Neovim >= 0.9
- Git for plugin management
- Nerd Font for icon support (optional but recommended)

The configuration will automatically bootstrap Lazy.nvim and install all dependencies on first run.