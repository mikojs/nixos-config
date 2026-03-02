{
  lib,
  n8n,
  timezones,
  ...
}:
with lib;
with builtins;
let
  data = n8n // {
    genericTimezone = (if length timezones <= 0 then "America/New_York" else (elemAt timezones 0));
  };
  keys = (attrNames data);
  rawEnv = map (key: "\${${toUpper (replaceStrings upperChars (map (c: "_${c}") upperChars))}}") keys;
  newEnv = map (key: data."${key}") keys;
in
{
  fish-alias = [
    "- `n8n`: Run `n8n` server with docker compose."
  ];

  home.file = {
    ".n8n/init-data.sh".text = replaceStrings rawEnv newEnv (readFile ./init-data.sh);
    ".n8n/docker-compose.yml".text = replaceStrings rawEnv newEnv (readFile ./docker-compose.yml);
  };

  programs.fish.shellAliases = {
    n8n = "cat ~/.n8n/init-data.sh > ~/.n8n/_init-data.sh; chmod +x ~/.n8n/_init-data.sh; docker compose -f ~/.n8n/docker-compose.yml";
    n8n-exec = "docker exec -it $(docker ps -f name=n8n-n8n-1 --format json | jq -r .ID) /bin/sh";
  };
}
