# Listing and navigation
alias ls='eza --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first --git'
alias ll='eza -l --icons --group-directories-first --git'
alias lh='eza -lh --icons --group-directories-first'
alias tree='eza --tree --icons --level=2'
alias lt='eza --tree --icons --level=3'
alias ftree='fzf --preview "eza --tree --color=always {}" --preview-window=right:50%'
alias ...='cd ../..'
alias ....='cd ../../..'

# Reading and searching
alias grep='grep --color=auto'
alias cat='bat --style=header,grid,numbers'
alias catp='bat -p'

# System and utilities
alias top='btop'
alias df='duf'
alias du='du -h'
alias cp='cp -i --reflink=auto'
alias cpr='rsync -ah --info-progress2'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias help='tldr'
alias ffmpeg='ffmpeg -hide_banner'
alias v='nvim'
alias free='free -h'
alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias ports='ss -tulpn'
alias myip='curl -s https://ifconfig.me'
alias jctl='journalctl -p 3 -xb'
alias jfollow='journalctl -f'
alias scf='systemctl --failed'
alias reload='exec zsh'

# Git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gb='git branch'
alias gp='git push'
alias gpl='git pull --rebase'

# Pacman
alias pacs='pacman -Ss'
alias pacq='pacman -Qi'
alias paci='sudo pacman -S --needed'
alias pacr='sudo pacman -Rns'
alias pacu='sudo pacman -Syu'
alias orphans='pacman -Qdt'

# Zellij
alias zd='zj dev'       # layout dev (nvim + shell)
alias zy='zj yazi-nvim' # layout yazi + nvim
alias zs='zellij'       # sesión limpia
alias zl='zj -l'        # listar layouts y sesiones
alias zk='zellij kill-session'
alias zka='zellij kill-all-sessions'

# Trash-cli
alias rm="trash-put -fRi"
alias trash-empty="empty"
alias trash-list="list"
alias trash-restore="restore"
