#!/usr/bin/env sh
set -e

# Install dependencies
echo 'Installing dependencies'
sudo apt update
sudo apt install wget git zsh fzf tmux vim htop bmon iotop

# Set default shell
user=$(whoami)
sudo chsh -s /usr/bin/zsh $user

# Install oh-my-zsh
echo 'Installing oh-my-zsh'
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
sed -ir 's#plugins=\(.*\)#plugins=(debian fzf git tmux zsh-interactive-cd)#g' "$HOME/.zshrc"

# Install powerlevel10k
echo 'Installing powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -ir 's#ZSH_THEME=".*"#ZSH_THEME="powerlevel10k/powerlevel10k"#g' "$HOME/.zshrc"

# Install fonts
echo 'Installing fonts'
mkdir -p "$HOME/.local/share/fonts"
for font in "MesloLGS NF Regular.ttf" "MesloLGS NF Bold.ttf" "MesloLGS NF Italic.ttf" "MesloLGS NF Bold Italic.ttf"; do
    wget -qO "$HOME/.local/share/fonts/$font" "https://github.com/romkatv/powerlevel10k-media/raw/master/$font"
done

# Install vim config
wget -qO "$HOME/.vimrc" 'https://raw.githubusercontent.com/Robin-w151/setup-scripts/main/shell-debian-vimrc.txt'

echo 'Finished.'

