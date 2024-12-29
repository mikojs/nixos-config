{
  pkgs,
  ...
}:
{
  home.packages = with pkgs.vimPlugins; [
    todo-comments-nvim
  ];
}
