{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    initialize
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Disable Greeting
      set fish_greeting

      ${(import ./neovim/tokyonight-nvim.nix { inherit pkgs; }).programs.fish.interactiveShellInit}

      # Initialize
      initialize
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
