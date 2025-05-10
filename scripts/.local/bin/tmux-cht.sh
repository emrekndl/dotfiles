#!/usr/bin/env bash

LANGUAGES=(
    python javascript go rust java c cpp csharp ruby perl php swift kotlin
    typescript scala elixir haskell lua r cshell powershell bash
)

UTILS=(
    grep sed awk find xargs tar ssh git git-worktree git-status
    git-commit git-rebase docker docker-compose stow chmod chown
    make systemctl curl wget rsync vim tmux make cmake protobuf
    jq ffmpeg convert uv pip npm yarn cp tr tldr ls rg ps mv kill
    lsof less head tail rm rename cat ssh
)

CHOICES=("${LANGUAGES[@]}" "${UTILS[@]}")

# selected=`cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf`
# selected=$(printf '%s\n' "${CHOICES[@]}" | sort | uniq | fzf --prompt="Choose language or util: ")
selected=$(printf '%s\n' "${CHOICES[@]}" | fzf --prompt="Choose language or util: ")

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query
# :learn

# if grep -qs "$selected" ~/.tmux-cht-languages; then
if printf '%s\n' "${LANGUAGES[@]}" | grep -qx "$selected"; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
