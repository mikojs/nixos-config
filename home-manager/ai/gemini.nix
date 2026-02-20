{
  pkgs,
  mcpServers,
  ...
}:
{
  home = {
    file = {
      ".docs/ai/gemini.md".text = ''
        # Gemini

        Gemini is an AI agent that brings the power of Gemini directly into your terminal.

        [Repository](https://github.com/google-gemini/gemini-cli)

      '';

      ".gemini/settings.json".text = ''
        {
          "general": {
            "disableUpdateNag": true
          },
          "security": {
            "auth": {
              "selectedType": "oauth-personal"
            }
          },
          "mcpServers": ${mcpServers}
        }
      '';
    };

    packages = with pkgs; [
      gemini-cli-bin
    ];
  };
}
