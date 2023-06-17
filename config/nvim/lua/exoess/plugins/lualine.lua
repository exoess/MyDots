-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- get lualine catppuccin theme
local lualine_catppuccin = require("lualine.themes.catppuccin")

-- new colors for theme
local new_colors = {
  blue = "#89b4fa",
  green = "#a6e3a1",
  violet = "#cba6f7",
  yellow = "#fab387",
  black = "#1e1e2e",
}

-- change catppuccin theme colors
lualine_catppuccin.normal.a.bg = new_colors.blue
lualine_catppuccin.insert.a.bg = new_colors.green
lualine_catppuccin.visual.a.bg = new_colors.violet
lualine_catppuccin.command = {
  a = {
    gui = "bold",
    bg = new_colors.yellow,
    fg = new_colors.black, -- black
  },
}

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = lualine_catppuccin,
  },
})
