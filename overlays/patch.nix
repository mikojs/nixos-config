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

  # FIXME: those are in unstable nixpkgs
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

  somo = rustPlatform.buildRustPackage (finalAttrs: {
    pname = "somo";
    version = "1.1.0";

    src = fetchFromGitHub {
      owner = "theopfr";
      repo = "somo";
      tag = "v${finalAttrs.version}";
      hash = "sha256-HUTaBSy3FemAQH1aKZYTJnUWiq0bU/H6c5Gz3yamPiA=";
    };

    cargoHash = "sha256-e3NrEfbWz6h9q4TJnn8jnRmMJbeaEc4Yo3hFlaRLzzQ=";

    nativeBuildInputs = [
      installShellFiles
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      # Avoids "couldn't find any valid shared libraries matching: ['libclang.dylib']" error on darwin in sandbox mode.
      rustPlatform.bindgenHook
    ];

    postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
      installShellCompletion --cmd somo \
        --bash <("$out/bin/somo" generate-completions bash) \
        --zsh <("$out/bin/somo" generate-completions zsh) \
        --fish <("$out/bin/somo" generate-completions fish)
    '';

    nativeInstallCheckInputs = [
      versionCheckHook
    ];
    doInstallCheck = true;
    versionCheckProgramArg = "--version";

    passthru = {
      updateScript = nix-update-script { };
    };

    meta = {
      description = "Socket and port monitoring tool";
      homepage = "https://github.com/theopfr/somo";
      changelog = "https://github.com/theopfr/somo/blob/v${finalAttrs.version}/CHANGELOG.md";
      license = lib.licenses.mit;
      platforms = with lib.platforms; linux ++ darwin;
      maintainers = with lib.maintainers; [
        kachick
      ];
      mainProgram = "somo";
    };
  });

  avante-nvim =
    let
      version = "0.0.27-unstable-2025-08-14";
      src = fetchFromGitHub {
        owner = "yetone";
        repo = "avante.nvim";
        rev = "be0937a459624ce1170f158f9d8660d0ade47eb4";
        hash = "sha256-1NzzyWW2Tp91wa+Ujv2cDTv/Cb/HgA6LiDuwxVWdJwU=";
      };
      avante-nvim-lib = rustPlatform.buildRustPackage {
        pname = "avante-nvim-lib";
        inherit version src;

        cargoHash = "sha256-pTWCT2s820mjnfTscFnoSKC37RE7DAPKxP71QuM+JXQ=";

        nativeBuildInputs = [
          pkg-config
          makeWrapper
          pkgs.perl
        ];

        buildInputs = [
          openssl
        ];

        buildFeatures = [ "luajit" ];

        checkFlags = [
          # Disabled because they access the network.
          "--skip=test_hf"
          "--skip=test_public_url"
          "--skip=test_roundtrip"
          "--skip=test_fetch_md"
        ];
      };
    in
    vimUtils.buildVimPlugin {
      pname = "avante.nvim";
      inherit version src;

      dependencies = with vimPlugins; [
        dressing-nvim
        img-clip-nvim
        nui-nvim
        nvim-treesitter
        plenary-nvim
      ];

      postInstall =
        let
          ext = stdenv.hostPlatform.extensions.sharedLibrary;
        in
        ''
          mkdir -p $out/build
          ln -s ${avante-nvim-lib}/lib/libavante_repo_map${ext} $out/build/avante_repo_map${ext}
          ln -s ${avante-nvim-lib}/lib/libavante_templates${ext} $out/build/avante_templates${ext}
          ln -s ${avante-nvim-lib}/lib/libavante_tokenizers${ext} $out/build/avante_tokenizers${ext}
          ln -s ${avante-nvim-lib}/lib/libavante_html2md${ext} $out/build/avante_html2md${ext}
        '';

      passthru = {
        updateScript = nix-update-script {
          extraArgs = [ "--version=branch" ];
          attrPath = "vimPlugins.avante-nvim.avante-nvim-lib";
        };

        # needed for the update script
        inherit avante-nvim-lib;
      };

      nvimSkipModules = [
        # Requires setup with corresponding provider
        "avante.providers.azure"
        "avante.providers.copilot"
        "avante.providers.gemini"
        "avante.providers.ollama"
        "avante.providers.vertex"
        "avante.providers.vertex_claude"
      ];

      meta = {
        description = "Neovim plugin designed to emulate the behaviour of the Cursor AI IDE";
        homepage = "https://github.com/yetone/avante.nvim";
        license = lib.licenses.asl20;
        maintainers = with lib.maintainers; [
          ttrei
          aarnphm
          jackcres
        ];
      };
    };

  gemini-cli = buildNpmPackage (finalAttrs: {
    pname = "gemini-cli";
    version = "0.1.18";

    src = fetchFromGitHub {
      owner = "google-gemini";
      repo = "gemini-cli";
      tag = "v${finalAttrs.version}";
      hash = "sha256-vO70olSAG6NaZjyERU22lc8MbVivyJFieGcy0xOErrc=";
    };

    patches = [
      (fetchpatch {
        url = "https://github.com/google-gemini/gemini-cli/pull/5336/commits/c1aef417d559237bf4d147c584449b74d6fbc1f8.patch";
        name = "restore-missing-dependencies-fields.patch";
        hash = "sha256-euRoLpbv075KIpYF9QPMba5FxG4+h/kxwLRetaay33s=";
      })
    ];

    npmDepsHash = "sha256-8dn0i2laR4LFZk/sFDdvblvrHSnraGcLl3WAthCOKc0=";

    preConfigure = ''
      mkdir -p packages/generated
      echo "export const GIT_COMMIT_INFO = { commitHash: '${finalAttrs.src.rev}' };" > packages/generated/git-commit.ts
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/{bin,share/gemini-cli}

      cp -r node_modules $out/share/gemini-cli/

      rm -f $out/share/gemini-cli/node_modules/@google/gemini-cli
      rm -f $out/share/gemini-cli/node_modules/@google/gemini-cli-core
      rm -f $out/share/gemini-cli/node_modules/@google/gemini-cli-test-utils
      rm -f $out/share/gemini-cli/node_modules/gemini-cli-vscode-ide-companion
      cp -r packages/cli $out/share/gemini-cli/node_modules/@google/gemini-cli
      cp -r packages/core $out/share/gemini-cli/node_modules/@google/gemini-cli-core

      ln -s $out/share/gemini-cli/node_modules/@google/gemini-cli/dist/index.js $out/bin/gemini
      runHook postInstall
    '';

    postInstall = ''
      chmod +x "$out/bin/gemini"
    '';

    passthru.updateScript = gitUpdater { };

    meta = {
      description = "AI agent that brings the power of Gemini directly into your terminal";
      homepage = "https://github.com/google-gemini/gemini-cli";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [ donteatoreo ];
      platforms = lib.platforms.all;
      mainProgram = "gemini";
    };
  });

  claude-code = import ./claude-code prev;
}
