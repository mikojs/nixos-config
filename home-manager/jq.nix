{
  pkgs,
  ...
}:
{
  home = {
    file.".docs/jq.md".text = ''
      # JQ

      JQ is a lightweight and flexible command-line JSON processor.

      [Repository](https://github.com/stedolan/jq)

    '';

    packages = with pkgs; [
      jq
    ];
  };
}
