{
  pkgs,
  languages,
  ...
}:
let
  languagesConfig =
    with builtins;
    foldl' (
      result: l:
      let
        language = if l.language == "postgresql" || l.language == "sqlite" then "db" else l.language;
      in
      if pathExists ./${language}.nix then
        result
        ++ import ./${language}.nix {
          inherit pkgs;
        }
      else
        result
    ) languages;
in
{
  home.packages =
    with builtins;
    foldl' (
      result: l: if hasAttr "packages" l then result ++ l.packages else result
    ) [ ] languagesConfig;

  programs.neovim.plugins =
    with pkgs.vimPlugins;
    with builtins;
    [
      {
        plugin = conform-nvim;
        config = ''
          lua << END
            require("conform").setup({
              formatters_by_ft = {
                ${concatStringsSep ",\n" (map (l: l.formatter) languagesConfig)}
              },
              format_on_save = true,
            })
          END
        '';
      }
    ];
}
