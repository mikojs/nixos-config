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
            pkgName ? "${prefix}${name}",
            github ? "",
            ...
          }:
          nameValuePair pkgName (
            with rustPlatform;
            if github == "" then
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
            else
              buildRustPackage {
                inherit name;

                src = fetchFromGitHub github;
              }
          )
        ) config
      );
    in
    custom-pkgs
    // {
      "${prefix}fish".interactiveShellInit = concatStrings (
        map
          (
            {
              name,
              hasGernerate ? true,
              ...
            }:
            ''
              # ${name}
              if type -q ${name}
                ${name} ${if !hasGernerate then "" else "--generate fish | source"}
              end
            ''
          )
          (
            filter (
              {
                shellInit ? true,
                ...
              }:
              shellInit
            ) config
          )
      );
    };
}
