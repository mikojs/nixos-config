{
  inputs,
  system,
  ...
}:
{
  nixpkgs.overlays = [
    (import ./patch.nix)
    (import ./custom)
    (import ./mcp-hub.nix { inherit inputs system; })
  ];
}
