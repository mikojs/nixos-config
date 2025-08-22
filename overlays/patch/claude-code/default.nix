# other files are copied from https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/cl/claude-code
inputs: {
  claude-code = import ./packages.nix (if inputs ? lib then inputs else (import <nixpkgs> { }));
}
