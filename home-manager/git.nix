{
  gitconfig,
  ...
}:
{
  pkgs,
  ...
}:
{
  home = {
    file = {
      ".docs/git.md".text = ''
        # Git

        Git is used to manage version control.

        [Repository](https://github.com/git/git)

        ## Alias

        - `d`: Show default `git diff` output.
        - `gr`: Show formatted git logs.

      '';

      ".docs/git/commitizen.md".text = ''
        # Git commitizen

        Commitizen is used to manage commits.

        [Repository](https://github.com/commitizen-tools/commitizen)

        ```sh
        git cz
        ```

      '';

      ".docs/git/delta.md".text = ''
        # Git Delta

        A syntax-highlighting pager for git and diff output.

        [Repository](https://github.com/dandavison/delta)

      '';

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
        gr = "serie";
      };
    };
  };
}
