{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    miko-initialize
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = with pkgs; ''
      # Disable Greeting
      set fish_greeting

      ${(import ./neovim/tokyonight-nvim.nix { inherit pkgs; }).programs.fish.interactiveShellInit}
      ${miko-fish.interactiveShellInit}
    '';

    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        src = tide.src;
      }
    ];

    shellAliases = {
      nsf = ''nix-shell --run fish'';
    };
  };
}
