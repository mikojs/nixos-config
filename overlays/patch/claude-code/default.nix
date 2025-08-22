inputs: {
  claude-code = import ./packages.nix (if inputs ? lib then inputs else (import <nixpkgs> { }));
}
