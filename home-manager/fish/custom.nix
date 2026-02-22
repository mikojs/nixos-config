{
  pkgs,
  ...
}:
with pkgs;
{
  home = {
          file = (import ../../lib.nix).getDocs pkgs [
            {
              filePath = "initialize";
              docs = ''
                # [miko] Initialize
    
                Initialize the system with custom settings.
    
                [Code](https://github.com/mikojs/nixos-config/tree/main/overlays/custom/initialize)
    
                ## Support packages
    
                - `tide`
                - `gh`
                - `tailscale`
    
              '';
            }
            {
              filePath = "coder";
              docs = ''
                # [miko] Coder
    
                Some helpful commands to sync code between machines.
                Use `--help` to see available commands.
    
                [Code](https://github.com/mikojs/nixos-config/tree/main/overlays/custom/coder)
    
              '';
            }
          ];
    packages = [
      miko-initialize
      miko-coder
    ];
  };

  programs.fish.interactiveShellInit = miko-fish.interactiveShellInit;
}
