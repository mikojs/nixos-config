{
  rustPlatform,
}:
with rustPlatform;
buildRustPackage {
  name = "initialize";
  src = ./..;

  cargoLock = {
    lockFile = ../Cargo.lock;
  };

  buildPhase = ''
    cargo build --release -p initialize
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r target/release/initialize $out/bin
  '';
}
