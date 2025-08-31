lvim.plugins = {
  -- Better copilot plugin for autocompletions
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- This is correct: disable copilot's UI
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
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = "InsertEnter",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- },

  -- Official GitHub Copilot plugin for AI code suggestions in real-time.
  {
    "github/copilot.vim",
    -- event = "InsertEnter",
    config = function()
      -- vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = { ["*"] = false } -- Disable Copilot for all file types by default so that inline suggestions don't interfere with Blink CMP
      -- vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
      -- vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Dismiss()', { silent = true, expr = true, script = true })
    end,
  },

  -- AI-powered code assistant that provides intelligent code completions and explanations.
  {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "copilot",
      providers = {
        copilot = {
          -- model = 'claude-sonnet-4'
          model = 'gpt-4.1',
          -- max_context_tokens = 8000
        },
      },
      windows = {
        sidebar = {
          width = 50,
          position = "right",
          winblend = 80, -- Make sidebar transparent (0-100, higher = more transparent)
        },
        input = {
          prefix = "> ",
          winblend = 20, -- Make input window transparent
        },
        edit = {
          border = "rounded",
          winblend = 20, -- Make edit window transparent
        },
        ask = {
          floating = true,
          border = "rounded",
          winblend = 70, -- Make ask window transparent
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        diff = {
          ours = "co",
          theirs = "ct",
          both = "cb",
          next = "]x",
          prev = "[x",
        },
      },
    },
    config = function(_, opts)
      require("avante").setup(opts)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "github/copilot.vim",
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- Colorschemes: Examples of themes to customize the appearance of your editor.
  { "tomasr/molokai" },
  { "ayu-theme/ayu-vim" },

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

  -- Octo plugin for github issues
  -- commands
  -- Octo pr list
  -- Octo pr search
  -- Octo review start
  -- {
  --   "pwntester/octo.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("octo").setup()
  --   end,
  -- },

  -- Noice.nvim plugin for enhanced command line and message handling in Neovim.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
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
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        timeout = 2000,              -- Auto-dismiss after 2 seconds
        max_width = 60,              -- Limit notification width
        max_height = 15,             -- Limit notification height
        minimum_width = 40,          -- Minimum width for consistency
        level = vim.log.levels.INFO, -- Show info level and above for better visibility
        render = "compact",
        stages = "static",           -- Use static stage for immediate timeout respect
        top_down = false,            -- Show notifications from bottom up
        fps = 60,                    -- Smooth animation
        animation = "fade",          -- Use fade animation instead of stages
        hide_from_history = false,   -- Keep in history but respect timeout
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
        on_open = function(win)
          -- Make notifications non-focusable but ensure they're visible
          vim.api.nvim_win_set_config(win, {
            focusable = false,
            zindex = 100 -- Ensure notifications appear on top
          })
        end,
      })
      require("noice").setup({
        notify = {
          enabled = true,
          view = "notify",
          timeout = 2000, -- Auto-dismiss after 2 seconds
        },
        lsp = {
          -- Override markdown rendering so that **cmp** and other plugins use Treesitter
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false,        -- Use a classic bottom cmdline for search
          command_palette = false,      -- Position the cmdline and popupmenu together
          long_message_to_split = true, -- Long messages will be sent to a split
          inc_rename = false,           -- Enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- Add a border to hover docs and signature help
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
          -- Reduce verbosity of certain LSP messages but keep some visible
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
        ["<C-y>"] = function(prompt_bufnr)
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
