return {
  "folke/flash.nvim",
  specs = {
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          win = {
            input = {
              keys = {
                ["<c-s>"] = { "flash", mode = { "n", "i" } }, -- <Ctrl+S> for flash in snacks.picker
              },
            },
          },
        },
      },
    },
  },
}
