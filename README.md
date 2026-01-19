For Windows install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/vimfiles/bundle/Vundle.vim
and update rtp and vundle begin with $HOME in _vimrc
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle/')


don't forget to go into .vim/bundle/YouCompleteMe
and run
python3 install.py

make sure vim is configured with python38 support

./configure --with-features=huge --enable-python3interp
