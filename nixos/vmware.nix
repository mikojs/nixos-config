{
  ...
}:
{
  imports = [ ./openssh.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
