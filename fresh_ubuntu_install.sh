apt install -y git vim

# Make symlinks
ln -s .bashrc ~/.bashrc
ln -s .bash_aliases ~/.bash_aliases
ln -s .inputrc ~/.inputrc
ln -s .vimrc ~/.vimrc

# Git specifics
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git config --global core.editor "vim"
git config --global user.name "Fredrik Ingebrigtsen"
git config --global user.email "fredrikpei@gmail.com"

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
