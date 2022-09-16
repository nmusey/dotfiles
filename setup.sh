#! /bin/bash

# Automatic setup script for Unix computers.
# By Nick Musey

usage="bash setup.sh {os} -- os is one of 'ubuntu', 'macos'"

allOS=("ubuntu", "macos")

# Install programs on Ubuntu
if [[ "$1" = "ubuntu" ]]; then
    sudo apt update
    sudo apt install -y git zsh neovim stow ripgrep fzf exa bat curl
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
    brew install git zsh neovim stow ripgrep fzf exa bat curl
    brew install python
    brew install --cask mos docker iterm2
    brew cleanup
else
    echo $usage
    exit 1
fi

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Setup termianal envionment
sudo chsh -s $(which zsh)
stow zsh
stow nvim

# Clean up
cd $HOME
echo
echo
echo
echo "Installation is complete."
