inputs: final: prev:
with prev;
with prev.vimUtils;
{
  vimPlugins = vimPlugins // {
    sqls-nvim = import ./sqls-nvim.nix prev;
    vim-rzip = import ./vim-rzip.nix prev;
  };

  oxker = import ./oxker.nix prev;
  ntn = import ./ntn.nix prev;

  # FIXME: remove it after nixos upgrade > 26.05
  rtk = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.rtk;
}
