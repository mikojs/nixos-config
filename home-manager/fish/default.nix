{
  pkgs,
  ...
}:
with builtins;
let
  configs = map (m: import m { inherit pkgs; }) ([
    ./custom.nix
  ]);

  getConfig =
    with builtins;
    (
      keys: default:
      (foldl' (
        result: config:
        let
          data = (
            foldl' (
              result: key: if result != null && hasAttr "${key}" result then result."${key}" else null
            ) config keys
          );
        in
        if data != null then
          (if isList default || isString default then result ++ data else result // data)
        else
          result
      ) default configs)
    );
in
{
  home.packages =
    getConfig
      [
        "home"
        "packages"
      ]
      [ ];

  programs.fish = {
    enable = true;
    interactiveShellInit =
      getConfig
        [
          "programs"
          "fish"
          "interactiveShellInit"
        ]
        ''
          # Disable Greeting
          set fish_greeting
        '';

    plugins =
      getConfig
        [
          "programs"
          "fish"
          "plugins"
        ]
        [ ];

    shellAliases = {
      nsf = ''nix-shell --run "SHELL=$SHELL; fish"'';
    };
  };
}
