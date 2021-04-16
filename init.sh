#!/bin/sh

echo "Installing Homebrew"
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
echo "Install Homebrew Packages"
brew tap homebrew/bundle
brew bundle

echo "Install XCode CLI Tool"
xcode-select --install

echo "Installing Oh My Zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sed -io 's/^plugins=.*/plugins=(autojump git brew common-aliases copydir copyfile encode64 node osx sublime tmux xcode pod docker git-extras git-prompt)/' ~/.zshrc
sed -io 's/^ZSH_THEME.*/ZSH_THEME="dpoggi"/' ~/.zshrc
ln -s $PWD/root-configs/.aliases ~/.aliases
ln -s $PWD/root-configs/.my-zshrc ~/.my-zshrc
echo -e "ZSH_DISABLE_COMPFIX=true\n$(cat ~/.zshrc)" > ~/.zshrc
echo 'source ~/.my-zshrc' >> ~/.zshrc

echo "Installing Tmux Settings"
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
cp ~/.tmux/.tmux.conf.local ~/

echo "Configrating Git"
git config --global merge.tool diffmerge
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global core.editor $(which nano)
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
git config --global alias.tree "log --graph --full-history --all --color --date=short --pretty=format:'%Cred%x09%h %Creset%ad%Cblue%d %Creset %s %C(bold)(%an)%Creset'"

echo "Done. Reload Shell"
exec ${SHELL} -l