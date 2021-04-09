# Make symlinks
rm ~/.bashrc
rm ~/.bash_aliases
rm ~/.inputrc
rm ~/.vimrc
ln -sr .bashrc ~/.bashrc
ln -sr .bash_aliases ~/.bash_aliases
ln -sr .inputrc ~/.inputrc
ln -sr .vimrc ~/.vimrc


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

# Ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
rm ripgrep_11.0.2_amd64.deb

# fd
wget https://github.com/sharkdp/fd/releases/download/v8.0.0/fd-musl_8.0.0_amd64.deb
sudo dpkg -i fd-musl_8.0.0_amd64.deb
rm fd-musl_8.0.0_amd64.deb

# bash-git-prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
