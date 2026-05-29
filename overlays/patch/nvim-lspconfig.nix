{
  vimUtils,
  fetchFromGitHub,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "nvim-lspconfig";
  version = "2.9.0";
  src = fetchFromGitHub {
    owner = "neovim";
    repo = "nvim-lspconfig";
    rev = "v2.9.0";
    hash = "sha256-FuajmzcxEFxl4ZDJIJk23x2k0cqq/YRhRzzGvdVwN9M=";
  };
  meta.homepage = "https://github.com/neovim/nvim-lspconfig/";
  meta.hydraPlatforms = [ ];
}
