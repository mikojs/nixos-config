final: prev:
with prev;
with lib;
with builtins;
let
  custom-pkg-names = [
    "initialize"
    "db"
  ];

  custom-pkgs = listToAttrs (
    map (
      name:
      nameValuePair "miko-${name}" (
        with rustPlatform;
        buildRustPackage {
          inherit name;
          src = ./.;

          cargoLock = {
            lockFile = ./Cargo.lock;
          };

          buildPhase = ''
            cargo build --release -p ${name}
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp -r target/release/${name} $out/bin
          '';
        }
      )
    ) custom-pkg-names
  );
in
custom-pkgs
// {
  miko-fish.interactiveShellInit = concatStrings (
    map (name: ''
      # ${name}
      if type -q ${name}
        ${name} ${if name == "initialize" then "" else "--generate fish | source"}
      end
    '') custom-pkg-names
  );
}
