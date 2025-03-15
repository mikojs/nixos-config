{
  pkgs,
  ...
}:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      ignoreUserConfig = true;

      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-chinese-addons
        fcitx5-chewing
        fcitx5-nord
      ];

      settings = {
        globalOptions.Behavior = {
          resetStateWhenFocusIn = "All";
          ShareInputState = "All";
        };

        addons.classicui.globalSection = {
          Theme = "Nord-Dark";
          Font = "Fira Code Medium 8";
          MenuFont = "Fira Code Medium 8";
          TrayFont = "Fira Code Demi-Bold 8";
        };

        inputMethod = {
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
  };
}
