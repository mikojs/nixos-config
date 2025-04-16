{
  rustPlatform,
}:
with rustPlatform;
buildRustPackage {
  name = "coder";
  src = ./..;

  cargoLock = {
    lockFile = ../Cargo.lock;
  };

  buildPhase = ''
    cargo build --release -p coder
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r target/release/coder $out/bin
  '';
}
