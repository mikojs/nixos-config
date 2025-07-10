{
  pkgs,
  ...
}:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
  ];
}
