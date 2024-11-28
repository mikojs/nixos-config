{ pkgs
, inputs
, ...
}: {
  nixpkgs.overlays = with inputs; [
    awesome-neovim-plugins.overlays.default
  ];
}
