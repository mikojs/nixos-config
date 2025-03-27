{
  rustPlatform,
}:
with rustPlatform;
buildRustPackage {
  name = "db";
  src = ./..;

  cargoLock = {
    lockFile = ../Cargo.lock;
  };

  buildPhase = ''
    cargo build --release -p db
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r target/release/db $out/bin
  '';
}
