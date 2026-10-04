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
  # antigravity-cli is unfree; legacyPackages uses nixpkgs-unstable's own
  # default config (allowUnfree = false), so it needs its own import with
  # allowUnfree set rather than reusing the shared legacyPackages set.
  antigravity-cli =
    (import inputs.nixpkgs-unstable {
      inherit (prev) system;
      config.allowUnfree = true;
    }).antigravity-cli;
}
