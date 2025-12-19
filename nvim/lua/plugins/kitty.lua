return {
  "mikesmithgh/kitty-scrollback.nvim",
  enabled = true,
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth", "KittyScrollbackGenerateCommandLineEditing" },
  event = { "User KittyScrollbackLaunch" },
  config = function()
    require("kitty-scrollback").setup()
  end,
  keys = {
    { "<C-CR>", false }, -- Disable execute in all modes
    { "<S-CR>", false }, -- Disable paste to terminal in all modes
    {
      "<leader><CR>",
      "<Plug>(KsbExecuteVisualCmd)",
      mode = "v",
      desc = "Execute the contents of visual selection in Kitty",
    },
    {
      "<leader><CR>",
      "<Plug>(KsbExecuteCmd)",
      mode = { "n", "i" },
      desc = "Execute the contents of the paste window in Kitty",
    },
    {
      "<leader>p",
      "<Plug>(KsbPasteVisualCmd)",
      mode = "v",
      desc = "Paste the contents of visual selection to Kitty without executing",
    },
    {
      "<leader>p",
      "<Plug>(KsbPasteCmd)",
      mode = { "n", "i" },
      desc = "Paste the contents of the paste window to Kitty without executing",
    },
  },
}
