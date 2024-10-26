#!/usr/bin/env bash

# NOTE:  add "tmux_session" to tmux2k.sh file (declare -A plugin_colors)
get_session_name() {
    tmux display -p '#S'
}

truncate_session_name() {
    local session_name="$1"
    local limit=30

    if [ ${#session_name} -le $limit ]; then
        echo "$session_name"
        return
    fi

    echo "${session_name:0:limit}..."
}

main() {
    local session_name=$(get_session_name)

    truncate_session_name "$session_name"
}

main

