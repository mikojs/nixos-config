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
}
