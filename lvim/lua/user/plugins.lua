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
          model = 'claude-sonnet-4'
        },
      },
    },
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
        background_colour = "#1E1E1E",
      })
      require("noice").setup({
      })
    end,
  },
}

-- Copilot completion plugin
-- table.insert(lvim.plugins, {
--   "zbirenbaum/copilot-cmp",
--   event = "InsertEnter",
--   dependencies = { "zbirenbaum/copilot.lua" },
--   config = function()
--     local ok, cmp = pcall(require, "copilot_cmp")
--     if ok then cmp.setup({}) end
--   end,
-- })

-- Display builtin terminal as vertical split
lvim.builtin.terminal.direction = "vertical" -- or "horizontal"
lvim.builtin.terminal.size = 60

-- use ctrl+j/k to navigate the telescope file search results
lvim.builtin.telescope = {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
      preview_width = 0.6,
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
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
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
  -- sort the results in the buffer finder by most recently used at the bottom
  pickers = {
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      mappings = {
        i = {
          ["<C-d>"] = "delete_buffer",
        },
      },
      -- Custom sorter to reverse order (most recent at bottom)
      sorter = require("telescope.sorters").get_generic_fuzzy_sorter({}),
    },
  },
}
