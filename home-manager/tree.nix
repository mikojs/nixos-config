{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "tree";
        docs = ''
          # Tree

          tree is a directory listing program that makes it easy to display a directory tree.

          [Website](https://oldmanprogrammer.net/source.php?dir=projects/tree)
        '';
      }
    ];

    packages = with pkgs; [
      tree
    ];
  };
}
