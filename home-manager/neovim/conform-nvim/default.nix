{
  pkgs,
  languages,
  ...
}:
let
  languagesConfig =
    with builtins;
    map (
      l:
      import ./${l.language}.nix {
        inherit pkgs;
      }
    ) (filter (l: pathExists ./${l.language}.nix) languages);
in
{
  home.packages =
    with builtins;
    foldl' (
      result: l: if hasAttr "packages" l then result ++ l.packages else result
    ) [ ] languagesConfig;

  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = conform-nvim;
      config = ''
        lua << END
          require("conform").setup({
            formatters_by_ft = {
              ${builtins.concatStringsSep ",\n" (map (l: l.formatter) languagesConfig)}
            },
            format_on_save = true,
          })
        END
      '';
    }
  ];
}
