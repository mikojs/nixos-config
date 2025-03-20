# Neovim

The following Neovim plugins are used in this NixOS configuration.

## Tokyonight.nvim

Tokyonight.nvim is a color scheme for Neovim.

- [Configuration](./home-manager/neovim/tokyonight-nvim.nix)
- [Repository](https://github.com/folke/tokyonight.nvim)

## Lualine.nvim

Lualine.nvim is a statusline plugin for Neovim.

- [Configuration](./home-manager/neovim/lualine-nvim.nix)
- [Repository](https://github.com/nvim-lualine/lualine.nvim)


## nvim-treesitter

nvim-treesitter is a syntax highlighting plugin for Neovim.

- [Configuration](./home-manager/neovim/nvim-treesitter.nix)
- [Repository](https://github.com/nvim-treesitter/nvim-treesitter)

## nvim-cmp

nvim-cmp is a completion plugin for Neovim.

- [Configuration](./home-manager/neovim/nvim-cmp.nix)
- [Repository](https://github.com/hrsh7th/nvim-cmp)
- Keybindings

    | Description      | Key          |
    | ---              | ---          |
    | LSP              | `<leader>l`  |
    | Show information | `<leader>li` |
    | Show diagnostics | `<leader>ld` |
    | Rename           | `<leader>lr` |

    | Description      | Key          |
    | ---              | ---          |
    | Snippet          |              |
    | Scroll up        | `<C-b>`      |
    | Scroll down      | `<C-f>`      |
    | Complete         | `<C-Space>`  |
    | Abort            | `<C-e>`      |
    | Confirm          | `<CR>`       |
    | Select           | `<Tab>`      |

## Which-key.nvim

Which-key.nvim is a plugin for Neovim that shows a popup with available keybindings.

- [Configuration](./home-manager/neovim/which-key-nvim.nix)
- [Repository](https://github.com/folke/which-key.nvim)


## Telescope.nvim

Telescope.nvim is a fuzzy finder for Neovim.

- [Configuration](./home-manager/neovim/telescope-nvim.nix)
- [Repository](https://github.com/nvim-telescope/telescope.nvim)
- Keybindings

    | Description           | Key          |
    | ---                   | ---          |
    | Find files            | `<leader>F`  |
    | Search with grep      | `<leader>G`  |
    | Show buffers          | `<leader>B`  |
    | Help                  | `<leader>?`  |
    | Show keymaps          | `<leader>K`  |
    | Show diagnostics      | `<leader>D`  |

    | Description           | Key          |
    | ---                   | ---          |
    | Git                   | `<leader>g`  |
    | Show git status       | `<leader>gT` |
    | Show git stash        | `<leader>gA` |
    | Show git commit       | `<leader>gC` |

    | Description           | Key          |
    | ---                   | ---          |
    | Lsp                   | `<leader>l`  |
    | Go to definition      | `<leader>lD` |
    | Go to type definition | `<leader>lT` |
    | Show references       | `<leader>lR` |
    | Go to implementation  | `<leader>lI` |
    | Show document symbols | `<leader>lS` |

## Gitsigns.nvim

Gitsigns.nvim is a git signs plugin for Neovim.

- [Configuration](./home-manager/neovim/gitsigns-nvim.nix)
- [Repository](https://github.com/lewis6991/gitsigns.nvim)
- Keybindings

    | Description            | Key          |
    | ---                    | ---          |
    | Next git hunk          | `]c`         |
    | Previous git hunk      | `[c`         |

    | Description            | Key          |
    | ---                    | ---          |
    | Git                    | `<leader>g`  |
    | Stage git hunk         | `<leader>gs` |
    | Reset git hunk         | `<leader>gr` |
    | Stage git buffer       | `<leader>gS` |
    | Undo stage git hunk    | `<leader>gu` |
    | Reset git buffer       | `<leader>gR` |
    | Preview git hunk       | `<leader>gp` |
    | Diff this              | `<leader>gd` |
    | Diff this (cached)     | `<leader>gD` |
    | Blame line             | `<leader>gb` |
    | Toggle deleted         | `<leader>gt` |

## Toggleterm.nvim

Toggleterm.nvim is a terminal plugin for Neovim.

- [Configuration](./home-manager/neovim/toggleterm-nvim.nix)
- [Repository](https://github.com/akinsho/toggleterm.nvim)
- Keybindings

    | Description                | Key          |
    | ---                        | ---          |
    | Terminal                   | `<leader>T`  |
    | Toggle terminal            | `<leader>Tn` |
    | Toggle vertical terminal   | `<leader>Tv` |
    | Toggle horizontal terminal | `<leader>Th` |
    | Toggle tab terminal        | `<leader>Tt` |
    | Send selection to terminal | `<leader>s`  |

## Barbar.nvim

Barbar.nvim is a tabline plugin for Neovim.

- [Configuration](./home-manager/neovim/barbar-nvim.nix)
- [Repository](https://github.com/romgrk/barbar.nvim)
- Keybindings

    | Description                          | Key           |
    | ---                                  | ---           |
    | Tab                                  | `<leader>t`   |
    | Go to previous tab                   | `<A-[>`       |
    | Go to next tab                       | `<A-]>`       |
    | Move tab left                        | `<A-,>`       |
    | Move tab right                       | `<A-.>`       |
    | Go to tab (1-9)                      | `<A-(1-9)>`   |
    | Go to last tab                       | `<A-0>`       |
    | Sort                                 | `<leader>ts`  |
    | Sort by buffer number                | `<leader>tsb` |
    | Sort by name                         | `<leader>tsn` |
    | Sort by directory                    | `<leader>tsd` |
    | Sort by location                     | `<leader>tsl` |
    | Sort by window number                | `<leader>tsw` |
    | Close all tabs but current or pinned | `<leader>to`  |
    | Close left other tabs                | `<leader>tl`  |
    | Close right other tabs               | `<leader>tr`  |

## Presistence.nvim

Presistence.nvim is a session plugin for Neovim.

- [Configuration](./home-manager/neovim/presistence-nvim.nix)
- [Repository](https://github.com/folke/persistence.nvim)
- Keybindings

    | Description            | Key          |
    | ---                    | ---          |
    | Session                | `<leader>s`  |
    | Load last session      | `<leader>sl` |
    | Save auto-save session | `<leader>ss` |

## Todo-comments.nvim

Todo-comments.nvim is a todo comments plugin for Neovim.

- [Configuration](./home-manager/neovim/todo-comments-nvim.nix)
- [Repository](https://github.com/folke/todo-comments.nvim)
- keybindings

    | Description | Key          |
    | ---         | ---          |
    | Show TODOs  | `<leader>O`  |

## Mini.nvim

Mini.nvim is a plugin for Neovim that provides small utilities.

- [Configuration](./home-manager/neovim/mini-nvim.nix)
- [Repository](https://github.com/echasnovski/mini.nvim)

### Mini.icons

Mini.icons is an icon provider.

- [Repository](https://github.com/echasnovski/mini.icons)

### Mini.notify

Mini.notify is a notification plugin for Neovim.

- [Repository](https://github.com/echasnovski/mini.notify)


### Mini.trailspace

Mini.trailspace is a trailing space highlighter.

- [Repository](https://github.com/echasnovski/mini.trailspace)


### Mini.files

Mini.files is a file explorer for Neovim.

- [Repository](https://github.com/echasnovski/mini.files)
- Keybindings

    | Description           | Key          |
    | ---                   | ---          |
    | Manipulate files      | `<leader>f`  |
    | Close explorer        | `q`          |
    | Go into directory     | `l`          |
    | Go out of directory   | `h`          |
    | Reset file explorer   | `<BS>`       |
    | Sync file explorer    | `=`          |

### Mini.ai

Mini.ai is a textobject plugin for Neovim.

- [Repository](https://github.com/echasnovski/mini.ai)
- Keybindings

    | Description                     | Key          |
    | ---                             | ---          |
    | Find arround textobject         | `a`          |
    | Find inside textobject          | `i`          |
    | Go to left arround textobject   | `g[`         |
    | Go to right arround textobject  | `g]`         |

### Mini.surround

Mini.surround is a surround plugin for Neovim.

- [Repository](https://github.com/echasnovski/mini.surround)
- Keybindings

    | Description                                | Key          |
    | ---                                        | ---          |
    | Add surrounding in Normal and Visual modes | `sa`         |
    | Delete surrounding                         | `sd`         |
    | Find surrounding (to the right)            | `sf`         |
    | Find surrounding (to the left)             | `sF`         |
    | Highlight surrounding                      | `sh`         |
    | Replace surrounding                        | `sr`         |
    | Update n_lines                             | `sn`         |
    | Suffix to search with "prev" method        | `l`          |
    | Suffix to search with "next" method        | `n`          |

### Mini.bracketed

Go forward/backward with square brackets

- [Repository](https://github.com/echasnovski/mini.bracketed)
- Keybindings

    | Description                                       | Key                   |
    | ---                                               | ---                   |
    | Buffer                                            | `[B` `[b` `]b` `]B`   |
    | Comment block                                     | `[C` `[c` `]c` `]C`   |
    | Conflict marker                                   | `[X` `[x` `]x` `]X`   |
    | Diagnostic                                        | `[D` `[d` `]d` `]D`   |
    | File on disk                                      | `[F` `[f` `]f` `]F`   |
    | Indent change                                     | `[I` `[i` `]i` `]I`   |
    | Jump from jumplist                                | `[J` `[j` `]j` `]J`   |
    | Location from location list                       | `[L` `[l` `]l` `]L`   |
    | Old files                                         | `[O` `[o` `]o` `]O`   |
    | Quickfix entry from quickfix list                 | `[Q` `[q` `]q` `]Q`   |
    | Tree-sitter node and parents                      | `[T` `[t` `]t` `]T`   |
    | Undo states from specially tracked linear history | `[U` `[u` `]u` `]U`   |
    | Window in current tab                             | `[W` `[w` `]w` `]W`   |
    | Yank selection replacing latest put region        | `[Y` `[y` `]y` `]Y`   |

### Mini.comment

Comment lines

- [Repository](https://github.com/echasnovski/mini.comment)
- Keybindings

    | Description                    | Key          |
    | ---                            | ---          |
    | Toggle comment                 | `gc`         |
    | Toggle comment on current line | `gcc`        |


### Mini.move

Move any selection in any direction

- [Repository](https://github.com/echasnovski/mini.move)
- Keybindings

    | Description                    | Key          |
    | ---                            | ---          |
    | Move left                        | `<M-h>`      |
    | Move right                       | `<M-l>`      |
    | Move down                        | `<M-j>`      |
    | Move up                          | `<M-k>`      |

### Mini.align

Align text interactively

- [Repository](https://github.com/echasnovski/mini.align)
- Keybindings

    | Description                                 | Key          |
    | ---                                         | ---          |
    | Align text interactively                    | `ga`         |
    | Align text interactively with preview       | `gA`         |

    | Description                    | Key          |
    | ---                            | ---          |
    | Enter split pattern            | `s`          |
    | Choose justify side            | `j`          |
    | Enter merge delimiter          | `m`          |
    | Enhanced setup for '='         | `=`          |
    | Enhanced setup for ','         | `,`          |
    | Enhanced setup for '\|'        | `\|`         |
    | Enhanced setup for ' '         | ` `          |

## Conform.nvim

Conform.nvim is a formatter plugin for Neovim.

- [Configuration](./home-manager/neovim/conform-nvim/default.nix)
- [Repository](https://github.com/stevearc/conform.nvim)
- Support languages
    - `nix`: [nixfmt](https://github.com/NixOS/nixfmt)
    - `nodejs`: [prettier](https://github.com/prettier/prettier)
    - `postgresql`: [pgformatter](https://github.com/darold/pgformatter)
    - `rust`: [rustfmt](https://github.com/rust-lang/rustfmt)

## Codeium.nvim

Codeium.nvim is a plugin for Neovim that provides AI code completion.

- [Configuration](./home-manager/neovim/codeium-nvim.nix)
- [Repository](https://github.com/Exafunction/codeium.vim)
