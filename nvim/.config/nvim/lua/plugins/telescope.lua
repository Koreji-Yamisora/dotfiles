return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      -- Search from buffer directory (FIXED: wrapped in function)
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ cwd = require("telescope.utils").buffer_dir() })
      end, { desc = "Find files from buffer dir" })

      -- Search from vim cwd (FIXED: wrapped in function)
      vim.keymap.set("n", "<leader>fF", function()
        builtin.find_files()
      end, { desc = "Find files from vim cwd" })

      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

      -- FIXED: wrapped in function
      vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers({
          only_cwd = true,
          sort_mru = true,
          initial_mode = "normal",
        })
      end, { desc = "Telescope buffers" })

      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
