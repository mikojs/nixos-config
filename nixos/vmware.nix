{
  pkgs,
  ...
}:
{
  imports = [
    ./specialization/i3.nix
    ./openssh.nix
    ./firefox.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  virtualisation.vmware.guest.enable = true;

  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      fira-code
    ];
  };
}
