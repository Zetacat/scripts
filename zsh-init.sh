#! /bin/zsh

# run with eval

# install oh-my-zsh
CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# change theme to "minimal"
sed 's/^ZSH_THEME=.*$/ZSH_THEME="minimal"/' ~/.zshrc >~/.zshrc.new
if [ $? -eq 0 ]; then
    mv -f ~/.zshrc ~/.zshrc.bak
    mv -f ~/.zshrc.new ~/.zshrc
else
    echo "Pattern substitution failed"
fi

# install zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
# TODO: change the condition check to a more robust approach
if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # TODO: fix the following script on MacOS
    sed -i '/plugins=(/ { :a; /)/! { N; ba; }; s/)/ zsh-autosuggestions&/ }' ~/.zshrc
fi

chsh -s $(which zsh)

case "$0" in
*zsh)
    source ~/.zshrc
    ;;
*)
    zsh
    ;;
esac
