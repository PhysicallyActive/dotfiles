# Dotfiles

**HOW TO SET EVERYTHING UP ON WORK COMP**:

1. Comment everything in the `nvim/lua/plugins` folder out.
2. Update LazyVim `<leader>l` + `U`
3. Uncomment everything in `nvim/lua/plugins` folder.
4. Update LazyVim `<leader>l` + `U`

This repo holds my dotfiles. They are specific to my needs but if you are a
Rust, Python, Julia, C, Lua, or Bash programmer you might find something useful
here.

## Installation

```
    sh setup.sh
```

This symlinks the dotfiles, folders, and files into your home folder.
To install the vim plugins, there are some extra steps that I'll have to upload at some point

## Dependencies

To be installed before doing anything else:

- `npm`
- `packer` repo
- `vscode`
