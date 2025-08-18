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

  # FIXME: 0.11.0 is in the unstable channel
  tabiew = rustPlatform.buildRustPackage rec {
    pname = "tabiew";
    version = "0.11.0";

    src = fetchFromGitHub {
      owner = "shshemi";
      repo = "tabiew";
      tag = "v${version}";
      hash = "sha256-ilZOXV9P3i2Gzcop9PRCHznorEdGMje097d9my0JVeU=";
    };

    cargoHash = "sha256-TYOsE0v2m0lTTK/+S82URDk4+ywu2nzzTQAi9pdBu2U=";

    nativeBuildInputs = [ installShellFiles ];

    outputs = [
      "out"
      "man"
    ];

    postInstall = ''
      installManPage target/manual/tabiew.1

      installShellCompletion \
        --bash target/completion/tw.bash \
        --zsh target/completion/_tw \
        --fish target/completion/tw.fish
    '';

    doCheck = false; # there are no tests

    meta = {
      description = "Lightweight, terminal-based application to view and query delimiter separated value formatted documents, such as CSV and TSV files";
      homepage = "https://github.com/shshemi/tabiew";
      changelog = "https://github.com/shshemi/tabiew/releases/tag/v${version}";
      license = lib.licenses.mit;
      mainProgram = "tw";
      maintainers = with lib.maintainers; [ anas ];
      platforms = with lib.platforms; unix ++ windows;
    };
  };
}
