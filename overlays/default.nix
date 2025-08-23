{
  inputs,
  system,
  ...
}:
{
  nixpkgs.overlays = [
    (import ./patch)
    (import ./custom)
    (import ./mcp-hub.nix { inherit inputs system; })
  ];
}
