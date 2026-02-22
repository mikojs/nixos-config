{
  pkgs,
  ...
}:
{
  home = {
    file =
      with pkgs.miko;
      getDocs [
        {
          filePath = "jless";
          docs = ''
            # JLess

            Jless is a less-like pager for JSON files.

            [Repository](https://github.com/PaulJuliusMartinez/jless)
          '';
        }
      ];

    packages = with pkgs; [
      jless
    ];
  };
}
