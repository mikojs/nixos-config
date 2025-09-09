{
  n8n,
  ...
}:
with builtins;
let
  rawEnv = [
    "\${POSTGRES_USER}"
    "\${POSTGRES_PASSWORD}"
    "\${POSTGRES_DB}"
    "\${POSTGRES_NON_ROOT_USER}"
    "\${POSTGRES_NON_ROOT_PASSWORD}"
  ];
  newEnv = [
    n8n.postgresUser
    n8n.postgresPassword
    n8n.postgresDb
    n8n.postgresNonRootUser
    n8n.postgresNonRootPassword
  ];
in
{
  home.file = {
    ".n8n/init-data.sh".text = replaceStrings rawEnv newEnv (readFile ./init-data.sh);
    ".n8n/docker-compose.yml".text =
      replaceStrings
        (
          rawEnv
          ++ [
            "\${HOME_DIR}"
          ]
        )
        (
          newEnv
          ++ [
            n8n.homeDir
          ]
        )
        (readFile ./docker-compose.yml);
  };

  programs.fish.shellAliases = {
    n8n = "cat ~/.n8n/init-data.sh > ~/.n8n/_init-data.sh; chmod +x ~/.n8n/_init-data.sh; docker compose -f ~/.n8n/docker-compose.yml";
    n8n-exec = "docker exec -it $(docker ps -f name=n8n-n8n-1 --format json | jq -r .ID) /bin/sh";
  };
}
