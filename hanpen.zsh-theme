# prioritize dircolors
local dircolors_theme_path=${ZSH_THEME_HANPEN_DIRCOLORS_THEME_PATH:-$HOME/.dircolors}
if (( ${+commands[dircolors]} )) && [ -f $dircolors_theme_path ]; then
  eval "$(dircolors $dircolors_theme_path)"
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# colorize less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;111m'
if (( ${+commands[src-hilite-lesspipe.sh]} )); then
  export LESSOPEN="| ${commands[src-hilite-lesspipe.sh]} %s"
fi

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg_bold[red]%}(ssh) "
  fi
}

# prompt
setopt extended_glob
local prompt_status='%(?..%K{red} %{$fg[black]%}✘ %? )%k'
local prompt_dir='%K{236} %F{033}%~ %k'
local prompt_host='%{$fg[yellow]%}%m %k'

local prompt_git_info='$(git_prompt_info)$(git_prompt_status)${$(git_remote_status)/[^ ]##} %k'
ZSH_THEME_GIT_PROMPT_PREFIX="%K{235} %{$fg_bold[magenta]%} %{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=''
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✔"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ✘"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%} ✭"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%} ✱"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[blue]%} ➜"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} ✖"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_no_bold[white]%} ☰"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%} ═"
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED=1
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %{$fg_bold[cyan]%}⬆ %{$fg_no_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %{$fg_bold[red]%}⬇ %{$fg_no_bold[red]%}"

local prompt_cmd_exec_time='%{$reset_color%}${_hanpen_zsh_theme_cmd_exec_time}'
local prompt_char='%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})» %f%b'

PROMPT="
${prompt_status}${prompt_host}${prompt_dir}${prompt_git_info}
$(ssh_connection)${prompt_char}"
