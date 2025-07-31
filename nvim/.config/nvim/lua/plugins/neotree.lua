return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"rebelot/kanagawa.nvim",
		},
		config = function()
			vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {silent=true})
			local colors = require("kanagawa.colors").setup({ theme = "dragon" })
			local palette = colors.palette
			local theme = colors.theme

			vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = theme.ui.fg, bg = theme.ui.bg })
			vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { fg = theme.ui.fg, bg = theme.ui.bg })
			vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = theme.syn.identifier })
			vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = palette.crystalBlue })
			vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = theme.syn.identifier })
			vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = theme.syn.constant })
			vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = palette.springGreen })
			vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = palette.waveRed })
			vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = palette.autumnYellow })
			vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = theme.ui.whitespace })
			vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { fg = palette.dragonBlue, italic = true })
		end,
	},
}
