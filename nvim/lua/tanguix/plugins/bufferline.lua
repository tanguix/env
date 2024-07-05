
-- bufferline --



return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",

  opts = {
    options = {
      -- mode = "tabs",                  -- by default buffer will be opened on top separately 
                                         -- setting to mode="tabs" collects all buffer into one tab
      --
      separator_style = "",      -- predefined separator style

      -- not sure why highlight doesn't work
      highlights = {
        fill = {
          guifg = "#c0caf5",
          guibg = "#1f2335",
        },
        background = {
          guifg = "#c0caf5",
          guibg = "#1f2335",
        },
        buffer_visible = {
          guifg = "#c0caf5",
          guibg = "#1f2335",
        },
        buffer_selected = {
          guifg = "#ffffff",
          guibg = "#44475a",
          gui = "bold,italic",
        },
        separator = {
          guifg = "#1f2335",
          guibg = "#1f2335",
        },
        separator_selected = {
          guifg = "#44475a",
          guibg = "#44475a",
        },
        indicator_selected = {
          guifg = "#ff9e64",
          guibg = "#44475a",
        },
      },
    },
  },
}









-- -- bufferline --
--
-- return {
--   "akinsho/bufferline.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   version = "*",
--
--   opts = {
--     options = {
--       -- mode = "tabs",                  -- by default buffer will be opened on top separately 
--                                          -- setting to mode="tabs" collects all buffer into one tab
--       separator_style = "slant",      -- separator between tabs
--     },
--   },
-- }
--


