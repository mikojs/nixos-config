{
  name,
  ...
}:
{
  pkgs,
  isMac,
  ...
}:
{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      nord
    ];

    # FIXME: default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
    extraConfig =
      if !isMac then "" else "set-option -g default-command /etc/profiles/per-user/${name}/bin/fish";
  };
}
