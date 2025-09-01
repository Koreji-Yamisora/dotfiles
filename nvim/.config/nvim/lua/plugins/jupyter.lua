-- ~/.config/nvim/lua/plugins/jupyter.lua
return {
  {
    "benlubas/molten-nvim",
    dependencies = {
      {
        "3rd/image.nvim",
        opts = function()
          -- Check if ImageMagick is available
          local has_magick = vim.fn.executable("magick") == 1 or vim.fn.executable("convert") == 1

          return {
            processor = has_magick and "magick_cli" or nil,
            backend = "kitty", -- change to "ueberzug" if not using kitty
            integrations = {},
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
          }
        end,
      },
    },
    build = function()
      -- Ensure UpdateRemotePlugins is run after installation
      vim.cmd("UpdateRemotePlugins")
    end,
    init = function()
      -- Check if python3 provider is available
      if vim.fn.has("python3") == 0 then
        vim.notify("Python3 provider not available. Please install pynvim: pip install pynvim", vim.log.levels.ERROR)
        return
      end

      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_lines_off_by_1 = false
    end,
    keys = {
      {
        "<leader>ji",
        function()
          -- Check if MoltenInit command exists before using it
          if vim.fn.exists(":MoltenInit") == 0 then
            vim.notify(
              "MoltenInit command not found. Try :UpdateRemotePlugins and restart Neovim",
              vim.log.levels.ERROR
            )
            return
          end
          vim.cmd("MoltenInit")
        end,
        desc = "Initialize Molten",
      },
      {
        "<leader>jI",
        function()
          -- Check if MoltenInit command exists
          if vim.fn.exists(":MoltenInit") == 0 then
            vim.notify(
              "MoltenInit command not found. Try :UpdateRemotePlugins and restart Neovim",
              vim.log.levels.ERROR
            )
            return
          end

          local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
          if venv ~= nil then
            local venv_name = string.match(venv, "/.+/(.+)")
            local success = pcall(vim.cmd, ("MoltenInit %s"):format(venv_name))
            if not success then
              vim.notify("Kernel '" .. venv_name .. "' not found, using python3", vim.log.levels.WARN)
              pcall(vim.cmd, "MoltenInit python3")
            end
          else
            pcall(vim.cmd, "MoltenInit python3")
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
      -- Check if which-key is available
      local ok, wk = pcall(require, "which-key")
      if ok then
        wk.add({ { "<leader>j", group = "jupyter", icon = "🪐" } })
      end

      -- Force Molten to recognize `# %%` in all python buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python" },
        callback = function()
          vim.b.molten_cell_boundary_marker = "# %%"
        end,
      })

      -- Add a user command to check setup
      vim.api.nvim_create_user_command("MoltenCheck", function()
        local checks = {}

        -- Check Python provider
        if vim.fn.has("python3") == 1 then
          table.insert(checks, "✓ Python3 provider available")
        else
          table.insert(checks, "✗ Python3 provider not available")
        end

        -- Check if commands exist
        if vim.fn.exists(":MoltenInit") == 2 then
          table.insert(checks, "✓ MoltenInit command available")
        else
          table.insert(checks, "✗ MoltenInit command not found")
        end

        -- Check ImageMagick
        if vim.fn.executable("magick") == 1 or vim.fn.executable("convert") == 1 then
          table.insert(checks, "✓ ImageMagick available")
        else
          table.insert(checks, "✗ ImageMagick not found")
        end

        vim.notify(table.concat(checks, "\n"), vim.log.levels.INFO)
      end, { desc = "Check Molten setup" })
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
