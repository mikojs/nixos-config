{
  vimUtils,
  fetchFromGitHub,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "nvim-lspconfig";
  version = "2.6.0-unstable-2026-02-27";
  src = fetchFromGitHub {
    owner = "neovim";
    repo = "nvim-lspconfig";
    rev = "ead0f5f342d8d323441e7d4b88f0fc436a81ad5f";
    hash = "sha256-kBUMraEK8L3jFSyJqozY+dZJ3eJj8AhBvIf0eHXaz2E=";
  };
  meta.homepage = "https://github.com/neovim/nvim-lspconfig/";
  meta.hydraPlatforms = [ ];
}
