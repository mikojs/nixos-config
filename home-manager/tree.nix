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
          filePath = "tree";
          docs = ''
            # Tree

            tree is a directory listing program that makes it easy to display a directory tree.
          '';
        }
      ];

    packages = with pkgs; [
      tree
    ];
  };
}
