# ~/.zshrc file for zsh interactive shells.
  # see /usr/share/doc/zsh/examples/zshrc for examples

export EDITOR=vim

export ZSH="/home/tim/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

export TERM=xterm-256color

export PATH=~/.local/bin:"$PATH"

if [ -d "/snap/bin" ] ; then
  export PATH="/snap/bin:$PATH"
fi

# Node version manager
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python version manager
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH=$(pyenv root)"/shims:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Ruby version manager
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
zsh-completions
zsh-autosuggestions
zsh-syntax-highlighting
themes
common-aliases
rails
git
)

autoload -U compinit && compinit

setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
  setopt nonomatch           # hide error message if there is no match for the pattern
    setopt notify              # report the status of background jobs immediately
    setopt numericglobsort     # sort filenames numerically when it makes sense
    setopt promptsubst         # enable command substitution in prompt

    WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
# bindkey -e                                        # emacs key bindings
# bindkey ' ' magic-space                           # do history expansion on space
  # bindkey '^[[3;5~' kill-word                       # ctrl + Supr
  # bindkey '^[[3~' delete-char                       # delete
  # bindkey '^[[1;5C' forward-word                    # ctrl + ->
  # bindkey '^[[1;5D' backward-word                   # ctrl + <-
  # bindkey '^[[5~' beginning-of-buffer-or-history    # page up
  # bindkey '^[[6~' end-of-buffer-or-history          # page down
  #
  # bindkey '^[[H' beginning-of-line                  # home
  # bindkey "\e[1~" beginning-of-line                 # home
  # bindkey "\e[H" beginning-of-line                  # home
  # bindkey "\e1~" beginning-of-line                  # home
  # bindkey "\eH" beginning-of-line                   #home
  # bindkey "\e[0H" beginning-of-line                 # home
  #
  # bindkey '^[[F' end-of-line                        # end
  # bindkey '^[[Z' undo                               # shift + tab undo last action
  #

# bindkey <A-h> <Up>

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"
alias volup="amixer -D pulse set Master 5%+"
alias voldown="amixer -D pulse set Master 5%-"

alias confadb='mongosh "mongodb+srv://confa:confapwd@cluster0.inxhl.mongodb.net/confa?retryWrites=true&w=majority"'
alias gemapi="~/dev/gemnotes/gemnotes-api"
alias gemweb="~/dev/gemnotes/gemnotes-web"

#npm aliases
alias nrs="npm run serve"
alias nd="npm run dev"
alias lac='fc -e : "-${1:-1}" -1'
alias wvlc="export DISPLAY=:0 && vlc --http-host 192.168.0.86 --http-port 5566"
alias mux=tmuxinator

# make less more friendly for non-text input files, see lesspipe(1)
  #[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

ZSH_THEME="bureau"

source $ZSH/oh-my-zsh.sh

function findandkill() {
  if [ -z $1 ]; then
    echo "needle is req. usage: findandkill needle"
    return
  fi
  needle=$1
  echo "needle: $needle"
  for pid in $(ps aux | grep -v "grep" | grep "$needle" | awk '{print$2}')
  do
    echo "kill: $pid"; ps --no-headers -p $pid;
    echo "----";
    kill -9 $pid;
  done
}


fg() {
  if [[ $# -eq 1 && $1 = - ]]; then
    builtin fg %-
  else
    builtin fg %"$@"
  fi
}
curva() {
  curl -o /dev/null \
    -H 'Cache-Control: no-cache' \
    -s \
    -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" \
    $1
  }

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

freeme() {
  su -c echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a \
    && printf '\n%s\n' 'Ram-cache and Swap Cleared' root
}


export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

git-semantic() {
echo <<EOF
Format of the commit message:
  <type>: <subject>

  <body>

  <footer>


P.S.
  <type> values:
    feat (new feature for the user, not a new feature for build script)
    fix (bug fix for the user, not a fix to a build script)
    docs (changes to the documentation)
    style (formatting, missing semi colons, etc; no production code change)
    refactor (refactoring production code, eg. renaming a variable)
    test (adding missing tests, refactoring tests; no production code change)
    chore (updating grunt tasks etc; no production code change)

  <subject>:
    The first line cannot be longer than 70 characters,
    the second line is always blank and other lines should be wrapped at 80 characters.

  <body> | <footer> is optional

  Example commit message:
    fix: ensure Range headers adhere more closely to RFC 2616

    Add one new dependency, use 'range-parser' (Express dependency) to compute
    range. It is more well-tested in the wild.

    Fixes #2310

  The reasons for these conventions:
    automatic generating of the changelog
    simple navigation through git history (e.g. ignoring style changes)
EOF
}
