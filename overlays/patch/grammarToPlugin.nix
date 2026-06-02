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
  postInstall = (oldAttrs.postInstall or "") + ''
    if [ -f "${tsQueries}/runtime/queries/${lang}/folds.scm" ]; then
      mkdir -p $out/queries/${lang}
      cp "${tsQueries}/runtime/queries/${lang}/folds.scm" $out/queries/${lang}/folds.scm
    fi

    if [ -f "$out/queries/${lang}/highlights.scm" ]; then
      sed -i '/(#is-not? local)/d' "$out/queries/${lang}/highlights.scm"
    fi
  '';
})
