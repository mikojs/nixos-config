{ pkgs
, languages
, ...
}: with builtins; (map
  (l: import ./${l.language}.nix {
    inherit pkgs;
  })
  (filter (l: pathExists ./${l.language}.nix) languages)
)
