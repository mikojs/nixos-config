{
  vimUtils,
  fetchFromGitHub,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "vim-rzip";
  version = "2023-02-18";
  src = fetchFromGitHub {
    owner = "lbrayner";
    repo = "vim-rzip";
    rev = "f65400fed27b27c7cff7ef8d428c4e5ff749bf28";
    sha256 = "sha256-D5k8rAwC1vpdbm0MBsJ9vc2vs2Mq3e8ZTtHDycw2cYs=";
  };
  meta.homepage = "https://github.com/lbrayner/vim-rzip/";
  meta.hydraPlatforms = [ ];
}
