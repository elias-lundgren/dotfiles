# Setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_PREFIX=$(/opt/homebrew/bin/brew --prefix)

eval "$(fnm env --use-on-cd --resolve-engines --shell bash 2> /dev/null)"

export CLICOLOR=1
export EDITOR="nvim"
export BUN_INSTALL="$HOME/.bun"
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export DOTNET_ROOT=/usr/local/share/dotnet
export GH_PAGER=""

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ] && source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
  [ -f "$COMPLETION" ] && source "${COMPLETION}"
done

export GOPATH=$HOME/go
export GOPRIVATE=gitlab.com/junitechnology/*
export GO111MODULE=on

export PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/util-linux/bin:$PATH"
export PATH="/opt/homebrew/opt/util-linux/sbin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$PATH:$GOPATH/bin
export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"

# Return if shell is non-interactive
[[ $- == *i* ]] || return

# Setup atuin
[ -f $HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh ] && source "$HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh"
eval "$(atuin init bash --disable-up-arrow)"

bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind 'TAB: menu-complete'
bind 'set colored-completion-prefix on'
bind 'set colored-stats on'

shopt -s cdspell
shopt -s nocaseglob
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s autocd
shopt -s globstar

alias vi="nvim"

function red() {
  local t=$1
  printf "\x01\e[31m\x02%s\x01\e[0m\x02" "$t"
}

function cyan() {
  local t=$1
  printf "\x01\e[36m\x02%s\x01\e[0m\x02" "$t"
}

function yellow() {
  local t=$1
  printf "\x01\e[33m\x02%s\x01\e[0m\x02" "$t"
}

function ps1_branch() {
  local branch=$(git branch --show-current 2>/dev/null)
  if [[ -z "$branch" ]]; then
    printf ""
  else
    printf " (%s)" "$branch"
  fi
}

function ps1_prompt() {
  local exit_code=$1
  if [[ "$exit_code" == "0" ]]; then
    printf '$'
  else
    red '$'
  fi
}

function ps1_folder() {
  cyan "$(basename "$PWD")"
}

function ps1_full_prompt() {
  local exit_code=$?
  tr -s ' ' <<< "$(ps1_folder) $(ps1_branch) $(ps1_prompt "$exit_code") "
}

PS1='$(ps1_full_prompt)'
