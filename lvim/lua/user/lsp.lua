local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({
  {
    command = "prettierd",
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
    },
  },
})

local linters = require "lvim.lsp.null-ls.linters"
linters.setup({
  {
    command = "eslint_d",
    filetypes = { "javascript", "typescript", "typescriptreact" },
    extra_args = {},
    -- This will make null-ls prefer local node_modules/.bin version
    prefer_local = "node_modules/.bin",
    timeout = 10000, -- Set a timeout for the linter
  },
  {
    command = "jsonlint",
    filetypes = { "json" },
  }
})

vim.diagnostic.config({
  float = {
    max_width = 120, -- Set the maximum width of the diagnostic float window
    focusable = true,
  },
})
