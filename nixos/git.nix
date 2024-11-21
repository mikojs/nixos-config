{ pkgs
, ...
}: {
  environment.systemPackages = with pkgs; [
    cz-cli
  ];
  programs.git = {
    enable = true;
  };
}
