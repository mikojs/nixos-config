{
  vimUtils,
  fetchFromGitHub,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "sqls.nvim";
  version = "2025-09-03";
  src = fetchFromGitHub {
    owner = "nanotee";
    repo = "sqls.nvim";
    rev = "bfb7b4090268f6163c408577070da4cc9d7450fd";
    sha256 = "sha256-PLt4SjPBgTtxAghwffsNICQ0b5AQRrdCrZ7tEHccXIc=";
  };
  meta.homepage = "https://github.com/nanotee/sqls.nvim/";
  meta.hydraPlatforms = [ ];
}
