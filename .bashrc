# Sensible Bash - An attempt at saner Bash defaults
# Maintainer: mrzool <http://mrzool.cc>
# Repository: https://github.com/mrzool/bash-sensible
# Version: 0.1

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
# shopt -s autocd
# Correct spelling errors during tab-completion
# shopt -s dirspell
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH=".:~:~/Code"

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# Examples:
# export dotfiles="$HOME/dotfiles"
# export projects="$HOME/projects"
# export documents="$HOME/Documents"
# export dropbox="$HOME/Dropbox"

# HTTP Proxy Configurations
# export NO_PROXY=localhost,127.0.0.1,192.168.99.*
# export ALL_PROXY=http://127.0.0.1:8123
# export HTTP_PROXY=http://127.0.0.1:8123
# export HTTPS_PROXY=http://127.0.0.1:8123

# Homebrew Configurations
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
export PATH="/usr/local/sbin:$PATH"

# Homebrew Completion
[ -r "$(brew --prefix)/etc/bash_completion" ] && source $(brew --prefix)/etc/bash_completion

# rbenv Initialization
eval "$(rbenv init -)"

# added by travis gem
[ -f /Users/nightire/.travis/travis.sh ] && source /Users/nightire/.travis/travis.sh

# GOROOT based install location
export PATH="$PATH:/usr/local/opt/go/libexec/bin"

# Add Erlang man pages
export MANPATH=$MANPATH:/usr/local/opt/erlang/lib/erlang/man

# NVM Initialization
export NVM_DIR="/Users/nightire/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -r "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

export PATH="/Users/nightire/.config/yarn/global/node_modules/.bin:$PATH"

# Fix apm install error, see: https://github.com/atom/apm/issues/322#issuecomment-96430856
export ATOM_NODE_URL=http://gh-contractor-zcbenz.s3.amazonaws.com/atom-shell/dist

# Use taobao mirrors for downloading phantomjs
export PHANTOMJS_CDNURL=https://npm.taobao.org/mirrors/phantomjs

# Use taobao mirros for electron
export ELECTRON_MIRROR=https://npm.taobao.org/mirrors/electron

# z Initialization
[ -f `brew --prefix`/etc/profile.d/z.sh ] && source `brew --prefix`/etc/profile.d/z.sh

# GPG Agent Initialization
if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

# Use GnuUtils
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Alias Configurations
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd..='cd ..'
alias hc="history -c"
alias la="ls -aGhlp"

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
