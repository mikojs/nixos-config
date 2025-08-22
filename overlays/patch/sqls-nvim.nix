{
  vimUtils,
  fetchFromGitHub,
  ...
}:
vimUtils.buildVimPlugin {
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
}
