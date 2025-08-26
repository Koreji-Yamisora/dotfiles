-- ~/.config/nvim/lua/plugins/jupyter.lua
return {
  {
    "benlubas/molten-nvim",
    dependencies = {
      {
        "3rd/image.nvim",
        opts = {
          backend = "kitty", -- you must be using kitty terminal
          integrations = {},
          max_width = 100,
          max_height = 12,
          max_height_window_percentage = math.huge,
          max_width_window_percentage = math.huge,
          window_overlap_clear_enabled = true,
          window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
        version = "1.1.0",
      },
    },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      { "<leader>ji", ":MoltenInit<CR>", desc = "Initialize Molten" },
      {
        "<leader>jI",
        function()
          local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
          if venv ~= nil then
            local venv_name = string.match(venv, "/.+/(.+)")
            local success = pcall(vim.cmd, ("MoltenInit %s"):format(venv_name))
            if not success then
              vim.notify("Kernel '" .. venv_name .. "' not found, using python3", vim.log.levels.WARN)
              vim.cmd("MoltenInit python3")
            end
          else
            vim.cmd("MoltenInit python3")
          end
        end,
        desc = "Initialize Python (Auto-detect)",
      },
      { "<leader>jd", ":MoltenDelete<CR>", desc = "Delete Molten Session" },
      { "<leader>jr", ":MoltenReevaluateCell<CR>", desc = "Run Cell" },
      { "<leader>jR", ":MoltenReevaluateAll<CR>", desc = "Run All Cells" },
      { "<leader>jl", ":MoltenEvaluateLine<CR>", desc = "Run Line" },
      { "<leader>je", ":MoltenEvaluateOperator<CR>", desc = "Run Operator" },
      { "<leader>jv", ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "Run Visual", mode = "v" },
      { "<leader>js", ":MoltenRestart<CR>", desc = "Restart Kernel" },
      { "<leader>jn", ":MoltenNext<CR>", desc = "Next Cell" },
      { "<leader>jp", ":MoltenPrev<CR>", desc = "Previous Cell" },
      { "]j", ":MoltenNext<CR>", desc = "Next Jupyter Cell" },
      { "[j", ":MoltenPrev<CR>", desc = "Previous Jupyter Cell" },
      { "<leader>jo", ":MoltenShowOutput<CR>", desc = "Show Output" },
      { "<leader>jh", ":MoltenHideOutput<CR>", desc = "Hide Output" },
      { "<leader>jO", ":noautocmd MoltenEnterOutput<CR>", desc = "Enter Output Window" },
      { "<leader>jx", ":MoltenDelete<CR>", desc = "Clear Output" },
      { "<leader>jk", ":MoltenInfo<CR>", desc = "Kernel Info" },
      { "<leader>jK", ":MoltenAvailableKernels<CR>", desc = "Available Kernels" },
      { "<leader>jm", ":MoltenImportOutput<CR>", desc = "Import Output" },
      { "<leader>jM", ":MoltenExportOutput<CR>", desc = "Export Output" },
    },
    config = function()
      local wk = require("which-key")
      wk.add({ { "<leader>j", group = "jupyter", icon = "🪐" } })

      -- Force Molten to recognize `# %%` in all python buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python" },
        callback = function()
          vim.b.molten_cell_boundary_marker = "# %%"
        end,
      })
    end,
  },

  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      style = "percent", -- VSCode-style # %% cells
      output_extension = "py", -- notebooks mirror as .py
      force_ft = "python", -- always treat as Python
    },
    ft = { "ipynb", "py" },
    config = function(_, opts)
      require("jupytext").setup(opts)

      -- Ensure .py:percent opens as python + with cell markers
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.py:percent" },
        callback = function()
          vim.bo.filetype = "python"
          vim.b.molten_cell_boundary_marker = "# %%"
        end,
      })
    end,
  },
}
