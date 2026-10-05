{ pkgs }:
let
  statusline = import ./statusline.nix { inherit pkgs; };
in
{
  "statusLine" = {
    "type" = "command";
    "command" = "${statusline}/bin/claude-statusline";
  };
}
