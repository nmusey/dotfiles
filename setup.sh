#! /bin/bash

# Automatic setup script for Unix computers.
# By Nick Musey

if [[ "$1" = "ubuntu" ]]; then
    sudo apt update
    sudo apt install -y git zsh stow ripgrep fzf exa bat curl tmux
    sudo apt upgrade -y

    # Docker is fun to install
    sudo apt install ca-certificates gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    sudo rm /etc/apt/keyrings/docker.gpg
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo apt install -y python3-pip 
elif [[ "$1" = "macos" ]]; then
    xcode-select --install
    sudo xcodebuild -license accept

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Install homebrew

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> zsh/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install git zsh stow ripgrep fzf exa bat curl tmux python
    brew install --cask mos docker iterm2
    brew cleanup
elif [[ "$1" = "arch" ]]; then 
    sudo pacman -Syu
    sudo pacman -S git zsh stow ripgrep fzf exa bat curl docker docker-compose tmux
    sudo systemctl start docker.service
    sudo systemctl enable docker.service
    sudo usermog -aG docker $USER
else
    echo "bash setup.sh {os} -- os is one of 'ubuntu', 'macos', 'arch'"
    exit 1
fi

curl -L https://nixos.org/nix/install | sh

# Install nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install 18

# Install neovim
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..
rm -rf neovim

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup terminal envionment
sudo chsh -s $(which zsh)
stow zsh
stow nvim
rm ~/.gitconfig
stow git
stow tmux

# Clean up
cd $HOME
source .zshrc
