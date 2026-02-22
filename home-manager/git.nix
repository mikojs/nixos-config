{
  gitconfig,
  ...
}:
{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file =
      miko.getDocs [
        {
          filePath = "git";
          docs = ''
            # Git

            Git is used to manage version control.

            [Repository](https://github.com/git/git)

            ## Alias

            - `d`: Show default `git diff` output.
            - `gr`: Show formatted git logs.
          '';
        }
        {
          filePath = "git/commitizen";
          docs = ''
            # Git commitizen

            Commitizen is used to manage commits.

            [Repository](https://github.com/commitizen-tools/commitizen)

            ```sh
            git cz
            ```
          '';
        }
        {
          filePath = "git/delta";
          docs = ''
            # Git delta

            A syntax-highlighting pager for git and diff output.

            [Repository](https://github.com/dandavison/delta)
          '';
        }
        {
          filePath = "git/serie";
          docs = ''
            # Git serie

            A rich git commit graph in your terminal.

            [Repository](https://github.com/lusingander/serie)
          '';
        }
      ]
      // {
        ".czrc".text = ''
          {
            "path": "cz-conventional-changelog"
          }
        '';
      };

    packages = with pkgs; [
      cz-cli
      delta
      serie
    ];
  };

  programs.git = {
    enable = true;

    settings = gitconfig // {
      init.defaultBranch = "main";
      pull.rebase = false;

      # delta
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.side-by-side = true;
      delta.navigate = true;
      delta.dark = true;
      mege.conflictStyle = "zdiff3";

      alias = {
        d = "-c pager.diff='less -R' diff";
        gr = "!serie";
      };
    };
  };
}
