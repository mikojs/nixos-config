{
  pkgs,
  ...
}:
{
  home = {
    file = {
      ".docs/fastfetch.md".text = ''
        # Fastfetch

        A maintained, feature-rich and performance oriented, neofetch like system information tool.

        [Repository](https://github.com/fastfetch-cli/fastfetch)
      '';
    };

    packages = with pkgs; [
      fastfetch
    ];
  };
}
