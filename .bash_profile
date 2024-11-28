export PATH="/usr/local/Cellar:/Users/trist007/scripts:/usr/local/opt/sphinx-doc/bin:$PATH"
#export PATH="/usr/local/Cellar/python@3.12/3.12.7/bin/:/usr/local/Cellar/:/Users/trist007/scripts:/usr/local/opt/sphinx-doc/bin:$PATH"
export TERM=xterm-256color

alias ls='ls --color'
alias vi='vim'
alias gitlog='git log --pretty=oneline'
alias gitlogd='git log --pretty=format:"%h%x09%an%x09%ad%x09%s"'
alias gitbranch='git branch -av --sort=-committerdate'
alias h='history'
cd ~/dev/trantor

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#PS1='\u@\h:\w$(parse_git_branch) \$ '
PS1='\h:\W \u$(parse_git_branch)\$ '


