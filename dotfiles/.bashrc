# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc


# Couleurs
BLEU_FLUO='\[\e[1;96m\]'
MAGENTA_FLUO='\[\e[1;35m\]'
ROSE_PALE='\[\e[1;38;5;213m\]'
RESET='\[\e[0m\]'

PS1="${BLEU_FLUO}\u${RESET}@${MAGENTA_FLUO}\h${RESET} ${RESET} ${ROSE_PALE}\w${RESET}> "

# ls custom (uniquement dossiers et liens symboliques)

alias ls='ls --color=auto'
export LS_COLORS="di=38;5;226"
