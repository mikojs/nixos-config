{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "docker-sbx";
        docs = ''
          # Docker SBX

          Docker Sandboxes delivers isolated environments with restricted
          filesystem, network, and tool access, enabling autonomous agent
          operation while protecting your system and data.

          [Website](https://docs.docker.com/reference/cli/sbx/)

          ## Gotcha

          - The installed binary is `sbx`, not `docker-sbx`.
        '';
      }
    ];

    packages = [
      pkgs.docker-sbx
    ];
  };
}
