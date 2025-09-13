{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    glances
  ];

  xdg.configFile = {
    "glances/glances.conf".text = ''
      [global]
      check_update=false
    '';
  };
}
