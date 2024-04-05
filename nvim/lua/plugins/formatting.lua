return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  opts = {
    formatters_by_ft = {
      python = { "black", "isort" },
      markdown = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
    },
  },
}
