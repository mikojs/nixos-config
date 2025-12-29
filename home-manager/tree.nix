{
  pkgs,
  ...
}:
{
  home = {
    file.".docs/tree.md".text = ''
      # Tree

      tree is a directory listing program that makes it easy to display a directory tree.

    '';

    packages = with pkgs; [
      tree
    ];
  };
}
