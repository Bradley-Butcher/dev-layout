---
description: Set up a tmux dev layout script
---

# Dev Layout Setup

You are helping the user create a personalised tmux dev layout script. The script template is at `templates/dev.sh` relative to this plugin's directory. Read it first.

**Important:** Use the `AskUserQuestion` tool for every question in this setup. Do NOT output questions as plain text — always use the tool so the user gets a proper interactive prompt. Only proceed to the next step after receiving the user's answer.

The layout looks like this:

```
┌──────────────┬───────────┐
│ terminal     │           │
│ (6 rows)     │   right   │
├──────────────┤   pane    │
│              │           │
│ bottom-left  │           │
│              │           │
└──────────────┴───────────┘
       55%           45%
```

## Step 1: Ask about the right pane

Ask the user which tool they want in the right pane. Present these three options clearly:

1. **lazygit** — a terminal UI for git. Install: `brew install lazygit` (https://github.com/jesseduffield/lazygit)
2. **terminal** — a plain shell (no command sent)
3. **changes** — a TUI for staging and reviewing git changes (https://github.com/Bradley-Butcher/Changes). Install options:
   - **Homebrew (macOS):** `brew install Bradley-Butcher/tap/changes`
   - **macOS (Apple Silicon):** `curl -sSL https://github.com/Bradley-Butcher/Changes/releases/latest/download/changes-aarch64-apple-darwin.tar.gz | tar xz && sudo mv changes /usr/local/bin/`
   - **macOS (Intel):** `curl -sSL https://github.com/Bradley-Butcher/Changes/releases/latest/download/changes-x86_64-apple-darwin.tar.gz | tar xz && sudo mv changes /usr/local/bin/`
   - **Linux (x86_64):** `curl -sSL https://github.com/Bradley-Butcher/Changes/releases/latest/download/changes-x86_64-unknown-linux-gnu.tar.gz | tar xz && sudo mv changes /usr/local/bin/`

If the user picks a tool that isn't installed, let them know how to install it before proceeding.

Wait for their answer before proceeding.

## Step 2: Ask about the bottom-left pane

Ask the user what they want in the bottom-left pane. Suggest options like:

1. **claude** — Claude Code CLI
2. **terminal** — a plain shell (no command sent)
3. **Custom command** — any command they want to run

Wait for their answer before proceeding.

## Step 3: Ask what to call the command

Ask the user what they'd like the command to be called. Suggest `dev` as the default but they might prefer something else (e.g. `workspace`, `tmx`, `layout`).

## Step 4: Ask where to install

Ask where they'd like the script installed. Suggest `~/bin/<name>` or `~/.local/bin/<name>` (using their chosen command name) and check that the directory exists and is on their PATH. If it doesn't exist, offer to create it.

## Step 5: Generate and install the script

Read the template from `templates/dev.sh` and replace the placeholders:

- `__RIGHT` and `__RIGHT_CMD` — with the chosen right pane tool name and command
- `__LEFT` and `__LEFT_CMD` — with the chosen bottom-left tool name and command
- If the user chose "terminal" for a pane, remove the corresponding `send-keys` line entirely (don't send any command)

Write the customised script to their chosen path, make it executable with `chmod +x`, and confirm it's ready to use.

Show them how to run it: `dev` or `dev /path/to/project`.
