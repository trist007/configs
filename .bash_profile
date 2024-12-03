export PATH="/usr/local/Cellar:/Users/trist007/scripts:/usr/local/opt/sphinx-doc/bin:$PATH"
#export PATH="/usr/local/Cellar/python@3.12/3.12.7/bin/:/usr/local/Cellar/:/Users/trist007/scripts:/usr/local/opt/sphinx-doc/bin:$PATH"
export TERM=xterm-256color

alias ls='ls --color'
alias vi='vim'
alias gitlog="git log --graph --abbrev-commit --decorate=no --date=format:'%Y-%m-%d %H:%I:%S' --format=format:'%C(03)%>|(26)%h%C(reset)  %C(04)%ad%C(reset)  %C(green)%<(16,trunc)%an%C(reset)  %C(bold 1)%d%C(reset) %C(bold 0)%>|(1)%s%C(reset)' --all"
alias gitlogd='git log --pretty=oneline'
alias gitbranch='git branch -av --sort=-committerdate'
alias h='history'
cd ~/dev/darkterminal

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#PS1='\u@\h:\w$(parse_git_branch) \$ '
PS1='\h:\W \u$(parse_git_branch)\$ '


