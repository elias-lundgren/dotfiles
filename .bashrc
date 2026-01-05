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

set -o vi

# Setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_PREFIX=$(/opt/homebrew/bin/brew --prefix)
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=/usr/local/share/dotnet

# Setup atuin
# [ -f $HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh ] && source "$HOMEBREW_PREFIX/etc/profile.d/bash-preexec.sh"
eval "$(atuin init bash --disable-up-arrow)"

eval "$(fnm env)"

export EDITOR="nvim"
export GH_PAGER=""
export BUN_INSTALL="$HOME/.bun"
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export CLFAGS="-Wall -Wextra -Wdouble-promotion -Wshadow -Wvla -fsanitize=address -fsanitize=undefined -pedantic -std=c11"
export GOEXPERIMENT=jsonv2

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ] && source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
  [ -f "$COMPLETION" ] && source "${COMPLETION}"
done
[ -f "$HOME/.local/share/bash-completion/completions/deno.bash" ] && source "$HOME/.local/share/bash-completion/completions/deno.bash"
[ -f "$HOME/.deno/env" ] && source "$HOME/.deno/env"

PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/util-linux/bin:$PATH"
PATH="/opt/homebrew/opt/util-linux/sbin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$BUN_INSTALL/bin:$PATH"
MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"

alias vi="nvim"

function red() {
  local t=$1
  printf "\x01\e[31m\x02%s\x01\e[0m\x02" "$t"
}

function cyan() {
  local t=$1
  printf "\x01\e[36m\x02%s\x01\e[0m\x02" "$t"
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
