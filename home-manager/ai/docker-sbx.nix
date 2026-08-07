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

          Safe environments for agents. Docker Sandboxes delivers isolated
          environments with restricted filesystem, network, and tool access,
          enabling autonomous agent operation while protecting your system and data.

          The main program is `sbx`.

          [Repository](https://docs.docker.com/reference/cli/sbx/)
        '';
      }
    ];

    packages = [
      pkgs.docker-sbx
    ];
  };
}
