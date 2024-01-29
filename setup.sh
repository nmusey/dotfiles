#! /bin/bash

# Automatic setup script for Unix computers.
# By Nick Musey

if [[ "$1" = "ubuntu" ]]; then
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y git zsh stow ripgrep fzf curl tmux i3 rofi

    # Install Docker
    sudo apt install ca-certificates gnupg curl
    sudo mkdir -p /etc/apt/keyrings
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    # Install neovim prereqs
    sudo apt install -y ninja-build gettext cmake unzip curl python3-pip

    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat

    cd ~/dotfiles
    git clone https://github.com/adi1090x/rofi.git
elif [[ "$1" = "macos" ]]; then
    xcode-select --install
    sudo xcodebuild -license accept

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Install homebrew

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> zsh/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install git zsh stow ripgrep fzf exa bat curl tmux python fd xh xclip ranger
    brew install --cask mos docker iterm2
    brew cleanup
else
    echo "bash setup.sh {os} -- os is one of 'ubuntu', 'macos'"
    exit 1
fi

# Install nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install 18

# Install neovim
git clone https://github.com/neovim/neovim.git
cd neovim
rm -rf build/  # clear the CMake cache
make CMAKE_BUILD_TYPE=Release 
sudo make install
cd ..
rm -rf neovim

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup terminal envionment
chsh -s $(which zsh)
stow zsh
stow nvim
rm ~/.gitconfig
stow git
stow tmux
stow i3

# Clean up
cd $HOME
source .zshrc
