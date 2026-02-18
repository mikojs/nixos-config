{
  ...
}:
{
  fish-alias = [
    "- `ssh`: We need to override the default `ssh` alias to use `kitty +kitten ssh` for macOS."
  ];

  programs.fish.shellAliases = {
    ssh = "kitty +kitten ssh";
  };
}
