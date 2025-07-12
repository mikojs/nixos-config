{
  pkgs,
  system,
  ...
}:
{
  nixpkgs.hostPlatform = system;
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
  ];
}
