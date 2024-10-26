#!/usr/bin/env bash

# NOTE:  add "directory" to tmux2k.sh file (declare -A plugin_colors)
get_pane_directory() {
    tmux display -p '#{pane_current_path}'
}

truncate_path() {
    local path="$1"
    local limit=30

    if [ ${#path} -le $limit ]; then
        echo "$path"
        return
    fi

    IFS='/' read -r -a path_array <<< "$path"
    local truncated_path=""

    for ((i=0; i<${#path_array[@]}-1; i++)); do
        truncated_path+="${path_array[i]:0:1}/"
    done

    truncated_path+="${path_array[-1]}"
    echo "$truncated_path"
}

main() {
    local path=$(get_pane_directory)
    local cwd="${path/"$HOME"/'~'}"

    truncate_path "$cwd"
}

main

