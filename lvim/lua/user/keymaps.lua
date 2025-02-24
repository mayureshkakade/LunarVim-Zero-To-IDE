local opts = { noremap = true, silent = true }
local kind = require('user.kind')

-- Shorten function name
local keymap = vim.keymap.set

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press kj fast to exit insert mode
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode and indent the block of lines in visual mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Keep pasting same yanked characters
keymap("v", "p", '"_dP', opts)

-- Create tab groups
keymap("n", "gn", ":tabe %<CR>", opts)

-- Save file with ctrl+s
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Go to references list using telescope
lvim.lsp.buffer_mappings.normal_mode["gr"] = {
  ":lua require'telescope.builtin'.lsp_references()<cr>",
  kind.cmp_kind.Reference .. " Find references"
}

-- Go to definition list using telescope
lvim.lsp.buffer_mappings.normal_mode["gd"] = {
  ":lua vim.lsp.buf.definition()<cr>",
  -- ":lua require'telescope.builtin'.lsp_definitions()<cr>",
  kind.cmp_kind.Reference .. " Definitions"
}

-- Go to recently used files list using telescope
lvim.lsp.buffer_mappings.normal_mode["gf"] = {
  ":Telescope frecency workspace=CWD<CR>",
  kind.cmp_kind.Reference .. " Telescope Frecency"
}

-- Keymaps for hop.nvim
local hop = require('hop')
local directions = require('hop.hint').HintDirection
keymap('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
keymap('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
keymap('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
keymap('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })


-- Enter normal mode while inside builtin terminal
vim.api.nvim_set_keymap("t", "<C-Space>", "<C-\\><C-n>", { noremap = true, silent = true })
