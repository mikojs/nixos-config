{
  lib,
  inputs,
  ...
}:
with inputs;
{
  imports = [
    nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    docker-desktop.enable = true;
  };

  programs.nix-ld.enable = true;

  # why: mkAfter, so this wraps the herdr-desktop that overlays/patch sets rather than
  # being replaced by it
  nixpkgs.overlays = lib.mkAfter [
    (final: prev: {
      fcitx5-wsl = prev.qt6Packages.fcitx5-with-addons.override {
        addons = [ prev.fcitx5-chewing ];
        withConfigtool = false;
      };

      # why: /usr/lib/wsl/lib holds the D3D12 libraries Mesa's dozen (Vulkan on WSL) loads;
      # gpui panics without XDG_RUNTIME_DIR, and WSL logins do not always set it.
      # WSLg windows get no Windows IME input, so Chinese goes through fcitx5 over XIM, which
      # gpui supports only on X11: WAYLAND_DISPLAY is unset to force X11 (WSLg's :0).
      # fcitx5's wayland addons still find wayland-0, WSLg refuses them input_method, and
      # fcitx5 exits on that error, so they are disabled. fcitx5-with-addons runs as
      # .fcitx5-wrapped, so the running check matches the command line, not the name
      herdr-desktop = prev.symlinkJoin {
        inherit (prev.herdr-desktop) name meta;

        paths = [ prev.herdr-desktop ];
        nativeBuildInputs = [ prev.makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/herdr-app \
            --run 'export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"' \
            --set-default DISPLAY :0 \
            --unset WAYLAND_DISPLAY \
            --set XMODIFIERS @im=fcitx \
            --run '${prev.procps}/bin/pgrep -u "$(id -u)" -f ${final.fcitx5-wsl}/bin/fcitx5 >/dev/null || ${final.fcitx5-wsl}/bin/fcitx5 -d --disable=wayland,waylandim' \
            --prefix LD_LIBRARY_PATH : /usr/lib/wsl/lib
        '';
      };
    })
  ];

  home-manager.sharedModules = [
    (
      {
        lib,
        pkgs,
        miko,
        config,
        ...
      }:
      {
        home = {
          file = miko.getDocs [
            {
              filePath = "herdr-desktop-wsl";
              docs = ''
                # Herdr desktop on WSL

                How Herdr desktop is set up to run through WSLg on WSL.

                [Repository](https://github.com/herdrdev/herdr-app)

                ## Support packages

                - `fcitx5` with `fcitx5-chewing`: Chinese input. `herdr-app` starts fcitx5
                  if it is not running. The profile at `~/.config/fcitx5/profile` is
                  seeded once and is yours to change afterwards.
                  [Repository](https://github.com/fcitx/fcitx5)
                - `noto-fonts-cjk-sans`: CJK glyphs, which WSL and the app's bundled fonts
                  lack. [Repository](https://github.com/notofonts/noto-cjk)

                ## Keybindings

                - Ctrl+Space toggles fcitx5 between the US keyboard and chewing.

                ## Gotcha

                - The app runs on WSLg's X11 server `:0`, not Wayland: WSLg windows get no
                  Windows IME input, and fcitx5 reaches the app only over XIM, which it
                  supports only on X11.
                - Vulkan goes through Mesa's dozen over the Windows D3D12 libraries in
                  `/usr/lib/wsl/lib`. dozen is not a conformant implementation, and
                  llvmpipe (CPU) is the fallback.
                - The first input after switching to chewing can lag for a moment, then
                  settles.
              '';
            }
          ];

          packages = with pkgs; [
            noto-fonts-cjk-sans
          ];

          # why: seeded, not linked: fcitx5 rewrites its profile, which a store symlink would block
          activation.herdrDesktopFcitxProfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            profile="${config.xdg.configHome}/fcitx5/profile"
            if [ ! -e "$profile" ]; then
              run mkdir -p "$(dirname "$profile")"
              run install -m644 ${pkgs.writeText "fcitx5-profile" ''
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
    )
  ];
}
