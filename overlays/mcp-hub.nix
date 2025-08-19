inputs: final: prev:
with prev;
with prev.vimUtils;
{
  mcp-hub = inputs.mcp-hub.packages."${system}".default;
  vimPlugins = vimPlugins // {
    mcphub-nvim = inputs.mcphub-nvim.packages."${system}".default;
  };
}
