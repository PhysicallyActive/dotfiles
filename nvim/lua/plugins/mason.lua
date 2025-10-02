return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    -- formatters
    table.insert(opts.ensure_installed, "prettierd")
    table.insert(opts.ensure_installed, "ruff")

    -- linters
    table.insert(opts.ensure_installed, "eslint_d")
    table.insert(opts.ensure_installed, "mypy")
  end,
}
