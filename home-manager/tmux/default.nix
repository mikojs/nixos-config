{
  name,
  ...
}:
{
  pkgs,
  miko,
  isMac,
  ...
}:
let
  getConfig = miko.getConfig [
    ./tm.nix
  ] { inherit pkgs miko; };
in
{
  home.file = miko.getDocs [
    {
      filePath = "tmux";
      docs = ''
        # Tmux

        Tmux is a terminal multiplexer.

        [Repository](https://github.com/tmux/tmux)

        # Alias
        ${getConfig [ "fish-alias" ] ""}
      '';
    }
  ];

  programs = {
    tmux = {
      enable = true;

      plugins = with pkgs.tmuxPlugins; [
        nord
      ];

      # FIXME: default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
      extraConfig =
        if !isMac then "" else "set-option -g default-command /etc/profiles/per-user/${name}/bin/fish";
    };

    fish.interactiveShellInit = ''
      if not set -q LANG
        set -Ux LANG en_US.UTF-8
      end

      ${getConfig [ "programs" "fish" "interactiveShellInit" ] ""}
    '';
  };
}
