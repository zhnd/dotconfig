#pip3
export PATH=$HOME/Library/Python/3.8/bin:$PATH

# kitty
alias d="kitty +kitten diff"

#lazygit
export PATH=$HOME/develop/tools/lazygit:$PATH

# lunarvim
export PATH=$HOME/.local/bin:$PATH

# neovim
export PATH=$HOME/develop/tools/nvim-osx64/bin:$PATH

# autojump
[[ -s /Users/zhudi/.autojump/etc/profile.d/autojump.sh ]] && source /Users/zhudi/.autojump/etc/profile.d/autojump.sh

	autoload -U compinit && compinit -u

# proxy
# export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
# alias proxy='export all_proxy=socks5://127.0.0.1:7890'
# alias unproxy='unset all_proxy'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

ZSH_THEME="spaceship"

plugins=(
	git
	zsh-autosuggestions
	fast-syntax-highlighting
)


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5c6d74,bg=36353e"

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
