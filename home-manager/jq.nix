{
  pkgs,
  ...
}:
{
  home = {
    file = (import ../../lib.nix).getDocs pkgs [
      {
        filePath = "jq";
        docs = ''
          # JQ

          JQ is a lightweight and flexible command-line JSON processor.

          [Repository](https://github.com/stedolan/jq)

        '';
      }
    ];

    packages = with pkgs; [
      jq
    ];
  };
}
