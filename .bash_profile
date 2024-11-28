export PATH="/usr/local/Cellar:/Users/trist007/scripts:/usr/local/opt/sphinx-doc/bin:$PATH"
#export PATH="/usr/local/Cellar/python@3.12/3.12.7/bin/:/usr/local/Cellar/:/Users/trist007/scripts:/usr/local/opt/sphinx-doc/bin:$PATH"
export TERM=xterm-256color

alias ls='ls --color'
alias vi='vim'
alias gitlog='git log --pretty=oneline'
alias gitlogd='https://stackoverflow.com/questions/1441010/the-shortest-possible-output-from-git-log-containing-author-and-date'
alias h='history'
cd dev/trantor

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#PS1='\u@\h:\w$(parse_git_branch) \$ '
PS1='\h:\W \u$(parse_git_branch)\$ '


