{
  pkgs,
  miko,
  ...
}:
with pkgs;
{
  home = {
    file = miko.getDocs [
      {
        filePath = "initialize";
        docs = ''
          # [miko] Initialize

          Initialize the system with custom settings.

          [Code](https://github.com/mikojs/nixos-config/tree/main/overlays/custom/initialize)

          ## Support packages

          - `tide`: Runs `tide configure` to set up the fish prompt.
          - `gh`: Runs `gh auth login` to authenticate the GitHub CLI.
          - `tailscale`: Runs `tailscale login` to join the tailnet as root.
        '';
      }
      {
        filePath = "coder";
        docs = ''
          # [miko] Coder

          Helpful commands to sync code between machines.

          [Repository](https://github.com/mikojs/coder)
        '';
      }
    ];

    packages = [
      miko-initialize
      miko-coder
    ];
  };

  programs.fish.interactiveShellInit = ''
    ${miko-fish.interactiveShellInit}

    # coder
    if type -q coder
      coder --generate fish | source
    end
  '';
}
