lvim.plugins = {
  -- Better copilot plugin for autocompletions
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestions = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  -- Colorschemes examples
  { "tomasr/molokai" },
  { "ayu-theme/ayu-vim" },

  -- Show a pretty list of diagnostics in quick fix
  -- {
  --   "folke/trouble.nvim",
  --   cmd = "TroubleToggle",
  -- },

  -- Better TODO comments
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },

  -- For restoring last session
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

  -- { "tpope/vim-surround" },
  -- { "felipec/vim-sanegx", event = "BufRead" },

  -- Auto close tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { "tpope/vim-repeat" },

  -- Place a marker on files for later reference
  -- { "ThePrimeagen/harpoon" },

  -- Easily navigate similar to leap or easymotion
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end
  },

  -- Another telescope extension to find/navigate recently used files
  -- {
  --   'nvim-telescope/telescope-frecency.nvim',
  --   dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
  -- },

  -- Gitlinker plugin to open links to files in the browser
  -- <leader>gy : To copy the current line github url
  -- <leader>go : To open the github url in browser for current line
  {
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  },

  -- Converts vertically comma separated values to horizontal format
  -- {
  --   'AckslD/nvim-trevJ.lua',
  --   config = 'require("trevj").setup()',
  --   init = function()
  --     vim.keymap.set('n', '<leader>j', function()
  --       require('trevj').format_at_cursor()
  --     end)
  --   end,
  -- }

  -- Octo plugin for github issues
  -- commands
  -- Octo pr list
  -- Octo pr search
  -- Octo review start
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
}

-- Copilot completion plugin
table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    local ok, cmp = pcall(require, "copilot_cmp")
    if ok then cmp.setup({}) end
  end,
})

-- CopilotChat plugin
table.insert(lvim.plugins,
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }
    },
    opts = {
      window = {
        width = 80,
      },
    },
    keys = {
      { "<leader><leader>cc", "<cmd>CopilotChat<cr>",        desc = "Open Copilot Chat" },
      { "<leader><leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code" },
      { "<leader><leader>ct", "<cmd>CopilotChatTests<cr>",   desc = "Generate Tests" },
      { "<leader><leader>cf", "<cmd>CopilotChatFix<cr>",     desc = "Fix Code" },
    },
    event = "InsertEnter",
  }
)

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

-- Uncomment this to use the frecency plugin
-- lvim.builtin.telescope.on_config_done = function(telescope)
--   pcall(telescope.load_extension, "frecency")
-- end
