local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({
  {
    command = "prettier",
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "yaml",
      "markdown",
      "markdown.mdx",
      "graphql",
      "handlebars",
      "json",
    }
  },
})

local linters = require "lvim.lsp.null-ls.linters"
linters.setup({
  {
    command = "eslint",
    filetypes = { "javascript", "typescript", "typescriptreact", "json" }
  },
})

vim.diagnostic.config({
  float = {
    max_width = 120,     -- Set the maximum width of the diagnostic float window
    focusable = true,
  },
})

-- Customize the display name for Copilot in the autocompletion menu
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"

-- Add Copilot as the first autocompletion source
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
