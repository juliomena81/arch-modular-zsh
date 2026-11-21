typeset -U path fpath
path+=("$HOME/.local/bin")

if [[ -z $_ZSHRC_LOADED ]]; then
    _zcomp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
    mkdir -p "$_zcomp_cache/zcompcache"

    fpath=("$HOME/.config/zsh/zsh_completion" $fpath)

    autoload -Uz compinit add-zsh-hook

    _compinit_lazy() {
        compinit -C -d "$_zcomp_cache/zcompdump-${ZSH_VERSION}"

        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' accept-exact '*(N)'
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' rehash true
        zstyle ':completion:*' cache-path "$_zcomp_cache/zcompcache"
        zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
        _comp_options+=(globdots)

        add-zsh-hook -d precmd _compinit_lazy
        unfunction _compinit_lazy
        unset _zcomp_cache
    }
    add-zsh-hook precmd _compinit_lazy
fi

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE EXTENDED_HISTORY \
    HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS \
    HIST_REDUCE_BLANKS HIST_VERIFY

HISTORY_IGNORE='(ls|la|lh|ll|cd|pwd|exit|clear|z|zj)( *|)'

setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS NO_BEEP HIST_FCNTL_LOCK \
    AUTO_MENU COMPLETE_IN_WORD ALWAYS_TO_END \
    extendedglob nocaseglob rcexpandparam interactive_comments

[[ -t 0 ]] && unsetopt flow_control

# Force emacs
bindkey -e

# Personal modules (Alias, Functions and Shortcuts)
for file in ~/.config/zsh/{aliases,functions,keybinds}.zsh; do
    [[ -r "$file" ]] && source "$file"
done
unset file

# Tools and Plugins Initialization
if [[ -z $_ZSHRC_LOADED ]]; then
    _ZSHRC_LOADED=1
    eval "$(starship init zsh)"
    eval "$(fzf --zsh)"
    eval "$(zoxide init zsh --cmd cd)"

    [[ -f /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh ]] &&
        source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
    [[ -f /usr/share/zsh/plugins/zpy/zpy.plugin.zsh ]] &&
        source /usr/share/zsh/plugins/zpy/zpy.plugin.zsh
    [[ -f /usr/share/doc/find-the-command/ftc.zsh ]] &&
        source /usr/share/doc/find-the-command/ftc.zsh askfirst
    [[ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] &&
        source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

    if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
        ZSH_AUTOSUGGEST_USE_ASYNC=1
        ZSH_AUTOSUGGEST_MANUAL_REBIND=1
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7f849c'
        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        # Limpiar la sugerencia tras usar los widgets de fzf
        ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(fzf-completion fzf-history-widget)
        _zsh_autosuggest_bind_widgets
    fi
fi
