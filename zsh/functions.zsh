cpfile() {
    (($#)) || {
        print -u2 'uso: cpfile <archivo>'
        return 1
    }
    if ((! $+commands[wl - copy])); then
        print -u2 'wl-copy no disponible (requiere Wayland)'
        return 1
    fi
    bat -p -- "$1" | wl-copy
    print "'$1' copiado al portapapeles"
}

chtsh() {
    (($#)) || {
        print -u2 'uso: chtsh <tema>'
        return 1
    }
    curl -fsS --max-time 5 "https://cheat.sh/$*" | bat --style=plain ||
        print -u2 'Sin conexión a cheat.sh'
}

y() {
    if (($#)); then
        command yazi "$@"
    else
        command yazi
    fi
}

x() {
    local f
    for f in "$@"; do
        [[ -f $f ]] || {
            print -u2 "no existe: $f"
            continue
        }
        local d=${f%.*}
        [[ -d $d ]] || command mkdir -p -- "$d"
        bsdtar -xf "$f" -C "$d" && print "→ $d/"
    done
}

zj() {
    (($+commands[zellij])) || {
        print -u2 'zellij no está instalado'
        return 1
    }

    local line name choice action target laydir
    local -a rows f layouts

    laydir="${ZELLIJ_LAYOUT_DIR:-$HOME/.config/zellij/layouts}"
    layouts=(${laydir}/*.kdl(N:t:r))
    [[ -d /usr/share/zellij/layouts ]] && layouts+=(${/usr/share/zellij/layouts}/*.kdl(N:t:r))
    layouts=(${(u)layouts})

    # List of live sessions (names only)
    local -a sesiones
    sesiones=(${(f)"$(zellij list-sessions --short 2>/dev/null)"})

    if [[ $1 == (-l|--list) ]]; then
        print -r -- 'Layouts:'
        print -rl -- ${layouts/#/  }
        print -r -- 'Sesiones:'
        print -rl -- ${sesiones/#/  }
        ((${#layouts})) || print -r -- '  (ninguno)'
        ((${#sesiones})) || print -r -- '  (ninguna)'
        return 0
    fi

    if (($#)); then
        target=$1
        if ((${layouts[(Ie)$target]})) || [[ -f $target ]]; then
            if ((${sesiones[(Ie)$target]})); then
                zellij attach "$target"
            else
                zellij --layout "$target"
            fi
        elif ((${sesiones[(Ie)$target]})); then
            zellij attach "$target"
        else
            print -u2 "zj: no existe el layout ni la sesión '$target'"
            print -u2 "layouts disponibles: ${(j:, :)layouts}"
            return 1
        fi
        return
    fi

    # --- zj: menu -----------------------------------------------------
    # list-sessions format (0.46): "name with spaces [Created 2m ago] (current)"
    for line in "${(@f)$(zellij list-sessions --no-formatting 2>/dev/null)}"; do
        [[ -n $line ]] || continue
        name=${line%% \[*}
        [[ $name == $line ]] && name=${line%% \(*}
        [[ -n $name ]] || continue
        if [[ $line == *EXITED* ]]; then
            rows+=("attach"$'\t'"$name"$'\t'"$name"$' (exited)')
        else
            rows+=("attach"$'\t'"$name"$'\t'"$name")
        fi
    done

    for name in $layouts; do
        rows+=("new"$'\t'"$name"$'\t'"Layout: $name")
    done
    rows+=("new"$'\t'""$'\t'"Sesión limpia")
    rows+=("shell"$'\t'""$'\t'"Salir sin hacer nada")

    choice=$(print -rl -- "${rows[@]}" | fzf --delimiter='\t' --with-nth='3..' \
        --height=~60% --reverse --header='Zellij  (zj -l para listar)' --prompt='> ') || return 0
    f=("${(@ps:\t:)choice}")
    action=$f[1]
    target=$f[2]

    case $action in
    attach)
        zellij attach "$target"
        ;;
    new)
        if [[ -n $target ]]; then
            if ((${sesiones[(Ie)$target]})); then
                zellij attach "$target"
            else
                zellij --layout "$target"
            fi
        else
            zellij
        fi
        ;;
    shell) return 0 ;;
    esac
}

mkcd() {
    (($#)) || {
        print -u2 'uso: mkcd <directorio>'
        return 1
    }
    command mkdir -p -- "$1" && cd "$1"
}

fe() {
    local f
    f=$(fd -t f | fzf --height=~60% --reverse) || return
    ${EDITOR:-nvim} "$f"
}

fkill() {
    local pid
    pid=$(ps -eo pid,comm --no-headers | fzf --height=~60% --reverse | awk '{print $1}') || return
    [[ -n $pid ]] && kill -"${1:-TERM}" "$pid"
}

cs() {
    local f
    f=$(cd ~/.config/cheatsheets && fd -e md | fzf --height=~60% --reverse) || return
    glow -p ~/.config/cheatsheets/"$f"
}
