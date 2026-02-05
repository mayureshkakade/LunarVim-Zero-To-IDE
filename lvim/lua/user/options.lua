local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 0,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  -- termguicolors = true,                   -- set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  linebreak = true,                        -- companion to wrap, don't split words
  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,                       -- minimal number of screen columns either side of cursor if wrap is `false`
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  whichwrap = "bs<>[]hl",                  -- which "horizontal" keys are allowed to travel to prev/next line
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
-- vim.opt.shortmess:append "c"                          -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-"                          -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" })       -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use

lvim.format_on_save = true
lvim.builtin.project.detection_methods = { "pattern" }
lvim.builtin.project.patterns = { ".git" }
-- lvim.colorscheme = "ayu"
lvim.colorscheme = "tokyonight-night"
lvim.transparent_window = true

-- Disable the nvim.cmp since we are using Blink.cmp
lvim.builtin.cmp.active = false

-- Display builtin terminal as vertical split. Comment below code to use toggle terminal.
lvim.builtin.terminal.direction = "horizontal"
-- lvim.builtin.terminal.size = 20
lvim.builtin.terminal.float_opts = {
  width = 85,
  height = 35,
}
-- lvim.builtin.project.patterns = { ".git", "package-lock.json", "yarn.lock", "package.json" }

lvim.builtin.nvimtree.setup.view.width = 35
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.renderer.icons.glyphs = require("user.kind").nvim_tree_icons

-- Configure filters to show node_modules in tree but not hidden files by default
lvim.builtin.nvimtree.setup.filters = {
  dotfiles = false, -- Show hidden files (you can set to true if you want to hide them)
  custom = {},      -- No custom filters - this ensures node_modules is visible
  exclude = {},     -- No exclusions
}

-- Show files ignored by git (like node_modules if it's in .gitignore)
lvim.builtin.nvimtree.setup.git = {
  enable = true,
  ignore = false, -- IMPORTANT: Set to false to show node_modules even if in .gitignore
}

-- Custom key mappings for nvim-tree
lvim.builtin.nvimtree.setup.on_attach = function(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Telescope integration functions
  local function telescope_find_files()
    local node = require("nvim-tree.lib").get_node_at_cursor()
    local abspath = node.link_to or node.absolute_path
    local is_folder = node.open ~= nil
    local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
    require("telescope.builtin").find_files({ cwd = basedir })
  end

  local function telescope_live_grep()
    local node = require("nvim-tree.lib").get_node_at_cursor()
    local abspath = node.link_to or node.absolute_path
    local is_folder = node.open ~= nil
    local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
    require("telescope.builtin").live_grep({ cwd = basedir })
  end

  -- Use default nvim-tree mappings first
  api.config.mappings.default_on_attach(bufnr)

  -- Add LunarVim's custom useful keymaps
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'F', telescope_live_grep, opts('Telescope Live Grep'))
  vim.keymap.set('n', 'gtf', telescope_find_files, opts('Telescope Find File'))

  -- Custom mapping: 'y' to copy absolute path
  vim.keymap.set('n', 'y', function()
    local node = api.tree.get_node_under_cursor()
    if node then
      local absolute_path = node.absolute_path
      vim.fn.setreg('+', absolute_path)
      vim.notify('Copied: ' .. absolute_path, vim.log.levels.INFO)
    end
  end, opts('Copy absolute path'))
end
