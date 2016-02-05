# HTTP Proxy Configurations
export NO_PROXY=localhost,127.0.0.1
export ALL_PROXY=http://127.0.0.1:8123
export HTTP_PROXY=http://127.0.0.1:8123
export HTTPS_PROXY=http://127.0.0.1:8123

# Homebrew Configurations
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
source $(brew --repository)/Library/Contributions/brew_bash_completion.sh

# Homebrew Completion
[ -r "$(brew --prefix)/etc/bash_completion" ] && source $(brew --prefix)/etc/bash_completion

# rbenv Initialization
eval "$(rbenv init -)"

# GOROOT based install location
PATH=$PATH:/usr/local/opt/go/libexec/bin

# Add Erlang man pages
MANPATH=$MANPATH:/usr/local/opt/erlang/lib/erlang/man

export PATH
export MANPATH

# NVM Initialization
export NVM_DIR="/Users/nightire/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -r "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Alias Configurations
alias la="ls -AGhl"

[ "$(type -t hub)" = "file" ] && alias git="hub"

if [ "$(type -t nvim)" = "file" ]; then
  alias xvi="vi"
  alias xvim="vim"
  alias vi="nvim"
  alias vim="nvim"
fi

# I'm not happy with this solution yet, don't use this!
function parse_git_branch() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ ! "${BRANCH}" == "" ]; then
    STAT=`parse_git_dirty`
    echo "[${BRANCH}${STAT}]"
  else
    echo ""
  fi
}

function parse_git_dirty {
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}

export PS1="\[\e[34m\][\[\e[m\]\[\e[34m\]\w\[\e[m\]\[\e[34m\]]\[\e[m\]\[\e[36m\]\`parse_git_branch\`\[\e[m\] \[\e[35m\]\\$\[\e[m\] "
