return {
  "GCBallesteros/NotebookNavigator.nvim",
  keys = {
    {
      "]x",
      function()
        require("notebook-navigator").move_cell("d")
      end,
      desc = "next cell NotebookNavigator",
    },
    {
      "[x",
      function()
        require("notebook-navigator").move_cell("u")
      end,
      desc = "prev cell NotebookNavigator",
    },
    { "<localleader>mc", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
    { "<localleader>mn", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
  },
  dependencies = {
    "echasnovski/mini.comment",
    "benlubas/molten-nvim",
    "nvimtools/hydra.nvim",
  },
  event = "VeryLazy",
  config = function()
    local nn = require("notebook-navigator")
    nn.setup({
      activate_hydra_keys = "<leader>h",
      repl_provider = "molten",
    })
  end,
}
