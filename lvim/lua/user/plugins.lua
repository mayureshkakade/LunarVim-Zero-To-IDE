lvim.plugins = {
  -- Supermaven: AI-powered code completion (disabled inline, using blink.cmp)
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      disable_inline_completion = true, -- Disable ghost text
      disable_keymaps = true,
    }
  },

  -- Blink CMP: Fast and feature-rich autocompletion engine
  -- Description: Modern completion plugin with fuzzy matching, snippets, and LSP integration.
  -- Works seamlessly with Supermaven through the blink-cmp-supermaven adapter.
  -- Custom Keybindings:
  --   <C-j> - Select next completion item
  --   <C-k> - Select previous completion item
  --   <Tab> - Accept and insert the selected completion
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Huijiro/blink-cmp-supermaven", -- Supermaven integration for blink.cmp
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
          supermaven = {
            name = "supermaven",
            module = "blink-cmp-supermaven",
            score_offset = 100,
            async = true,
          },
        },
        default = { 'lsp', 'path', 'supermaven', 'snippets', 'buffer' },
      },
    },
  },

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
  --   end,
  --   keys = {
  --     { "<leader>a",  nil,                                                                  desc = "OpenCode" },
  --     { "<leader>ac", function() require("opencode").toggle() end,                          desc = "Toggle OpenCode" },
  --     { "<leader>ac", function() require("opencode").toggle() end,                          mode = "t",              desc = "Toggle OpenCode" },
  --     { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" },     desc = "Ask OpenCode" },
  --     { "<leader>ax", function() require("opencode").select() end,                          mode = { "n", "x" },     desc = "Execute OpenCode action" },
  --     { "<leader>ab", function() require("opencode").prompt("@buffer") end,                 mode = { "n", "x" },     desc = "Add buffer to OpenCode" },
  --     { "<leader>as", function() require("opencode").ask() end,                             mode = "v",              desc = "Send to OpenCode" },
  --   },
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
    config = function(_, opts)
      require("claudecode").setup(opts)
      -- Hide line numbers in terminal windows
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })
    end,
    opts = {
      diff_opts = {
        auto_close_on_accept = true, -- Close diff windows after accepting
        vertical_split = true,       -- Use vertical splits for diffs
        open_in_current_tab = false, -- Don't create new tabs
        keep_terminal_focus = true,  -- Keep focus on Claude terminal
      },
      terminal = {
        provider = "native"
      }
    },
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

  -- Trouble.nvim: Beautiful diagnostics, references, and quickfix list
  -- Description: A pretty list for showing diagnostics, references, telescope results,
  -- quickfix and location lists. Greatly improves the display of LSP diagnostics including
  -- TypeScript errors with better formatting, icons, and navigation.
  -- Custom Keybindings:
  --   <leader>xx - Toggle diagnostics list
  --   <leader>xw - Show workspace diagnostics
  --   <leader>xd - Show document diagnostics
  --   <leader>xq - Show quickfix list
  --   <leader>xl - Show location list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>x",  nil,                                                desc = "Trouble/Diagnostics" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Toggle diagnostics" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",                 desc = "Quickfix list" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location list" },
    },
    opts = {
      auto_close = false,
      auto_open = false,
      focus = true,
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
    file_ignore_patterns = {
      "node_modules/.*",
      ".git/.*",
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",                -- include hidden files like `.github`
      "--glob=!node_modules/**", -- exclude node_modules from searches
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
