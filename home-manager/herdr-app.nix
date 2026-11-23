{
  lib,
  pkgs,
  miko,
  config,
  ...
}:
with pkgs;
let
  # herdr-core's Linux build is static, so the release binary runs as is.
  herdrCore = stdenvNoCC.mkDerivation rec {
    pname = "herdr-core";
    version = "0.1.22";

    src = fetchurl {
      url = "https://releases.herdr.dev/core/${version}/herdr-core-linux-x86_64.tar.gz";
      sha256 = "3054ec3992ce80c5715d721caa9dcefa6056721d15dc113f4750afce763ba5df";
    };

    sourceRoot = ".";

    installPhase = ''
      install -Dm755 herdr-core $out/bin/herdr-core
      ln -s herdr-core $out/bin/hc
    '';
  };

  # herdr-app links libxcb and xkbcommon, and dlopens vulkan, wayland and EGL at runtime.
  herdrApp = stdenv.mkDerivation rec {
    pname = "herdr-app";
    version = "0.1.17";

    src = fetchurl {
      url = "https://releases.herdr.dev/app/${version}/herdr-app-linux-x86_64.tar.gz";
      sha256 = "2188f4d7d5cf041450dbdbf2e14649244b1a6274a1080bdd97fa7bc450e65ca1";
    };

    nativeBuildInputs = [
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs = [
      stdenv.cc.cc.lib
      libxcb
      libxkbcommon
    ];

    installPhase = ''
      install -Dm755 herdr-app $out/libexec/herdr-app/herdr-app
      install -Dm644 herdr-app.svg $out/share/icons/hicolor/scalable/apps/herdr-app.svg

      # why: /usr/lib/wsl/lib holds the D3D12 libraries Mesa's dozen (Vulkan on WSL) loads;
      # gpui panics without XDG_RUNTIME_DIR, and WSL logins do not always set it.
      # WSLg windows get no Windows IME input, so Chinese goes through fcitx5 over XIM, which
      # gpui supports only on X11: WAYLAND_DISPLAY is unset to force X11 (WSLg's :0).
      # fcitx5's wayland addons still find wayland-0, WSLg refuses them input_method, and
      # fcitx5 exits on that error, so they are disabled
      makeWrapper $out/libexec/herdr-app/herdr-app $out/bin/herdr-app \
        --run 'export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"' \
        --set-default DISPLAY :0 \
        --unset WAYLAND_DISPLAY \
        --set XMODIFIERS @im=fcitx \
        --run '${procps}/bin/pgrep -u "$(id -u)" -x fcitx5 >/dev/null || ${fcitx}/bin/fcitx5 -d --disable=wayland,waylandim' \
        --prefix PATH : ${lib.makeBinPath [ herdrCore ]} \
        --prefix LD_LIBRARY_PATH : ${
          lib.makeLibraryPath [
            vulkan-loader
            wayland
            libglvnd
            libxkbcommon
            libxcb
          ]
        }:/usr/lib/wsl/lib
    '';
  };

  fcitx = qt6Packages.fcitx5-with-addons.override {
    addons = [ fcitx5-chewing ];
    withConfigtool = false;
  };
in
{
  home = {
    file = miko.getDocs [
      {
        filePath = "herdr-app";
        docs = ''
          # Herdr app

          Desktop app for terminals and coding agents, running on herdr-core (`hc`).

          [Repository](https://github.com/herdrdev/herdr-app)

          ## Support packages

          - `herdr-core` (`hc`): the runtime the app runs every terminal on; it must be
            on PATH. [Repository](https://github.com/herdrdev/herdr-core)
          - `fcitx5` with `fcitx5-chewing`: Chinese input. `herdr-app` starts fcitx5 if
            it is not running. The profile at `~/.config/fcitx5/profile` is seeded once
            and is yours to change afterwards. [Repository](https://github.com/fcitx/fcitx5)
          - `noto-fonts-cjk-sans`: CJK glyphs, which the fonts bundled with the app lack.
            [Repository](https://github.com/notofonts/noto-cjk)

          ## Keybindings

          - Ctrl+Space toggles fcitx5 between the US keyboard and chewing.

          ## Gotcha

          - Installed on WSL only. It runs through WSLg on its X11 server `:0`, not
            Wayland, because WSLg windows get no Windows IME input and fcitx5 reaches the
            app only over XIM, which it supports only on X11.
          - Vulkan goes through Mesa's dozen over the Windows D3D12 libraries in
            `/usr/lib/wsl/lib`. dozen is not a conformant implementation, and llvmpipe
            (CPU) is the fallback.
          - The first input after switching to chewing can lag for a moment, then
            settles.
          - The release binary is pinned here, so the app's own background update cannot
            replace it.
        '';
      }
    ];

    packages = [
      herdrApp
      herdrCore
      noto-fonts-cjk-sans
    ];

    # why: seeded, not linked: fcitx5 rewrites its profile, which a store symlink would block
    activation.herdrAppFcitxProfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      profile="${config.xdg.configHome}/fcitx5/profile"
      if [ ! -e "$profile" ]; then
        run mkdir -p "$(dirname "$profile")"
        run install -m644 ${writeText "fcitx5-profile" ''
          [Groups/0]
          Name=Default
          Default Layout=us
          DefaultIM=chewing

          [Groups/0/Items/0]
          Name=keyboard-us
          Layout=

          [Groups/0/Items/1]
          Name=chewing
          Layout=

          [GroupOrder]
          0=Default
        ''} "$profile"
      fi
    '';
  };
}
