
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "rebelot/kanagawa.nvim" },
  config = function()
    -- Load Kanagawa Dragon palette
    local palette = require("kanagawa.colors").setup({ theme = "dragon" }).palette

    -- Define color mappings using Kanagawa Dragon palette
    local colors = {
      white        = palette.oldWhite,
      gray         = palette.dragonBlack4,
      dark_gray    = palette.dragonBlack2,
      light_purple = palette.dragonOrange,
      dark_purple  = palette.dragonBlack5,
      cyan         = palette.dragonTeal,
      green        = palette.dragonAsh,
      orange       = palette.dragonYellow,
      red          = palette.dragonRed,
      pink         = palette.dragonOrange,
      yellow       = palette.dragonYellow,
      black        = palette.dragonBlack0,
      lightgray    = palette.dragonBlack3,
      inactivegray = palette.dragonBlack5,
    }

    -- Custom Lualine theme using Kanagawa Dragon colors
    local kanagawa_dragon = {
      normal = {
        a = { bg = colors.light_purple, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.dark_gray, fg = colors.green },
      },
      insert = {
        a = { bg = colors.green, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.dark_gray, fg = colors.green },
      },
      visual = {
        a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.dark_gray, fg = colors.green },
      },
      replace = {
        a = { bg = colors.red, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.dark_gray, fg = colors.green },
      },
      command = {
        a = { bg = colors.gray, fg = colors.black, gui = "bold" },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.dark_gray, fg = colors.green },
      },
      inactive = {
        a = { bg = colors.inactivegray, fg = colors.gray, gui = "bold" },
        b = { bg = colors.inactivegray, fg = colors.gray },
        c = { bg = colors.inactivegray, fg = colors.green },
      },
    }

    require("lualine").setup({
      options = {
        theme = kanagawa_dragon,
        icons_enabled = true,
      },
    })
  end,
}
