{
  lib,
  pkgs,
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
in
{
  fish-alias = [
    "- `n8n`: Run `n8n` server with docker compose."
  ];

  home.file = {
    ".n8n/init-data.sh".text =
      replaceStrings
        [
          "\${POSTGRES_USER}"
          "\${POSTGRES_PASSWORD}"
          "\${POSTGRES_DB}"
          "\${POSTGRES_NON_ROOT_USER}"
          "\${POSTGRES_NON_ROOT_PASSWORD}"
        ]
        [
          n8n.postgresUser
          n8n.postgresPassword
          n8n.postgresDb
          n8n.postgresNonRootUser
          n8n.postgresNonRootPassword
        ]
        (readFile ./init-data.sh);
    ".n8n/docker-compose.yml".source = (pkgs.formats.yaml { }).generate "docker-compose.yml" {
      volumes = {
        db_storage = null;
        n8n_storage = null;
      };

      services = {
        postgres = {
          image = "postgres:16";
          restart = "always";
          environment = [
            "POSTGRES_USER=${data.postgresUser}"
            "POSTGRES_PASSWORD=${data.postgresPassword}"
            "POSTGRES_DB=${data.postgresDb}"
            "POSTGRES_NON_ROOT_USER=${data.postgresNonRootUser}"
            "POSTGRES_NON_ROOT_PASSWORD=${data.postgresNonRootPassword}"
            "GENERIC_TIMEZONE=${data.genericTimezone}"
          ];
          volumes = [
            "db_storage:/var/lib/postgresql/data"
            "./_init-data.sh:/docker-entrypoint-initdb.d/init-data.sh"
          ];
          healthcheck = {
            test = [
              "CMD-SHELL"
              "pg_isready -h localhost -U ${data.postgresUser} -d ${data.postgresDb}"
            ];
            interval = "5s";
            timeout = "5s";
            retries = 10;
          };
        };

        n8n = {
          image = "docker.n8n.io/n8nio/n8n";
          restart = "always";
          environment = [
            "DB_TYPE=postgresdb"
            "DB_POSTGRESDB_HOST=postgres"
            "DB_POSTGRESDB_PORT=5432"
            "DB_POSTGRESDB_DATABASE=${data.postgresDb}"
            "DB_POSTGRESDB_USER=${data.postgresNonRootUser}"
            "DB_POSTGRESDB_PASSWORD=${data.postgresNonRootPassword}"
          ];
          ports = [ "5678:5678" ];
          links = [ "postgres" ];
          volumes = [
            "n8n_storage:/home/node/.n8n"
          ];
          depends_on.postgres.condition = "service_healthy";
        };
      };
    };
  };

  programs.fish.shellAliases = {
    n8n = "cat ~/.n8n/init-data.sh > ~/.n8n/_init-data.sh; chmod +x ~/.n8n/_init-data.sh; docker compose -f ~/.n8n/docker-compose.yml";
    n8n-exec = "docker exec -it $(docker ps -f name=n8n-n8n-1 --format json | jq -r .ID) /bin/sh";
  };
}
