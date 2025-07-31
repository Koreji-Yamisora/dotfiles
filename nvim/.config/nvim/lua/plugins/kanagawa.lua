return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			overrides = function(colors)
				local theme = colors.theme
				return {
					-- String highlight
					String = { fg = colors.palette.carpYellow, italic = true },

					-- Example plugin highlight
					SomePluginHl = { fg = theme.syn.type, bold = true },
				}
			end,
		})

		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
