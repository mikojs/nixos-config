with builtins;
{
  getConfig =
    modules: inputs:
    let
      configs = map (m: import m inputs) modules;
    in
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
          (
            if isList default then
              result ++ data
            else if isString default then
              result + "\n" + data
            else
              result // data
          )
        else
          result
      ) default configs)
    );

  getDocs =
    pkgs: name: docs:
    let
      note = if hasAttr "${name}-note" pkgs then pkgs."${name}-note" else "";
    in
    "${docs}\n${note}";
}
