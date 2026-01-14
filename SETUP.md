# Neovim Configuration - Setup Guide

This configuration uses **lazy.nvim** for plugin management (optimized, replaces packer).

## 📦 First Time Setup on New Machine

### 1. Clone this config:
```bash
git clone <your-repo-url> ~/.config/nvim
cd ~/.config/nvim
git checkout optimize-config  # Use optimized branch
```

### 2. Install dependencies (if needed):
```bash
# Ubuntu/Debian
sudo apt install git curl build-essential

# macOS
brew install git curl
```

### 3. Start Neovim:
```bash
nvim
```

### 🚀 What happens automatically:

1. **lazy.nvim** bootstraps itself (auto-clones from GitHub)
2. **All plugins** are automatically installed on first launch
3. **Treesitter parsers** auto-install for common languages (lua, vim, python, js, etc.)
4. **Mason** can be run with `:Mason` to install LSP servers

### 4. Optional - Install additional treesitter parsers:
```vim
:lua require('nvim-treesitter').install('rust')
:lua require('nvim-treesitter').install('go')
```

Or let `ensure_installed` in `after/plugin/treesitter.lua` handle it automatically.

### 5. Optional - Install LSP servers:
```vim
:Mason
# Then select and install servers you need (pyright, gopls, rust-analyzer, etc.)
```

## 🔄 Syncing Plugins

Unlike packer, lazy.nvim automatically manages plugins:
- **Auto-install** missing plugins on startup
- **Update all**: `:Lazy update`
- **Check status**: `:Lazy`
- **Clean unused**: `:Lazy clean`

## 📁 Config Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/duynn/
│   ├── init.lua               # Loads all modules
│   ├── lazy.lua               # Plugin definitions (replaces packer.lua)
│   ├── set.lua                # Vim settings
│   ├── keymap.lua             # Key mappings
│   ├── cmd.lua                # Custom commands
│   ├── toggle.lua             # Toggle functions
│   ├── autocmd_new.lua        # Auto commands
│   └── config/
│       └── aerial.lua         # Large plugin configs
├── ftplugin/                  # Filetype-specific settings
│   ├── python.lua
│   ├── go.lua
│   ├── javascript.lua
│   └── ...
└── after/plugin/              # Plugin configurations
    ├── treesitter.lua
    ├── lspconfig.lua
    ├── cmp.lua
    └── ...
```

## ⚡ Performance

- **Startup time**: ~49ms (50% faster than old packer config)
- **Lazy-loading**: Most plugins load on-demand
- **Optimized autocmds**: Moved to ftplugin files

## 🆚 Differences from Old Packer Config

| Feature | Old (Packer) | New (lazy.nvim) |
|---------|-------------|-----------------|
| Plugin manager | packer.nvim | lazy.nvim |
| Startup time | ~91ms | ~49ms |
| Auto-install | Manual `:PackerSync` | Automatic on first launch |
| Lazy-loading | Manual config | Built-in, automatic |
| Autocmds | 100+ in one file | Split into ftplugin files |
| Treesitter | Manual install | Auto-install on first use |

## 🔧 Troubleshooting

### Plugins not loading?
```vim
:Lazy sync
```

### Treesitter not highlighting?
```vim
:lua require('nvim-treesitter').install('python')
```

### LSP not working?
```vim
:Mason
# Install your language server
```

### Start fresh?
```bash
rm -rf ~/.local/share/nvim/lazy
nvim  # Will reinstall everything
```

## 📝 Notes

- The `main` branch still has old packer config (backup)
- The `optimize-config` branch has the new lazy.nvim setup
- All your keybindings and settings are preserved
- Packer directory removed (freed 369MB)
