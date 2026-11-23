{
  inputs,
  ...
}:
with inputs;
{
  imports = [
    nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    docker-desktop.enable = true;
  };

  programs.nix-ld.enable = true;

  # why: its wrapper relies on WSLg and the WSL D3D12 libraries
  home-manager.sharedModules = [
    ../home-manager/herdr-app.nix
  ];
}
