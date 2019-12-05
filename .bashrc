set -o vi
function cd() {
  builtin cd "$@" && ls
}
alias ls="ls -hN --color=auto --group-directories-first"
alias vim="nvim"
alias cp="cp -i"
alias df="df -h"
alias free="free -m"
alias mkdir="mkdir -pv"
