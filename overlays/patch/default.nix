inputs: final: prev:
with prev;
with prev.vimUtils;
let
  # claude-code and antigravity-cli are unfree; legacyPackages uses
  # nixpkgs-unstable's own default config (allowUnfree = false), so they need
  # their own import with allowUnfree set rather than reusing legacyPackages.
  unstableUnfree = import inputs.nixpkgs-unstable {
    inherit (prev) system;
    config.allowUnfree = true;
  };
in
{
  vimPlugins = vimPlugins // {
    sqls-nvim = import ./sqls-nvim.nix prev;
    vim-rzip = import ./vim-rzip.nix prev;
  };

  oxker = import ./oxker.nix prev;
  ntn = import ./ntn.nix prev;

  # FIXME: remove it after nixos upgrade > 26.05
  rtk = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.rtk;
  claude-code = unstableUnfree.claude-code;
  antigravity-cli = unstableUnfree.antigravity-cli;
}
