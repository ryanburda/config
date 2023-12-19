#!/bin/bash

tmux start-server\; set-option exit-empty off\; wait-for kill-server\; kill-server
