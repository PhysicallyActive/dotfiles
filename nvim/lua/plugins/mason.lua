return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    -- formatters
    table.insert(opts.ensure_installed, "prettierd")
    table.insert(opts.ensure_installed, "prettier")
    table.insert(opts.ensure_installed, "black")
    table.insert(opts.ensure_installed, "isort")

    -- linters
    table.insert(opts.ensure_installed, "eslint_d")
    table.insert(opts.ensure_installed, "pylint")
  end,
}
