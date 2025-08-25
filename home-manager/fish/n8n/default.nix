{
  ...
}:
with builtins;
{
  home.file = {
    "n8n/init-data.sh".text = readFile ./init-data.sh;
    "n8n/docker-compose.yml".text = readFile ./docker-compose.yml;
  };
}
