{
  pkgs,
  ...
}:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "Meslo"
      ];
    })
  ];
}
