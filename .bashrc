# HTTP Proxy Configurations
export http_proxy=localhost:8123
export ALL_PROXY=$http_proxy

# Homebrew Configurations
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
source $(brew --repository)/Library/Contributions/brew_bash_completion.sh

# Homebrew Completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  source `brew --prefix`/etc/bash_completion
fi

# rbenv Initialization
eval "$(rbenv init -)"

#GOROOT based install location
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# Alias Configurations
alias la="ls -AGhl"

if [ "$(type -t hub)" = "file" ]; then
  alias git="hub"
fi

if [ "$(type -t nvim)" = "file" ]; then
  alias xvi="vi"
  alias xvim="vim"
  alias vi="nvim"
  alias vim="nvim"
fi
