{
  pkgs,
  ...
}:
{
  imports = [ ./openssh.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      fira-code
    ];
  };
}
