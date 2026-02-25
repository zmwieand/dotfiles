#!/bin/bash

tmux send-keys "vim -c NERDTree" C-m
tmux split-window -v
tmux send-keys "tmux resize-pane -y 25% && clear" C-m
