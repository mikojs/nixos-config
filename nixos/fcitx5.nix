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
        fcitx5-configtool
        fcitx5-chinese-addons
        fcitx5-chewing
        fcitx5-material-color
      ];

      settings = {
        # addons = {
        #   classicui.globalSection.Theme = "Material-Color-deepPurple";
        #   classicui.globalSection.DarkTheme = "Material-Color-deepPurple";
        #   pinyin.globalSection = {
        #     PageSize = 9;
        #     CloudPinyinEnabled = "True";
        #     CloudPinyinIndex = 2;
        #   };
        #   cloudpinyin.globalSection = {
        #     Backend = "Baidu";
        #   };
        # };

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
