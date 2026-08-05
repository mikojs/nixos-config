{
  obsidian,
  stdenv,
  ...
}:
# nixpkgs' obsidian 1.13.4 darwin build is broken: it sets
# `sourceRoot = "Obsidian.app"`, but the dmg now extracts to
# `Obsidian <version>-universal/Obsidian.app`, so unpackPhase fails with
# `chmod: cannot access 'Obsidian.app'`. Fixed upstream in
# NixOS/nixpkgs#548462 (commit dea0d9e) but not yet backported to the
# release-26.05 branch this flake pins. Remove once the backport lands.
# FIXME: https://github.com/NixOS/nixpkgs/issues/549208
if !stdenv.hostPlatform.isDarwin then
  obsidian
else
  obsidian.overrideAttrs (old: {
    sourceRoot = "Obsidian ${old.version}-universal/Obsidian.app";
  })
