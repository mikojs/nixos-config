{
  pkgs,
  ...
}:
{
  home.file = (import ../lib.nix).getDocs pkgs [
    {
      filePath = "gh";
      docs = ''
        # GH

        GitHub CLI is used to login to GitHub and control repositories.

        [Repository](https://github.com/cli/cli)
      '';
    }
    {
      filePath = "gh/poi";
      docs = ''
        # GH gh-poi

        Safely clean up your local branches.

        [Repository](https://github.com/seachicken/gh-poi)
      '';
    }
  ];

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-poi
    ];
  };
}
