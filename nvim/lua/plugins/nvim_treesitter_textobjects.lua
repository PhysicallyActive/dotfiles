return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  opts = {
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- functions
          ["af"] = { query = "@funtion.outer", desc = "Select outer part of a method/function definition" },
          ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

          -- classes
          ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
        },
      },
    },
  },
}
