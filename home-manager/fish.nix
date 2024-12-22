{
  pkgs,
  ...
}:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Disable Greeting
      set fish_greeting

      ${(import ./neovim/tokyonight-nvim.nix { inherit pkgs; }).programs.fish.interactiveShellInit}

      # Load Custom Env
      test -f ~/init.fish && source ~/init.fish 2> /dev/null
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
