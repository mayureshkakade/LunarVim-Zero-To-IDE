lvim.plugins = {
  -- Better copilot plugin for autocompletions
  {
    "zbirenbaum/copilot.lua",
    commit = "5a08ab9",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- Disable copilot's UI
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          ['*'] = true
        },
      })
    end,
  },

  -- Blink CMP plugin for better autocompletion experience with Copilot
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot", -- The adapter plugin
    },
    opts = {
      keymap = {
        preset = 'default',
        ["<C-j>"] = { 'select_next', 'fallback' },
        ["<C-k>"] = { 'select_prev', 'fallback' },
        ["<Tab>"] = { 'accept', 'fallback' }
      },
      completion = { documentation = { auto_show = true } },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      sources = {
        providers = {
          copilot = {
            module = "blink-cmp-copilot",
            score_offset = 100,
          },
        },
        default = { 'copilot', 'lsp', 'snippets', 'buffer', 'path' },
      },
    },
  },

  -- Official GitHub Copilot plugin for AI code suggestions in real-time. This is used by Avant.nvim.
  -- {
  --   "github/copilot.vim",
  --   -- event = "InsertEnter",
  --   config = function()
  --     -- vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_filetypes = { ["*"] = false } -- Disable Copilot for all file types by default so that inline suggestions don't interfere with Blink CMP
  --     -- vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
  --     -- vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Dismiss()', { silent = true, expr = true, script = true })
  --   end,
  -- },

  -- AI-powered code assistant that provides intelligent code completions and explanations.
  -- {
  --   "yetone/avante.nvim",
  --   build = "make",
  --   event = "VeryLazy",
  --   version = false,
  --   opts = {
  --     provider = "copilot",
  --     providers = {
  --       copilot = {
  --         model = 'claude-sonnet-4',
  --         timeout = 30000,
  --         -- model = 'gpt-4.1',
  --         -- max_context_tokens = 8000
  --       },
  --     },
  --     web_search_engine = {
  --       provider = "google", -- tavily, serpapi, google, kagi, brave, or searxng
  --       proxy = nil,         -- proxy support, e.g., http://127.0.0.1:7890
  --     },
  --     windows = {
  --       sidebar = {
  --         width = 50,
  --         position = "right",
  --         winblend = 80, -- Make sidebar transparent (0-100, higher = more transparent)
  --       },
  --       input = {
  --         prefix = "> ",
  --         winblend = 20, -- Make input window transparent
  --       },
  --       edit = {
  --         border = "rounded",
  --         winblend = 20, -- Make edit window transparent
  --       },
  --       ask = {
  --         floating = true,
  --         border = "rounded",
  --         winblend = 70, -- Make ask window transparent
  --       },
  --     },
  --     behaviour = {
  --       auto_suggestions = false,
  --       auto_set_highlight_group = true,
  --       auto_set_keymaps = true,
  --       auto_apply_diff_after_generation = false,
  --       support_paste_from_clipboard = false,
  --     },
  --     mappings = {
  --       ask = "<leader>aa",
  --       edit = "<leader>ae",
  --       refresh = "<leader>ar",
  --       diff = {
  --         ours = "co",
  --         theirs = "ct",
  --         both = "cb",
  --         next = "]x",
  --         prev = "[x",
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("avante").setup(opts)
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "github/copilot.vim",
  --     {
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },

  -- OpenCode.nvim - AI-powered coding assistant integrated directly into Neovim
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      -- -@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      -- -@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
        { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
        { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "x" }, "ga", function() require("opencode").prompt("@buffer") end,
        { desc = "Add to opencode" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
    end,
  },

  -- Colorschemes: Examples of themes to customize the appearance of your editor.
  { "tomasr/molokai" },
  { "ayu-theme/ayu-vim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Plugin to highlight and manage TODO comments in your code, improving task management.
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },

  -- Persistence plugin to restore the last editing session, improving workflow continuity.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" }
      })
    end
  },

  -- Automatically closes HTML/XML tags while coding.
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { "tpope/vim-repeat" },

  -- Place a marker on files for later reference
  -- { "ThePrimeagen/harpoon" },

  -- Hop plugin for fast navigation between words or characters in a document.
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end
  },

  -- Gitlinker plugin for creating sharable URLs to specific lines in code hosted on GitHub.
  -- <leader>gy : To copy the current line github url
  -- <leader>go : To open the github url in browser for current line
  {
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  },

  -- Noice.nvim plugin for enhanced command line and message handling in Neovim.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        timeout = 5000,
        max_width = 60,
        max_height = 15,
        minimum_width = 40,
        level = vim.log.levels.INFO,
        render = "compact",
        stages = "static",
        top_down = false,
        hide_from_history = false,
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
        on_open = function(win)
          vim.api.nvim_win_set_config(win, {
            focusable = false,
            zindex = 100,
          })
        end,
      })
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
        },
        messages = {
          enabled = true,
          view = "notify",
          view_error = "notify",
          view_warn = "notify",
          view_history = "messages",
          view_search = "virtualtext",
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false,
          command_palette = false,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
                { find = "lines yanked" },
                { find = "written" },
                { find = "search hit BOTTOM" },
                { find = "search hit TOP" },
              },
            },
            view = "mini",
          },
          -- Skip null-ls LSP progress messages to reduce noise
          {
            filter = {
              event = "lsp",
              kind = "progress",
              cond = function(message)
                local client = vim.tbl_get(message.opts, "progress", "client")
                return client == "null-ls"
              end,
            },
            opts = { skip = true },
          },
        },
      })
    end,
  },

  -- Barbar.nvim - Enhanced tabline for buffer and tab management with visual indicators
  {
    "romgrk/barbar.nvim",
    event = "VimEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("barbar").setup({
        animation = true,
        auto_hide = false,
        tabpages = true,
        clickable = true,
        icons = {
          button = '',
          separator = { left = '▎', right = '' },
          inactive = { separator = { left = '▎', right = '' } },
        },
      })
    end,
  },

  -- Lualine.nvim - Customizable and lightweight statusline with mode, branch, diagnostics, and file info
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          -- lualine_c = {
          --   {
          --     function()
          --       return vim.fn.getcwd()
          --     end,
          --     icon = '',
          --   },
          -- },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
}


lvim.builtin.telescope = {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
      prompt_position = "bottom",
      horizontal = {
        preview_cutoff = 0,
        preview_width = 0.6,
      },
    },
    path_display = { "truncate" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden", -- include hidden files like `.github`
    },
    mappings = {
      -- use ctrl+j/k to navigate the telescope file search results
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<Tab>"] = require("telescope.actions").select_default,
        ["<C-y>"] = function()
          local entry = require("telescope.actions.state").get_selected_entry()
          local path = entry.path or entry.filename
          if path then
            vim.fn.setreg("+", path)
            print("Copied: " .. path)
          else
            print("No path to copy")
          end
        end
      },
    },
  },
  pickers = {
    -- sort the results in the buffer finder by most recently used at the bottom
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      initial_mode = "insert",
      default_selection_index = 1, -- Start with the most recent buffer selected
      layout_strategy = "vertical",
      layout_config = {
        width = 0.5,
        height = 0.5,
        preview_cutoff = 0,
        vertical = {
          preview_height = 0.4,
        },
      },
      mappings = {
        i = {
          ["<C-d>"] = "delete_buffer",
        },
      },
      -- Custom sorter to reverse order (most recent at bottom)
      sorter = require("telescope.sorters").get_generic_fuzzy_sorter({}),
    },
    git_files = {
      initial_mode = "insert",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.5,
        height = 0.5,
        preview_cutoff = 0,
        vertical = {
          preview_height = 0.4,
        },
      },
      git_command = { 'git', 'ls-files', '--exclude-standard', '--others', '--cached', ':!:*.git/*' },
    },
  },
}
