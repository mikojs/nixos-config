final: prev:
with prev;
with prev.vimUtils;
{
  vimPlugins = vimPlugins // {
    sqls-nvim = import ./sqls-nvim.nix prev;
    vim-rzip = import ./vim-rzip.nix prev;

    # FIXME: those are in unstable nixpkgs

    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/editors/vim/plugins/generated.nix#L11618
    nvim-lspconfig = import ./nvim-lspconfig.nix prev;
  };
}
