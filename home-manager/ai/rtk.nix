{
  pkgs,
  miko,
  ...
}:
let
  configPath =
    if pkgs.stdenv.isDarwin then
      "Library/Application Support/rtk/config.toml"
    else
      ".config/rtk/config.toml";
in
{
  home = {
    file =
      miko.getDocs [
        {
          filePath = "ai/rtk";
          docs = ''
            # RTK

            CLI proxy that reduces LLM token consumption by 60-90% on common dev commands, shipped as a single dependency-free Rust binary.

            [Repository](https://github.com/rtk-ai/rtk/)
          '';
        }
      ]
      // {
        # grep and rg are the rtk filters that report wrong results rather than
        # just fewer of them — rg runs through the same filter as grep (per
        # `rtk rg --help`), which swallows -h/-l/-m/-t, caps output at 25 rows
        # per file while the header still claims the true match count,
        # truncates lines at 80 chars, and returns the wrong lines through
        # `| head`; the same classes of defect are open upstream (rtk-ai/rtk
        # #2988, #3663, #4207). A wrong grep/rg result silently misleads
        # whoever reads it, which costs far more than the tokens this filter
        # saves. Native grep/rg instead; every other command stays hooked.
        "${configPath}".source = pkgs.writeText "rtk-config.toml" ''
          [hooks]
          exclude_commands = ["grep", "rg"]
        '';
      };

    packages = [
      pkgs.rtk
    ];
  };
}
