# dotfiles

Personal terminal configuration for **WSL2 + xterm + GNU Screen + neovim**.

Warm dark theme based on **Base16 Atelier Dune** with a focus on readable
vim visual selections and a friction-free xterm workflow.

## Quick Start

```bash
git clone https://github.com/<user>/dotfiles ~/dotfiles
cd ~/dotfiles
./install
```

Restart your shell or `source ~/.bashrc`, then just type `xterm` — everything
is configured automatically (font, size, colors, clipboard).

## Uninstall

```bash
cd ~/dotfiles
./install --uninstall
```

Restores the most recent backup from `~/.dotfiles_backup/`.

## Repo Layout

```
dotfiles/
├── install                     # deployment script (symlinks + backup)
├── README.md
├── home/                       # files that live in ~/
│   ├── bashrc                  #  → ~/.bashrc
│   ├── inputrc                 #  → ~/.inputrc
│   ├── screenrc                #  → ~/.screenrc
│   └── Xresources              #  → ~/.Xresources
└── config/                     # files that live in $XDG_CONFIG_HOME/
    ├── bash/
    │   └── bash_alias          #  → ~/.config/bash/bash_alias
    └── vim/                    #  (reserved for vimrc work)
```

## How It Works

The `install` script creates **symlinks** from `~` and `$XDG_CONFIG_HOME`
into this repo. Editing the repo files edits your live config — no copying
needed. This also means `git diff` in the repo shows exactly what changed
in your running environment.

Existing files are backed up to `~/.dotfiles_backup/<timestamp>/` before
any symlink is created.

## Dependencies

```bash
sudo apt install xterm xfonts-base xclip
```

Font: **Source Code Pro** (install via your distro or from Google Fonts).

## Adding New Dotfiles

1. Place the file under `home/` or `config/` in this repo
2. Add a mapping in the `LINKS` array in `install`:
   ```bash
   ["config/nvim/init.vim"]="$XDG_CONFIG_HOME/nvim/init.vim"
   ```
3. Run `./install` again — it's idempotent
