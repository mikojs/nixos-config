{
  lib,
  neovimUtils,
  fetchFromGitHub,
  ...
}:
grammar:
let
  drv = neovimUtils.grammarToPlugin grammar;
  lang = lib.removePrefix "tree-sitter-" grammar.pname;
  tsQueries = fetchFromGitHub {
    owner = "nvim-treesitter";
    repo = "nvim-treesitter";
    rev = "main";
    sha256 = "sha256-PQR6tFt4lCrAZNQG7BLMD1IiCKja9wDS1S4laGJf/HE=";
  };
in
drv.overrideAttrs (oldAttrs: {
  postPhases = (oldAttrs.postPhases or [ ]) ++ [ "overrideNvimQueries" ];
  overrideNvimQueries = ''
    if [ -d "${tsQueries}/runtime/queries/${lang}" ]; then
      rm -rf $out/queries/${lang}
      cp -r "${tsQueries}/runtime/queries/${lang}" $out/queries/${lang}
    fi
  '';
})
