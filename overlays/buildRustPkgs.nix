final: prev:
with prev;
with lib;
with builtins;
{
  buildMikoRustPkgs =
    {
      prefix ? "",
      config,
    }:
    let
      custom-pkgs = listToAttrs (
        map (
          {
            name,
            pkgName ? "${prefix}-${name}",
            ...
          }:
          nameValuePair pkgName (
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
        ) config
      );
    in
    custom-pkgs
    // {
      "${prefix}-fish".interactiveShellInit = concatStrings (
        map
          (
            {
              name,
              skipGenerate ? false,
              ...
            }:
            ''
              # ${name}
              if type -q ${name}
                ${name} ${if skipGenerate then "" else "--generate fish | source"}
              end
            ''
          )
          (
            filter (
              {
                shouldInit ? false,
                ...
              }:
              shouldInit
            ) config
          )
      );
    };
}
