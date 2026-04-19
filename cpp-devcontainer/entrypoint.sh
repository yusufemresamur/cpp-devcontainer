#!/usr/bin/env bash

set -e

sudo chown -R $(whoami): /commandhistory
touch /commandhistory/.bash_history

SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history"
echo "$SNIPPET" >> "$HOME/.bashrc"