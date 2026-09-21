{
  pkgs,
  miko,
  ...
}:
{
  home = {
    file = miko.getDocs [
      {
        filePath = "ntn";
        docs = ''
          # Notion CLI

          Official Notion CLI, authenticated via `ntn login` (OAuth, credentials stored in the system keychain).

          [Website](https://developers.notion.com/cli/get-started/overview)
        '';
      }
    ];

    packages = [
      pkgs.ntn
    ];
  };
}
