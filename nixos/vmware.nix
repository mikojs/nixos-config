{
  pkgs,
  ...
}:
{
  imports = [
    ./specialization/i3.nix
    ./openssh.nix
    ./rofi.nix
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

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-configtool
      fcitx5-chinese-addons
      fcitx5-chewing
      fcitx5-material-color
    ];
  };
}
