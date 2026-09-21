{
  stdenv,
  lib,
  fetchurl,
  makeWrapper,
  autoPatchelfHook,
  nodejs,
  ...
}:
stdenv.mkDerivation rec {
  pname = "ntn";
  version = "0.23.8";

  src = fetchurl {
    url = "https://registry.npmjs.org/ntn/-/ntn-${version}.tgz";
    hash = "sha512-NM4k3mVvCDWRLVnza/G7pOUeTaVMfzzIpAhUWRJokVP2lD4EPGm8z/3E22nmLXEMne8RuV/Quh0BrzP0MeUVQA==";
  };

  nativeBuildInputs = [ makeWrapper ] ++ lib.optionals stdenv.isLinux [ autoPatchelfHook ];

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/lib/ntn
    cp -r . $out/lib/ntn
    chmod +x $out/lib/ntn/bin/ntn
    makeWrapper $out/lib/ntn/bin/ntn $out/bin/ntn \
      --prefix PATH : ${lib.makeBinPath [ nodejs ]}
  '';
}
