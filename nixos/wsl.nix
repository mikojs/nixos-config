{
  pkgs,
  config,
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
    useWindowsDriver = true;
  };

  programs.nix-ld.enable = true;

  # why: useWindowsDriver puts the D3D12 libraries into /run/opengl-driver/lib, but Mesa's
  # dozen (Vulkan on WSL) dlopens them by name, so that directory has to be on the path
  environment.sessionVariables.LD_LIBRARY_PATH = [ "/run/opengl-driver/lib" ];

  # why: WSLg's Wayland (Weston 9) offers only text-input-v1, so no Wayland app gets an
  # input method; without WAYLAND_DISPLAY, GUI apps use WSLg's X11 (:0), where fcitx5
  # reaches them over XIM
  environment.extraInit = ''
    unset WAYLAND_DISPLAY
  '';

  # why: fish loads extraInit through fenv, which does not carry an unset over
  programs.fish.shellInit = ''
    set -e WAYLAND_DISPLAY
  '';

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [
        fcitx5-chewing
      ];

      settings.inputMethod = {
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "chewing";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "chewing";
        GroupOrder."0" = "Default";
      };
    };
  };

  # why: WSL has no desktop session to autostart fcitx5. Its wayland addons still find
  # WSLg's socket, WSLg refuses them input_method, and fcitx5 exits on that error
  systemd.user.services.fcitx5-wsl = {
    description = "Fcitx5 for WSLg X11 apps";
    wantedBy = [ "default.target" ];
    environment.DISPLAY = ":0";

    serviceConfig = {
      ExecStart = "${config.i18n.inputMethod.package}/bin/fcitx5 --disable=wayland,waylandim";
      Restart = "on-failure";
    };
  };

  # why: MesloLGS Nerd Font has no CJK, emoji or some symbol glyphs (Claude Code's ⏵,
  # U+23F5) and WSL ships no font for them; macOS has its own
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    (noto-fonts.override { variants = [ "NotoSansSymbols2" ]; })
  ];
}
