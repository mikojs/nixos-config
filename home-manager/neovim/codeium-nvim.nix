{
  pkgs,
  ...
}:
{
  programs.neovim.plugins =
    with pkgs;
    with pkgs.vimUtils;
    [
      {
        plugin = buildVimPlugin {
          pname = "codeium.vim";
          version = "2025-01-14";
          src = fetchFromGitHub {
            owner = "Exafunction";
            repo = "codeium.vim";
            rev = "000de972de76f357c03da14f4f8dd9a969d4fe8c";
            sha256 = "0hkmgfph4r2ayw5ch7yhiqffqccglksckgl5nb0dzsbpzvqk6g81";
          };
          meta.homepage = "https://github.com/Exafunction/codeium.vim/";
        };
      }
    ];
}
