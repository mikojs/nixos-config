final: prev:
with prev;
with lib;
with builtins;
let
  custom-pkgs = listToAttrs (
    map
      (
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
      )
      [
        "initialize"
        "db"
      ]
  );
in
custom-pkgs
// {
  miko-fish.interactiveShellInit = ''
    # Initialize
    if type -q initialize
      initialize
    end

    # db
    if type -q db
      db --generate fish | source
    end
  '';
}
