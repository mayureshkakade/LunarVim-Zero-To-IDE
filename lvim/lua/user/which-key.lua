local kind = require('user.kind')
local last_grep_term = ""
local wk = lvim.builtin.which_key

local function live_grep_with_memory()
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  builtin.live_grep({
    default_text = last_grep_term,
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local current_input = action_state.get_current_line()
        last_grep_term = current_input
        actions.select_default(prompt_bufnr)
      end)
      return true
    end
  })
end

wk.mappings["S"] = {
  name = " persistence.nvim",
  s = { "<cmd>lua require('persistence').load()<cr>", kind.icons.clock .. " Reload last session for dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", kind.icons.clock .. " Restore last session" }
}

wk.mappings["l"]["t"] = { ":LvimToggleFormatOnSave<cr>", kind.symbols_outline.File .. " Toggle format-on-save" }

-- map the customization to retain search text for live grep
wk.mappings["s"]["t"] = {
  function()
    live_grep_with_memory()
  end,
  "Live Grep (with memory)"
}
