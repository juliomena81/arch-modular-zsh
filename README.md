# ZSH Setup

Modular Zsh setup for daily use on Arch Linux (Wayland, ISO-ES keyboard).

### Features

- **Modular**: `.zshrc` plus `aliases.zsh`, `functions.zsh`, `keybinds.zsh`.
- **Fast startup**: lazy `compinit` on the first prompt (~45 ms).
- **History**: 100,000 lines, shared, deduplicated, noise filtered.
- **fzf** with Catppuccin Mocha colors and terminal-owned background.
- **zoxide** replaces `cd` while keeping `cd -`.
- **starship** prompt.
- **zsh-autosuggestions** + **fast-syntax-highlighting**, loaded in the right order.
- **ZLE keybinds** designed for a Spanish keyboard.
- **Zellij**: `zj` launcher with menu, layouts and sessions.
- **Extras**: `yazi`, `bat`, `eza`.

### Layout

| Path                            | Contents                                        |
| ------------------------------- | ----------------------------------------------- |
| `~/.zshrc`                      | Options, history, compinit, modules and plugins |
| `~/.zshenv`                     | Environment (`EDITOR`, `PAGER`, zoxide, fzf)    |
| `~/.config/zsh/aliases.zsh`     | Aliases                                         |
| `~/.config/zsh/functions.zsh`   | Functions (`zj`, `cpfile`, `cs`, `fkill`…)      |
| `~/.config/zsh/keybinds.zsh`    | Command-line keybinds                           |
| `~/.config/zsh/zsh_completion/` | Custom completions (`$fpath`)                   |
| `~/.cache/zsh/zcompdump-*`      | compinit dump                                   |

### Requirements

```bash
sudo pacman -S --needed \
  zsh starship fzf zoxide eza bat fd ripgrep glow \
  zellij yazi trash-cli tldr btop duf neovim \
  wl-clipboard rsync libarchive curl
```

Optional plugins (loaded if present):

| Plugin                   | Expected path                                      |
| ------------------------ | -------------------------------------------------- |
| zsh-sudo                 | `/usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh`  |
| zpy                      | `/usr/share/zsh/plugins/zpy/zpy.plugin.zsh`        |
| find-the-command         | `/usr/share/doc/find-the-command/ftc.zsh`          |
| fast-syntax-highlighting | `/usr/share/zsh/plugins/fast-syntax-highlighting/` |
| zsh-autosuggestions      | `/usr/share/zsh/plugins/zsh-autosuggestions/`      |

```bash
# 1. Clone
git clone https://github.com/juliomena81/arch-modular-zsh.git ~/dotfiles

# 2. Symlink
ln -sf ~/dotfiles/.zshrc  ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sfn ~/dotfiles/zsh     ~/.config/zsh

# 3. Default shell
chsh -s /usr/bin/zsh
exec zsh
```

### Keybinds

| Key                          | Action                       |
| ---------------------------- | ---------------------------- |
| `Ctrl+←` / `Ctrl+→`          | Previous / next word         |
| `Home` / `End`               | Beginning / end of line      |
| `Delete`                     | Delete character             |
| `Ctrl+Delete` / `Alt+Delete` | Kill word backward / forward |
| `Ctrl+Backspace` / `Ctrl+W`  | Kill word backward           |
| `Ctrl+U` / `Ctrl+K`          | Kill whole line / to end     |
| `↑` / `↓`                    | Prefix history search        |
| `Ctrl+R`                     | fzf history                  |
| `Ctrl+T`                     | fzf file picker              |
| `Tab`                        | fzf completion               |
| `Alt+C`                      | fzf directory jump           |
| `Alt+E`                      | Edit line in `$EDITOR`       |
| `Alt+Z`                      | Zellij menu                  |
| `Esc Esc`                    | Prepend `sudo`               |

### Aliases

| Group   | Examples                                                                                                                      |
| ------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Files   | `ls`, `la`, `ll`, `lh`, `tree`, `lt`, `ftree`, `...`, `....`                                                                  |
| Readers | `cat`, `catp`, `grep`, `help`                                                                                                 |
| System  | `top`, `df`, `du`, `cp`, `cpr`, `mv`, `mkdir`, `free`, `diff`, `ip`, `ports`, `myip`, `jctl`, `jfollow`, `scf`, `v`, `reload` |
| Git     | `g`, `gs`, `gd`, `gds`, `gl`, `ga`, `gc`, `gcm`, `gco`, `gb`, `gp`, `gpl`                                                     |
| Pacman  | `pacs`, `pacq`, `paci`, `pacr`, `pacu`, `orphans`                                                                             |
| Zellij  | `zd`, `zy`, `zs`, `zl`, `zk`, `zka`                                                                                           |
| Trash   | `rm`, `trash-list`, `trash-restore`, `trash-empty`                                                                            |

### Functions

| Function               | Action                                        |
| ---------------------- | --------------------------------------------- |
| `zj [layout\|session]` | Zellij menu/launcher (`zj -l` lists)          |
| `cpfile <file>`        | Copy file contents to clipboard               |
| `chtsh <topic>`        | cheat.sh through `bat`                        |
| `y [args]`             | Open yazi                                     |
| `x <file...>`          | Extract each archive into its own folder      |
| `mkcd <dir>`           | Create directory and enter it                 |
| `fe`                   | Pick a file with fzf and open it in `$EDITOR` |
| `fkill [signal]`       | Kill a process picked with fzf                |
| `cs`                   | Pick a cheatsheet and open it with `glow`     |

### Zellij

```bash
zj          # session and layout menu
zj -l       # list
zd          # dev layout
zy          # yazi + nvim layout
zs          # clean session
zk <name>   # kill session
```

### Implementation notes

- `compinit` runs on the first `precmd` and unhooks itself afterwards.
- `bindkey -e` forces emacs: Zsh selects vi when `$EDITOR`/`$VISUAL` contains `vi` (`nvim`).
- `HISTORY_IGNORE` drops navigation commands with or without arguments.
- `zsh-autosuggestions` loads last (`MANUAL_REBIND`), after fsh and fzf.
- The fzf theme uses `bg:-1` to let the terminal own the background.
- Custom completions live in `$fpath` and self-register with `#compdef`.

### Maintenance

```bash
exec zsh                        # reload
rm ~/.cache/zsh/zcompdump-*     # rebuild completions
time zsh -ic exit               # measure startup
bindkey -lL main                # current keymap
```

---

## Créditos / Credits

Built on top of [Zsh](https://www.zsh.org/), [starship](https://starship.rs/), [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide), [eza](https://github.com/eza-community/eza), [bat](https://github.com/sharkdp/bat), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting), [zellij](https://zellij.dev/) and [yazi](https://yazi-rs.github.io/).
