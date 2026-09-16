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

          ```sh
          coder sync <bundle>            # apply a bundle to the local repo
          coder push <ssh_url> <dir>     # bundle local branches, scp to remote, sync there
          coder pull <ssh_url> <dir>     # bundle remote branches, scp to local, sync here
          coder --generate fish          # print fish completion script
          ```

          ## Gotcha

          - `coder push` runs `coder sync` on the remote machine over SSH, so `coder`
            must already be installed there — it is not bundled or installed for you.
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
