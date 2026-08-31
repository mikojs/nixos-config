{
  language,
}:
{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "rust";
        docs = ''
          # Rust

          A language empowering everyone to build reliable and efficient software. The compiler is `rustc`.

          [Website](https://www.rust-lang.org/)

          ## Support packages

          - `gcc`: Cargo needs a C toolchain to link the binaries it builds.
        '';
      }
      {
        filePath = "cargo";
        docs = ''
          # Cargo

          Cargo downloads your Rust project's dependencies and builds your project.

          [Website](https://doc.rust-lang.org/cargo/)
        '';
      }
    ];

    packages = with pkgs; [
      gcc
      rustc
      cargo
    ];
  };
}
