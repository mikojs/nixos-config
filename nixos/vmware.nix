{
  pkgs,
  ...
}:
{
  imports = [
    ./specialization/i3.nix
    ./openssh.nix
    ./fcitx5.nix
    ./rofi.nix
    ./chromium.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  virtualisation.vmware.guest.enable = true;

  services.xserver.xrandrHeads = [
    {
      output = "Virtual-1";
      primary = true;
    }
  ];

  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      fira-code
    ];
  };
}
