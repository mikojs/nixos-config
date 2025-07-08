final: prev:
with prev;
with prev.vimUtils;
{
  vimPlugins = vimPlugins // {
    sqls-nvim = buildVimPlugin {
      pname = "sqls.nvim";
      version = "2025-03-27";
      src = fetchFromGitHub {
        owner = "nanotee";
        repo = "sqls.nvim";
        rev = "af156c2c7d6bca6384d0881f4a3d6de4cedcd482";
        sha256 = "sha256-D5k8rAwC1vpdbm0MBsJ9vc2vs2Mq3e8ZTtHDycw2cYs=";
      };
      meta.homepage = "https://github.com/nanotee/sqls.nvim/";
      meta.hydraPlatforms = [ ];
    };

    vim-rzip = buildVimPlugin {
      pname = "vim-rzip";
      version = "2023-02-18";
      src = fetchFromGitHub {
        owner = "lbrayner";
        repo = "vim-rzip";
        rev = "f65400fed27b27c7cff7ef8d428c4e5ff749bf28";
        sha256 = "sha256-xy7rNqDVqlGapKClrP5BhfOORlMzHOQ8oIc8FdZT/AE=";
      };
      meta.homepage = "https://github.com/lbrayner/vim-rzip";
      meta.hydraPlatforms = [ ];
    };
  };
}
