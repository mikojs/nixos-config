{
  pkgs,
  rustPlatform,
}:
with pkgs;
with rustPlatform;
buildRustPackage {
  name = "init";
  src = ./..;
}
