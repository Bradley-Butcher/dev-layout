#!/bin/bash
set -euo pipefail

# Dev layout launcher
# Usage: dev [path]
#
# ┌──────────────┬───────────┐
# │ terminal     │           │
# │ (6 rows)     │  __RIGHT  │
# ├──────────────┤           │
# │              │           │
# │ __LEFT       │           │
# │              │           │
# └──────────────┴───────────┘
#        55%           45%

for cmd in tmux git; do
    command -v "$cmd" >/dev/null || { echo "dev: $cmd not found" >&2; exit 1; }
done

DIR="${1:-$(pwd)}"
SESSION="dev-$(basename "$DIR")"

# Already exists — switch or attach
if tmux has-session -t "$SESSION" 2>/dev/null; then
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$SESSION"
    else
        tmux attach -t "$SESSION"
    fi
    exit 0
fi

if [ -n "$TMUX" ]; then
    tmux new-session -d -s "$SESSION" -c "$DIR"
    tmux split-window -h -t "$SESSION" -p 45 -c "$DIR"
    tmux send-keys -t "$SESSION" '__RIGHT_CMD' Enter
    tmux select-pane -t "$SESSION" -L
    tmux split-window -v -t "$SESSION" -c "$DIR"
    tmux send-keys -t "$SESSION" '__LEFT_CMD' Enter
    tmux select-pane -t "$SESSION" -U
    tmux switch-client -t "$SESSION"
else
    tmux new-session -s "$SESSION" -c "$DIR" \; \
      split-window -h -p 45 -c "$DIR" \; \
      send-keys '__RIGHT_CMD' Enter \; \
      select-pane -L \; \
      split-window -v -c "$DIR" \; \
      send-keys '__LEFT_CMD' Enter \; \
      select-pane -U \; \
      resize-pane -y 6
fi
