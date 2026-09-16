{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "ai/rtk";
        docs = ''
          # RTK

          CLI proxy that reduces LLM token consumption by 60-90% on common dev commands, shipped as a single dependency-free Rust binary.

          [Repository](https://github.com/rtk-ai/rtk/)
        '';
      }
    ];

    packages = [
      pkgs.rtk
    ];
  };
}
