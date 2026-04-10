{
  lib,
  ...
}:
{
  programs.tmux.extraConfig = lib.mkAfter ''
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'
    unbind ]
    bind ] run-shell 'tmux set-buffer -- "$(pbpaste)" \; paste-buffer -d'
  '';
}
