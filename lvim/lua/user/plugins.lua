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
  -- { "morhetz/gruvbox" },
  -- { "sainnhe/gruvbox-material" },
  -- { "sainnhe/sonokai" },
  -- { "sainnhe/edge" },
  -- { "lunarvim/hlvim.format_on_save = trueorizon.nvim" },
  -- { "tomasr/molokai" },
  -- { "ayu-theme/ayu-vim" },

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
  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
  },

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
    opts = {},
    keys = {
      { "<leader><leader>cc", "<cmd>CopilotChat<cr>",        desc = "Open Copilot Chat" },
      { "<leader><leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code" },
      { "<leader><leader>ct", "<cmd>CopilotChatTests<cr>",   desc = "Generate Tests" },
      { "<leader><leader>cf", "<cmd>CopilotChatFix<cr>",     desc = "Fix Code" },
    },
  }
)

-- Display telescope panel using default theme (center)
lvim.builtin.telescope.theme = "center"

-- use ctrl+j/k to navigate the telescope file search results
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-j>"] = require("telescope.actions").move_selection_next,
    ["<C-k>"] = require("telescope.actions").move_selection_previous,
  },
}

-- allow git-ignored files to appear in search
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "node_modules"
}

-- allow git-ignored files to appear in search
lvim.builtin.telescope.pickers.find_files = {
  hidden = true,
  no_ignore = true,
  no_ignore_parent = true,
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "frecency")
end
