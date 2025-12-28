{
  pkgs,
  ...
}:
{
  home = {
    file.".docs/jless.md".text = ''
      # JLess

      Jless is a less-like pager for JSON files.

      [Repository](https://github.com/PaulJuliusMartinez/jless)

    '';

    packages = with pkgs; [
      jless
    ];
  };
}
