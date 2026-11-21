export ASTRO_TELEMETRY_DISABLED=1
export EDITOR=nvim
export VISUAL=nvim
export PAGER='less -R'
export MANPAGER='sh -c "col -bx | bat -l man -p"'

export _ZO_EXCLUDE_DIRS="$HOME/Documentos/*:/run/media/*:/mnt/*"
export _ZO_ECHO=1
export _ZO_RESOLVE_SYMLINKS=1

export FZF_DEFAULT_OPTS="
--color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=selected-bg:#45475a
--color=border:#313244,label:#cdd6f4
"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
