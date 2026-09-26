{ pkgs }:
let
  statusline = import ./statusline.nix { inherit pkgs; };
  approvalHook = import ./approval-hook.nix { inherit pkgs; };
in
{
  "statusLine" = {
    "type" = "command";
    "command" = "${statusline}/bin/claude-statusline";
  };

  "hooks" = {
    "Notification" = [
      {
        "matcher" = "permission_prompt";
        "hooks" = [
          {
            "type" = "command";
            "command" = "${approvalHook}/bin/claude-approval-hook";
          }
        ];
      }
    ];
  };
}
