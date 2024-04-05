return {
  "mfussenegger/nvim-lint",
  dependencies = { "mason.nvim" },
  opts = {
    linters_by_ft = {
      python = { "mypy", "pylint", "flake8" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
}
