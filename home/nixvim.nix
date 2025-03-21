{ pkgs, ... }: {
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
      action = "<cmd>Neotree filesystem reveal left<cr>";
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
      action = "<cmd>LazyGit<CR>";
      key = "<leader>gl";
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
  ];
  colorschemes.catppuccin.enable = true;
  plugins = {
    lualine.enable = true;
    telescope = {
      enable = true;
      keymaps = {
        "<leader>sf" = "find_files";
        "<leader>sg" = "live_grep";
      };
      settings = {
        defaults = {
          file_ignore_patterns = [
            "^node_modules/"
            "^.git/"
            "%.obj$"
            "%.o$"
            "%.a$"
            "%.bin$"
            "%.dll$"
            "%.so$"
            "%.tar.gz$"
            "%.zip$"
            "%.iso$"
          ];
          prompt_prefix = "   ";
          dynamic_preview_title = true;
          path_display = [ "truncate" ];
          scroll_strategy = "cycle";
          file_browser = {
            depth = 1;
            group_empty = true;
            hidden = true;
            respect_gitignore = false;
          };

          vimgrep_arguments = [
            "rg"
            "--color"
            "never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--hidden"
            "-g"
            "!.git'"
          ];
        };
        find_files = {
          find_command = [
            "rg"
            "--files"
            "--color"

            "never"
            "--hidden"
            "--smart-case"
            "-g"
            "!.git"
          ];
        };
      };
    };
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
      smartRename = {
        enable = true;
        keymaps = {
          smartRename = "<leader>rn";
        };
      };
    };
    tailwind-tools.enable = true;
    neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      sortCaseInsensitive = true;

      window = {
        mappings = {
          "<C-r>" = "openInExplorer";
        };
      };

      extraOptions.filesystem = {
        commands = {
          openInExplorer.__raw = ''
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              -- macOs: open file in default application in the background.
              vim.fn.jobstart({ "open", "-R", path }, { detach = true })
              -- Linux: open file in default application
              vim.fn.jobstart({ "xdg-open", path }, { detach = true })
            end
          '';
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
    none-ls = {
      enable = true;
      settings = {
        cmd = [ "bash -c nvim" ];
        debug = true;
      };
      sources = {
        code_actions = {
          statix.enable = true;
          gitsigns.enable = true;
        };
        diagnostics = {
          statix.enable = true;
          deadnix.enable = true;
          pylint.enable = true;
          checkstyle.enable = true;
        };
        formatting = {
          alejandra.enable = true;
          stylua.enable = true;
          shfmt.enable = true;
          nixpkgs_fmt.enable = true;
          google_java_format.enable = false;
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
          black = {
            enable = true;
            settings = ''
              {
                extra_args = { "--fast" },
              }
            '';
          };
        };
        completion = {
          luasnip.enable = true;
          spell.enable = true;
        };
      };
    };
    gitsigns = {
      enable = true;
      settings.current_line_blame = true;
    };
    tmux-navigator.enable = true;
    # TODO:
    #   - ai chat
    #   - go to next/previous error
    #   - view entie errors

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
        scope = {
          enable = true;
          scope.min_size = 7;
        };
        notifier.enable = true;
        notify.enable = true;
        git.enable = true;
        words.enable = true;
        dim.enable = false;
        dashboard = {
          enable = true;
          sections = [
            { section = "header"; }
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
        ai = { };
        comment = { };
        # TODO: completion instead of cmp
        # TODO: move does not work
        move = { };
      };
    };
    lazygit.enable = true;

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
      backend = "kitty";
      hijackFilePatterns = [
        "*.png"
        "*.jpg"
        "*.jpeg"
        "*.gif"
        "*.webp"
      ];
      maxHeightWindowPercentage = 25;
      tmuxShowOnlyInActiveWindow = true;
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

    undotree = {
      enable = true;
      settings = {
        autoOpenDiff = true;
        focusOnToggle = true;
      };
    };

    illuminate = {
      enable = true;
      underCursor = false;
      filetypesDenylist = [
        "Outline"
        "TelescopePrompt"
        "alpha"
        "harpoon"
        "reason"
      ];
    };

    todo-comments.enable = true;

    nix.enable = true;

    # Language server
    lsp = {
      enable = true;
      servers = {
        # Average webdev LSPs
        # ts-ls.enable = true; # TS/JS
        ts_ls.enable = true; # TS/JS
        cssls.enable = true; # CSS
        html.enable = true; # HTML
        astro.enable = true; # AstroJS
        phpactor.enable = true; # PHP
        svelte.enable = false; # Svelte
        vuels.enable = false; # Vue
        pyright.enable = true; # Python
        marksman.enable = true; # Markdown
        nil_ls.enable = true; # Nix
        dockerls.enable = true; # Docker
        bashls.enable = true; # Bash
        clangd.enable = true; # C/C++
        yamlls.enable = true; # YAML
        eslint.enable = true;
        biome.enable = true;
        ltex = {
          enable = true;
          settings = {
            enabled = [ "astro" "html" "latex" "markdown" "text" "tex" "gitcommit" ];
            completionEnabled = true;
            language = "en-US de-DE nl";
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
        experimental = { ghost_text = true; };
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
        formatting = { fields = [ "kind" "abbr" "menu" ]; };
        sources = [
          { name = "nvim_lsp"; }
          { name = "emoji"; }
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
          completion = { border = "solid"; };
          documentation = { border = "solid"; };
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
      symbolMap = {
        Copilot = "";
      };
      extraOptions = {
        maxwidth = 50;
        ellipsis_char = "...";
      };
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
    supermaven-nvim
    vim-visual-multi
  ];
  extraConfigLua = ''
    require("supermaven-nvim").setup({})

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        vim.lsp.buf.format()
      end,
    })
  '';
}
