final: prev:
with prev;
with prev.vimUtils;
{
  vimPlugins = vimPlugins // {
    crates-nvim = buildVimPlugin {
      pname = "crates.nvim";
      version = "2025-03-10";
      src = fetchFromGitHub {
        owner = "saecki";
        repo = "crates.nvim";
        rev = "403a0abef0e2aec12749a534dc468d6fd50c6741";
        sha256 = "19ix86nbww5vljinfwfpjkz806j7dzw4pgjyjya201jb0n22lrc6";
      };
      meta.homepage = "https://github.com/saecki/crates.nvim/";
      meta.hydraPlatforms = [ ];
    };

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
  };
}
