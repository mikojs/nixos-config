{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "smux";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "ShawnPana";
    repo = "smux";
    rev = "95bf0b639e64a4c67b4f007b1bedc26395344e01";
    hash = "sha256-KaDI81xqdoxvASG/uwlSdhJWw4u6cZhrbk/ihSPc9zs=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 scripts/tmux-bridge $out/bin/tmux-bridge
    install -Dm644 .tmux.conf $out/share/smux/tmux.conf

    runHook postInstall
  '';

  passthru.configPath = "${finalAttrs.finalPackage}/share/smux/tmux.conf";

  meta = {
    description = "tmux config with built-in terminal automation and agent-to-agent communication";
    homepage = "https://github.com/ShawnPana/smux";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "tmux-bridge";
    platforms = lib.platforms.unix;
  };
})
