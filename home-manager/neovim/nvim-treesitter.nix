{ pkgs
, languages
, ...
}: {
  home.packages = with pkgs; with builtins; [ ] ++ (if elem "c" languages then [ libgccjit ] else [ ]);

  programs.neovim.plugins = with pkgs.vimPlugins; [
    (nvim-treesitter.withPlugins (p: map (language: p."${language}") languages))

    {
      plugin = nvim-treesitter;
      config = ''
        lua << END
          require'nvim-treesitter.configs'.setup {
            textobjects = {
              select = {
                enable = true,
                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                },
              },

              move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  ["]m"] = "@function.outer",
                  ["]]"] = "@class.outer",
                },
                goto_next_end = {
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer",
                },
                goto_previous_start = {
                  ["[m"] = "@function.outer",
                  ["[["] = "@class.outer",
                },
                goto_previous_end = {
                  ["[M"] = "@function.outer",
                  ["[]"] = "@class.outer",
                },
              },
            },
          }
        END
      '';
    }
  ];
}
