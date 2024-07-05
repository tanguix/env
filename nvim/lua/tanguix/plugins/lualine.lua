

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043",
    }
    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = nil, fg = colors.fg },     -- setting the background of component part transparent
        c = { bg = nil, fg = colors.fg },     -- which is nil value(none)
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = nil, fg = colors.fg },
        c = { bg = nil, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = nil, fg = colors.fg },
        c = { bg = nil, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = nil, fg = colors.fg },
        c = { bg = nil, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = nil, fg = colors.fg },
        c = { bg = nil, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = nil, fg = colors.semilightgray },
        c = { bg = nil, fg = colors.semilightgray },
      },
    }
    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
        -- component_separators = { left = '  ', right = '  '},
        component_separators = { left = ' 󰇙 ', right = ' 󰇙 '},
        section_separators = { left = '  ', right = '  '},          -- separate mode block with others
      },
      -- 1 | 2 | 3 __ x | y | z
      -- modify the lualine_x section to pending updates
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
