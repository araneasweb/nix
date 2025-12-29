#!/usr/bin/env bash
t=${1:?}

cw=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .activeWorkspace.name')

hyprctl clients -j |
  jq -r --arg cw "$cw" '.[] | select(.workspace.name == $cw) | .address' |
  xargs -r -I{} hyprctl dispatch movetoworkspacesilent "$t,address:{}"

hyprctl dispatch workspace "$t"
