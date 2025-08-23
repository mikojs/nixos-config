final: prev:
with prev;
with prev.vimUtils;
{
  vimPlugins = vimPlugins // {
    sqls-nvim = import ./sqls-nvim.nix prev;
    vim-rzip = import ./vim-rzip.nix prev;
  };

  # FIXME: those are in unstable nixpkgs

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ta/tabiew
  tabiew = import ./tabiew.nix prev;

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/so/somo
  somo = import ./somo.nix prev;

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/editors/vim/plugins/non-generated/avante-nvim
  avante-nvim = import ./avante-nvim.nix prev;

  # https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/by-name/ge/gemini-cli
  gemini-cli = import ./gemini-cli/packages.nix prev;

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/cl/claude-code
  claude-code = import ./claude-code/packages.nix prev;
}
