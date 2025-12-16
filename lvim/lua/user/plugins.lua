lvim.plugins = {
  -- Copilot.lua: AI-powered code completion from GitHub Copilot
  -- Description: Provides intelligent code suggestions and completions powered by GitHub Copilot.
  -- Runs headless (no UI) and integrates seamlessly with blink.cmp for completion display.
  -- Suggestion and panel UI are disabled to work with external completion plugins.
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
  -- Blink CMP: Fast and feature-rich autocompletion engine
  -- Description: Modern completion plugin with fuzzy matching, snippets, and LSP integration.
  -- Works seamlessly with Copilot through the blink-cmp-copilot adapter.
  -- Custom Keybindings:
  --   <C-j> - Select next completion item
  --   <C-k> - Select previous completion item
  --   <Tab> - Accept and insert the selected completion
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
  -- Render Markdown: Live markdown rendering in Neovim buffers
  -- Description: Displays markdown files with proper formatting, headers, code blocks, and inline
  -- elements rendered visually in normal mode. Makes reading markdown documentation easier.
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    opts = { file_types = { 'markdown' }, render_modes = { 'n' } },
  },

  -- OpenCode.nvim - AI-powered coding assistant integrated directly into Neovim
  -- {
  --   "NickvanDyke/opencode.nvim",
  --   dependencies = {
  --     -- Recommended for `ask()` and `select()`.
  --     -- Required for `snacks` provider.
  --     -- -@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
  --     { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  --   },
  --   config = function()
  --     -- -@type opencode.Opts
  --     vim.g.opencode_opts = {
  --       -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
  --     }

  --     -- Required for `opts.events.reload`.
  --     vim.o.autoread = true

  --     -- Recommended/example keymaps.
  --     vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
  --       { desc = "Ask opencode" })
  --     vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
  --       { desc = "Execute opencode action…" })
  --     vim.keymap.set({ "n", "x" }, "ga", function() require("opencode").prompt("@buffer") end,
  --       { desc = "Add to opencode" })
  --     vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
  --     -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
  --     vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
  --     vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
  --   end,
  -- },

  -- ClaudeCode.nvim: Native Claude Code integration for Neovim
  -- Description: Integrates Claude Code AI assistant directly into Neovim for in-editor coding help,
  -- code explanations, refactoring, and more. Provides seamless interaction with Claude without
  -- leaving your editor.
  -- Custom Keybindings:
  --   <leader>ac - Toggle Claude Code interface
  --   <leader>af - Focus Claude Code window
  --   <leader>ar - Resume previous Claude Code session
  --   <leader>aC - Continue Claude Code conversation
  --   <leader>am - Select Claude model (Sonnet, Opus, Haiku)
  --   <leader>ab - Add current buffer to Claude's context
  --   <leader>as - Send visual selection to Claude (visual mode) or add file from file explorer
  --   <leader>aa - Accept suggested diff from Claude
  --   <leader>ad - Deny/reject suggested diff from Claude
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
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
  -- Vim-Repeat: Enables repeating plugin commands with the dot operator
  -- Description: Makes the '.' (dot) command work with plugin mappings, allowing you to repeat
  -- complex plugin actions just like you repeat native Vim commands.
  { "tpope/vim-repeat" },

  -- Place a marker on files for later reference
  -- { "ThePrimeagen/harpoon" },

  -- Hop: Fast cursor movement to any visible location
  -- Description: Jump quickly to any character, word, or line on screen using minimal keystrokes.
  -- EasyMotion-like plugin that shows labels for jump targets.
  -- Custom Keybindings:
  --   s - Jump to any location by typing 2 characters
  --   S - Jump to the start of any visible word
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end
  },

  -- Gitlinker: Generate shareable GitHub URLs for code
  -- Description: Creates GitHub/GitLab/Bitbucket URLs for the current file, line, or selection.
  -- Useful for sharing code references with team members or in documentation.
  -- Custom Keybindings:
  --   <leader>gy - Copy GitHub URL for current line to clipboard
  --   <leader>go - Open GitHub URL for current line in browser
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

  -- Barbar: Enhanced tabline for buffer and tab management
  -- Description: Displays open buffers in a visual tabline at the top of the editor with icons,
  -- file status indicators, and animations. LunarVim provides default keybindings for buffer
  -- navigation (typically <leader>b prefix or <Tab>/<S-Tab> to cycle through buffers).
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

-- Telescope Configuration: Custom settings for the fuzzy finder
-- Description: Telescope is LunarVim's fuzzy finder for files, text, buffers, and more.
-- This configuration customizes the layout, search behavior, and keybindings.
-- Custom Keybindings (insert mode):
--   <C-j> - Move to next search result
--   <C-k> - Move to previous search result
--   <Tab> - Select and open file/result
--   <C-y> - Copy file path to clipboard (custom addition)
--   <C-d> - Delete buffer (in buffer picker only)
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
