{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    chromium
  ];

  services.upower.enable = true;
}
