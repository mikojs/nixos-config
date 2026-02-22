{
  pkgs,
  ...
}:
{
  home = {
    file = (import ../lib.nix).getDocs pkgs [
      {
        filePath = "fastfetch";
        docs = ''
          # Fastfetch

          A maintained, feature-rich and performance oriented, neofetch like system information tool.

          [Repository](https://github.com/fastfetch-cli/fastfetch)
        '';
      }
    ];

    packages = with pkgs; [
      fastfetch
    ];
  };
}
