return {
  "stevearc/oil.nvim",
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  },
  opts = {}, -- You can remove this if you configure inside `config = function() ... end`
  lazy = false,
  config = function()
   local oil = require("oil")
    oil.setup()
    vim.keymap.set("n", "-", oil.toggle_float, {})
  end,
}

