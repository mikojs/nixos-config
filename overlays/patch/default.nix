final: prev:
with prev;
with prev.vimUtils;
{
  vimPlugins = vimPlugins // {
    sqls-nvim = import ./sqls-nvim.nix prev;
    vim-rzip = import ./vim-rzip.nix prev;
  };

  # FIXME: https://discourse.nixos.org/t/tree-sitter-neovim-grammar-plugins-dont-forward-queries/41869
  neovimUtils = neovimUtils // {
    grammarToPlugin = import ./grammarToPlugin.nix prev;
  };
}
