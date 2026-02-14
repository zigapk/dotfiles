{
  pkgs,
  lib,
  ...
}: {
  enable = true;
  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    backspace = "2";
    showcmd = true;
    laststatus = 2;
    autowrite = true;
    cursorline = false;
    autoread = false;
    tabstop = 2;
    shiftround = true;
    expandtab = true;
    scrolloff = 10;
    clipboard = "unnamedplus";
    ignorecase = true;
  };
  autoCmd = [
    # Vertically center when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }
  ];
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  keymaps = [
    {
      action = "<Esc>";
      key = "jj";
      mode = "i";
      options = {
        desc = "Escape insert mode";
        noremap = true;
      };
    }
    {
      action = "<cmd>lua Snacks.picker.files()<cr>";
      key = "<leader>sf";
      options = {
        desc = "File picker";
      };
    }
    {
      action = "<cmd>lua Snacks.picker.grep()<cr>";
      key = "<leader>sg";
      options = {
        desc = "Search grep";
      };
    }
    {
      action = ":m '>+1<CR>gv=gv";
      key = "J";
      mode = "v";
      options = {
        desc = "Move one line down";
      };
    }
    {
      action = ":m '<-2<CR>gv=gv";
      key = "K";
      mode = "v";
      options = {
        desc = "Move one line up";
      };
    }
    {
      action = "<cmd>lua Snacks.explorer.reveal()<cr>";
      key = "<leader>ex";
    }
    {
      action = "<cmd>Neotree close<CR>";
      key = "<leader>ec";
    }
    {
      action = "<cmd>lua vim.lsp.buf.definition()<cr>";
      key = "<leader>gd";
      options = {
        desc = "Go to definition";
      };
    }
    {
      action = "<cmd> lua require('telescope.builtin').lsp_references()<cr>";
      key = "<leader>gr";
      options = {
        desc = "Go to references";
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
      key = "<leader>gt";
      options = {
        desc = "Go to type definition";
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.hover()<cr>";
      key = "<leader>gh";
      options = {
        desc = "Hover documentation";
      };
    }
    {
      action = "<cmd>Neotree float git_status<CR>";
      key = "<leader>gs";
    }
    {
      action = "<cmd>lua Snacks.lazygit()<cr>";
      key = "<leader>gl";
      options = {
        desc = "Lazygit";
      };
    }
    {
      action = "<cmd>lua Snacks.gitbrowse()<cr>";
      key = "<leader>gb";
      options = {
        desc = "Git browse";
      };
    }
    {
      action = "<cmd>Gitsigns preview_hunk<CR>";
      key = "<leader>gp";
      options = {
        desc = "Git preview hunk";
        noremap = true;
      };
    }
    {
      action = "<cmd>Commentary<CR>";
      key = "<leader>/";
    }
    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }

    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }

    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }

    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }
    # Code actions
    {
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
      key = "<leader>ca";
      mode = "n";
      options = {
        desc = "Code action";
      };
    }
    # Format file
    {
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
      key = "<leader>cf";
      mode = "n";
      options = {
        desc = "Format file/code";
      };
    }
    # Show problems diagnostics
    {
      action = "<cmd>lua require(\"trouble\").toggle('diagnostics')<cr>";
      key = "<leader>cd";
      options = {
        desc = "Show code diagnostics";
      };
    }
    # Split shortcuts
    {
      action = "<cmd>vsplit<cr>";
      key = "<leader>sv";
      options = {
        desc = "Split vertically";
      };
    }
    {
      action = "<cmd>split<cr>";
      key = "<leader>sh";
      options = {
        desc = "Split horizontally";
      };
    }
    # Delete buffers in various ways
    {
      action = "<cmd>lua Snacks.bufdelete.delete()<cr>";
      key = "<leader>bdc";
      options = {
        desc = "Delete current buffer";
      };
    }
    {
      action = "<cmd>lua Snacks.bufdelete.delete({force = true})<cr>";
      key = "<leader>bdf";
      options = {
        desc = "Force delete current buffer";
      };
    }
    {
      action = "<cmd>lua Snacks.bufdelete.all()<cr>";
      key = "<leader>bda";
      options = {
        desc = "Delete all buffers";
      };
    }
    {
      action = "<cmd>lua Snacks.bufdelete.other()<cr>";
      key = "<leader>bdo";
      options = {
        desc = "Delete other buffers";
      };
    }
    {
      action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
      key = "<leader>en";
      options = {
        desc = "Error next";
      };
    }
    {
      action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
      key = "<leader>ep";
      options = {
        desc = "Error prev";
      };
    }
    {
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      key = "<leader>ev";
      options = {
        desc = "Error view";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>os";
      action.__raw = ''
        function()
          require('opencode').select()
        end
      '';
      options = {
        desc = "opencode select";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>ot";
      action = "<cmd>lua require('opencode').toggle()<cr>";
      options = {
        desc = "opencode toggle";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>o+";
      action = "<cmd>lua require('opencode').prompt('@this')<cr>";
      options = {
        desc = "opencode add this";
      };
    }
  ];
  colorschemes.catppuccin.enable = true;
  plugins = {
    lualine.enable = true;
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-]>";
            node_incremental = "<C-]>";
            scope_incremental = false;
            node_decremental = "<C-[>";
          };
        };
        ensure_installed = [
          "bash"
          "diff"
          "html"
          "css"
          "javascript"
          "typescript"
          "terraform"
          "tsx"
          "json"
          "yaml"
          "markdown"
          "toml"
          "python"
          "rust"
          "lua"
          "vim"
          "dockerfile"
          "make"
          "vimdoc"
          "markdown_inline"
          "java"
        ];
      };
    };
    treesitter-context.enable = true;
    treesitter-refactor = {
      enable = true;
      settings.smart_rename = {
        enable = true;
        keymaps = {
          smart_rename = "<leader>rn";
        };
      };
    };
    web-devicons.enable = true;
    which-key.enable = true;
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
    nvim-autopairs.enable = true;
    bufferline = {
      enable = true;
      settings.options = {
        diagnostics = "nvim_lsp";
      };
    };
    dressing.enable = true;
    trouble.enable = true;
    conform-nvim = {
      enable = true;
      settings = {
        formatters = {
          biome = {
            package = pkgs.biome;
            command = lib.getExe pkgs.biome;
          };
          stylua = {
            package = pkgs.stylua;
          };
          nixfmt = {
            package = pkgs.nixfmt-rfc-style;
          };
          black = {
            package = pkgs.black;
          };
          shfmt = {
            package = pkgs.shfmt;
          };
        };
        # This will format on save, replacing your autocmd
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
        # Define which formatter to use for which filetype
        formatters_by_ft = {
          typescript = ["biome"];
          typescriptreact = ["biome"];
          javascript = ["biome"];
          javascriptreact = ["biome"];
          json = ["biome"];
          jsonc = ["biome"];

          # You can add your other formatters from none-ls here
          lua = ["stylua"];
          nix = ["nixfmt"];
          python = ["black"];
          sh = ["shfmt"];
        };
      };
    };
    gitsigns = {
      enable = true;
      settings.current_line_blame = true;
    };
    tmux-navigator.enable = true;
    opencode = {
      enable = true;
      # TODO: autoread
    };
    markdown-preview = {
      enable = true;
      settings.theme = "dark";
    };
    noice.enable = true;

    snacks = {
      enable = true;
      settings = {
        gitbrowse.enable = true;
        scroll.enable = true;
        bigfile.enable = true;
        bufdelete.enable = true;
        input.enable = true;
        indent.enable = true;
        lazygit.enable = true;
        terminal.enable = true;
        explorer = {
          enable = true;
          trash = true;
        };
        scope = {
          enable = true;
          scope.min_size = 7;
        };
        notifier.enable = true;
        notify.enable = true;
        git.enable = true;
        words.enable = true;
        dim.enable = false;
        picker.enable = true;
        dashboard = {
          enable = true;
          sections = [
            {section = "header";}
            {
              icon = " ";
              title = "Keymaps";
              section = "keys";
              indent = 2;
              padding = 1;
            }
            {
              icon = " ";
              title = "Recent Files";
              section = "recent_files";
              indent = 2;
              padding = 1;
            }
            {
              icon = " ";
              title = "Projects";
              section = "projects";
              indent = 2;
              padding = 1;
            }
            {
              icon = " ";
              title = "Git Status";
              section = "terminal";
              enabled.__raw = ''
                function()
                  return Snacks.git.get_root() ~= nil
                end
              '';
              cmd = "git status --short --branch --renames";
              height = 5;
              padding = 1;
              ttl = 5 * 60;
              indent = 3;
            }
          ];
          terminal.enable = true;
          notifier.enable = true;
          scratch.enable = true;
          scope.enable = true;
          quickfile.enable = true;
          gitbrowse.enable = true;
          lazygit.enable = true;
        };
      };
    };
    mini = {
      enable = true;
      modules = {
        ai = {};
        comment = {};
        # TODO: completion instead of cmp
        # TODO: move does not work
        move = {};
      };
    };
    # lazygit.enable = true;

    render-markdown = {
      enable = true;
      settings = {
        enabled = true; # This lets you set whether the plugin should render documents from the start or not. Useful if you want to use a command like RenderMarkdown enable to start rendering documents rather than having it on by default.
        bullet = {
          icons = [
            "•"
          ];
          right_pad = 1;
        };
        code = {
          above = " ";
          below = " ";
          border = "thick";
          language_pad = 2;
          left_pad = 2;
          position = "right";
          right_pad = 2;
          sign = false;
          width = "block";
        };
        heading = {
          border = true;
          icons = [
            "1 "
            "2 "
            "3 "
            "4 "
            "5 "
            "6 "
          ];
          position = "inline";
          sign = false;
          width = "full";
        };
        render_modes = true;
        signs = {
          enabled = false;
        };
      };
    };

    image = {
      enable = true;
      settings = {
        backend = "kitty";
        hijackFilePatterns = [
          "*.png"
          "*.jpg"
          "*.jpeg"
          "*.gif"
          "*.webp"
        ];
        tmux_show_only_in_active_window = true;
        max_height_window_percentage = 25;
        integrations = {
          markdown = {
            enabled = true;
            downloadRemoteImages = true;
            filetypes = [
              "markdown"
              "vimwiki"
              "mdx"
            ];
          };
        };
      };
    };

    undotree = {
      enable = true;
      settings = {
        autoOpenDiff = true;
        focusOnToggle = true;
      };
    };

    todo-comments.enable = true;

    nix.enable = true;

    # Language server
    lsp = {
      enable = true;
      servers = {
        biome = {
          enable = true;
          package = pkgs.biome;
          cmd = [(lib.getExe pkgs.biome) "lsp-proxy"];
        };
        ts_ls.enable = true;
        cssls.enable = true; # CSS
        html.enable = true; # HTML
        pyright.enable = true; # Python
        marksman.enable = true; # Markdown
        nil_ls = {
          enable = true;
          settings = {
            nil = {
              externalLinters = {
                statix = {
                  enable = true;
                };
                deadnix = {
                  enable = true;
                };
              };
            };
          };
        }; # Nix
        dockerls.enable = true; # Docker
        bashls.enable = true; # Bash
        yamlls.enable = true; # YAML
        denols = {
          enable = false;
          settings = {
            lint = true;
            suggest = {
              imports = {
                hosts = {
                  "https://deno.land" = true;
                  "https://cdn.nest.land" = true;
                  "https://crux.land" = true;
                };
              };
            };
          };
          extraOptions = {
            single_file_support = false;
            # We replace the simple string with a raw function for debugging
            rootDir = {
              __raw = ''
                function(fname)
                 local util = require("lspconfig.util")
                 -- 1. Define the pattern we're looking for
                 local pattern = util.root_pattern("deno.json", "deno.jsonc")
                 -- 2. Search for the pattern starting from the current file
                 local root = pattern(fname)

                 -- 3. Check the result and notify us
                 if root then
                  vim.notify("[Debug] denols: Found root at: " .. root .. ". Starting denols.", vim.log.levels.INFO)
                 else
                  vim.notify("[Debug] denols: No deno.json(c) found. NOT starting denols.", vim.log.levels.WARN)
                 end

                 -- 4. Return the result
                 return root
                end
              '';
            };
          };
        };
        ltex = {
          enable = true;
          settings = {
            enabled = [
              "html"
              "latex"
              "markdown"
              "text"
              "tex"
              "gitcommit"
            ];
            completionEnabled = true;
            language = "en-US sl-SI";
          };
        };
        gopls = {
          # Golang
          enable = true;
          autostart = true;
        };

        lua_ls = {
          # Lua
          enable = true;
          settings.telemetry.enable = false;
        };

        # Rust
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
      };
    };

    cmp-emoji = {
      enable = true;
    };

    cmp = {
      enable = true;
      settings = {
        completion = {
          completeopt = "menu,menuone,noinsert";
        };
        autoEnableSources = true;
        experimental = {
          ghost_text = true;
        };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet = {
          expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
        };
        formatting = {
          fields = [
            "kind"
            "abbr"
            "menu"
          ];
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "emoji";}
          {
            name = "path"; # file system paths
            keywordLength = 3;
          }
          {
            name = "luasnip"; # snippets
            keywordLength = 3;
          }
        ];

        window = {
          completion = {
            border = "solid";
          };
          documentation = {
            border = "solid";
          };
        };

        mapping = {
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-h>" = "cmp.mapping.close()";
          "<C-l>" = "cmp.mapping(cmp.mapping.confirm({ select = true }), {'i', 's'})";
        };
      };
    };
    cmp-nvim-lsp = {
      enable = true; # LSP
    };
    cmp-buffer = {
      enable = true;
    };
    cmp-path = {
      enable = true; # file system paths
    };
    cmp_luasnip = {
      enable = true; # snippets
    };
    cmp-cmdline = {
      enable = true; # autocomplete for cmdline
    };

    lspkind = {
      enable = true;
      settings = {
        symbolMap = {
          Copilot = "";
        };
        extraOptions = {
          maxwidth = 50;
          ellipsis_char = "...";
        };
      };
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
    supermaven-nvim
    vim-visual-multi
  ];
  extraConfigLua = ''
    require("supermaven-nvim").setup({})
  '';
  extraPackages = [
    pkgs.nodePackages.typescript
    pkgs.stylua
    pkgs.nixfmt-rfc-style
    pkgs.black
    pkgs.shfmt
    pkgs.biome
    pkgs.nil
    pkgs.statix
    pkgs.deadnix
  ];
}
