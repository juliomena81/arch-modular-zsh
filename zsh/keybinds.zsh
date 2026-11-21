# ZLE shortcuts for Spanish keyboard layout (ISO-ES)

# --- Movement through words (Ctrl/Alt + arrows) -----------------.
bindkey '^[[1;5D' backward-word # Ctrl+Left
bindkey '^[[1;5C' forward-word  # Ctrl+Right
bindkey '^[[1;3D' backward-word # Alt+Left
bindkey '^[[1;3C' forward-word  # Alt+Right
bindkey '^[[1;6D' backward-word # Ctrl+Shift+Left
bindkey '^[[1;6C' forward-word  # Ctrl+Shift+Right
bindkey '^[[5D' backward-word   # rxvt/urxvt
bindkey '^[[5C' forward-word

# --- Start / End of line ---------------------------------------
bindkey '^[[H' beginning-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OF' end-of-line
bindkey '^[[4~' end-of-line

# --- Erased -----------------------------------------------------
bindkey '^[[3~' delete-char          # Supr
bindkey '^[[3;5~' backward-kill-word # Ctrl+Supr
bindkey '^[[3;3~' kill-word          # Alt+Supr

zmodload zsh/terminfo 2>/dev/null
if [[ ${terminfo[kbs]} == $'\x7f' || ${terminfo[kbs]} == '^?' ]]; then
    bindkey '^H' backward-kill-word
fi
bindkey '^[[27;5;8~' backward-kill-word # Ctrl+Backspace (kitty/wezterm)
bindkey '^W' backward-kill-word         # Ctrl+W
bindkey '^[^?' backward-kill-word       # Alt+Backspace
bindkey '^U' kill-whole-line            # Ctrl+U Delete entire line
bindkey '^K' kill-line                  # Ctrl+K Delete to end of line
bindkey '^[d' kill-word                 # Alt+D

# --- historical ---------------------------------------------------

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[OA' history-search-backward
bindkey '^[OB' history-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# --- Utilities --------------------------------------------------
bindkey '^L' clear-screen # Ctrl+L Clear screen

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^[e' edit-command-line # Alt+E Edit line in $EDITOR

# Alt+Z opens the Zellij menu; `zle -I` returns control of the terminal to the program
_zj_widget() {
    zle -I
    zj
}
zle -N zj-widget _zj_widget
bindkey '^[z' zj-widget
