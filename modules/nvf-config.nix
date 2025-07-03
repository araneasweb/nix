_: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };
        diagnostics = {
          config = {
            virtual_lines = true;
          };
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix.enable = true;
          markdown = {
            enable = true;
            extensions.render-markdown-nvim.enable = true;
          };
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          sql.enable = true;
          java.enable = true;
          kotlin.enable = true;
          ts.enable = true;
          go.enable = true;
          lua.enable = true;
          zig.enable = true;
          python.enable = true;
          typst.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
          assembly.enable = true;
          astro.enable = true;
          nu.enable = true;
          csharp.enable = true;
          julia.enable = true;
          vala.enable = true;
          scala.enable = true;
          r.enable = true;
          gleam.enable = true;
          ocaml.enable = true;
          elixir.enable = true;
          haskell = {
            enable = true;
            treesitter.enable = true;
          };
          ruby.enable = true;
          tailwind.enable = true;
          svelte.enable = true;
          nim.enable = true;
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
        filetree = {
          neo-tree = {
            enable = true;
          };
        };
        tabline = {
          nvimBufferline.enable = true;
        };
        treesitter.context.enable = true;
        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };
        telescope.enable = true;
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
          ccc.enable = false;
          vim-wakatime.enable = false;
          icon-picker.enable = true;
          surround.enable = true;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;
          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = true;
          };
          images = {
            image-nvim.enable = false;
          };
        };
        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };
        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          fastaction.enable = true;
        };
        presence = {
          neocord = {
            enable = true;
            setupOpts.logo_tooltip = "fangirling";
          };
        };
        comments = {
          comment-nvim.enable = true;
        };
      };
    };
  };
}
