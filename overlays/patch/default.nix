final: prev:
with prev;
with prev.vimUtils;
{
  vimPlugins = vimPlugins // {
    vim-rzip = import ./vim-rzip.nix prev;
  };
}
