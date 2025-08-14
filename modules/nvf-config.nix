{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = false;
        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = true;
          lspsaga.enable = true;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
          inlayHints.enable = true;
          mappings = {
            codeAction = "<leader>lta";
          };
        };
        diagnostics = {
          enable = true;
          nvim-lint.enable = true;
          config = {
            virtual_text = true;
            virtual_lines = false;
          };
        };
        languages = let
          standardLangs = [
            "bash"
            "clang"
            "css"
            "html"
            "sql"
            "java"
            "ts"
            "go"
            "lua"
            "python"
            "assembly"
            "scala"
            "r"
            "ocaml"
            "haskell"
            "nix"
          ];
        in
          {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;
          }
          // lib.genAttrs standardLangs (_: {
            enable = true;
            treesitter.enable = true;
          })
          // {
            markdown = {
              enable = true;
              treesitter.enable = true;
              extensions."render-markdown-nvim".enable = true;
            };
            # rust = {
            #   enable = true;
            #   treesitter.enable = true;
            #   crates.enable = true;
            # };
          };
        treesitter = {
          enable = true;
          fold = true;
        };
        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
          rainbow-delimiters.enable = true;
        };
        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };
        autopairs.nvim-autopairs.enable = true;
        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;
        filetree.neo-tree = {
          enable = false;
          setupOpts = {
            enable_git_status = true;
            enable_diagnostics = true;
            enable_modified_markers = true;
            open_files_in_last_window = true;
            window = {
              position = "left";
              width = 30;
              mappings = {
                " " = "noop";
              };
            };
            filesystem = {
              filtered_items = {
                visible = true;
                hide_dotfiles = false;
                hide_gitignored = false;
                hide_hidden = false;
              };
              follow_current_file = {
                enabled = true;
                leave_dirs_open = false;
              };
              hijack_netrw_behavior = "open_default";
            };
          };
        };
        tabline = {
          nvimBufferline.enable = false;
        };
        treesitter.context.enable = true;
        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };
        telescope = {
          enable = true;
          setupOpts = {
            pickers = {
              find_files = {
                find_command = [
                  "${pkgs.fd}/bin/fd"
                  "--type=file"
                  "--hidden"
                  "--no-ignore"
                  "--exclude=.git"
                ];
              };
            };
          };
          extensions = [
            {
              name = "file_browser";
              packages = [pkgs.vimPlugins.telescope-file-browser-nvim];
            }
          ];
        };
        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };
        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = true;
        };
        projects = {
          project-nvim.enable = true;
        };
        utility = {
          icon-picker.enable = true;
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            leap.enable = true;
          };
          images = {
            image-nvim.enable = false;
          };
        };
        terminal = {
          toggleterm.enable = true;
        };
        ui = {
          colorizer.enable = true;
          modes-nvim.enable = false;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
        };
        comments = {
          comment-nvim.enable = true;
        };
        maps = {
          normal = {
            "<leader>la" = {
              action = "<cmd>Lspsaga code_action<CR>";
              desc = "Code action";
              noremap = true;
            };
            "<leader>e" = {
              action = ":Neotree toggle<CR>";
              desc = "Toggle Neotree";
            };
            "<leader>bd" = {
              action = ":bdelete<CR>";
              desc = "Close buffer";
            };
            "<leader>gb" = {
              action = ":Gitsigns blame<CR>";
              desc = "Git Blame File";
            };
            "<leader>fn" = {
              action = ":lua require('telescope').extensions.file_browser.file_browser({hidden={file_browser=true, folder_browser=true}, respect_gitignore=false, no_ignore=true})<CR>";
              desc = "File Browser";
            };
            "<leader>fi" = {
              action = ":Telescope file_browser path=%:p:h select_buffer=true<CR>";
              desc = "File Browser Buffer";
            };
          };
          insert = {
            "<C-BS>" = {
              action = "<C-w>";
              desc = "Delete word backward";
            };
          };
        };
        options = {
          ignorecase = true;
          smartcase = true;
          scrolloff = 8;
          wrap = false;
          list = true;
          number = true;
          relativenumber = true;
          hlsearch = false;
          termguicolors = true;
          cursorline = true;
          showmode = false;
          undofile = true;
          shiftwidth = 2;
          smarttab = true;
          shiftround = true;
          expandtab = true;
          foldlevelstart = 99;
          updatetime = 1000;
          inccommand = "split";
        };
        globals = {
          have_nerd_font = true;
          mapleader = " ";
          maplocalleader = " ";
        };
        extraPlugins = {
          scrolleof = {
            package = pkgs.vimUtils.buildVimPlugin {
              pname = "scrollEOF-nvim";
              version = "unstable";
              src = inputs.scrolleof-nvim;
            };
            setup = ''
              require('scrollEOF').setup()
            '';
          };
          switch-vim = {
            package = pkgs.vimPlugins.switch-vim;
          };
        };
        luaConfigPost = ''
          require'lspconfig'.racket_langserver.setup{}

          local arg = vim.fn.argv(0)
          if arg and arg ~= "" then
            local stat = vim.loop.fs_stat(arg)
            if stat then
              local dir = stat.type == "directory" and arg or vim.fn.fnamemodify(arg, ":h")
              vim.cmd("cd " .. vim.fn.fnameescape(dir))
            end
          end
        '';
      };
    };
  };
}
