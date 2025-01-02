{
  rustPlatform,
}:
with rustPlatform;
buildRustPackage {
  name = "init";
  src = ./..;
  cargoLock = {
    lockFile = ../Cargo.lock;
  };
  buildPhase = ''
    cargo build --release -p init
  '';
  installPhase = ''
    mkdir $out/bin
    cp -r target/release/init $out/bin/init
  '';
}
