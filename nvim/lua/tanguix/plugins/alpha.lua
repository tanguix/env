

return {
  "goolord/alpha-nvim",
  event = "VimEnter",     -- lazy load, event is when you enter vim "VimEnter"
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- set header 
    dashboard.section.header.val = {
      "                                                ",
      "                                                ",
      "                                                ",
      "                                                ",
      "                                                ",
      "                ▄▄            ▄▄                ",
      "                ▀▀▄▄  ▄▄▄▄  ▄▄▀▀                ",
      "                  ▀▀▄▀    ▀▄▀▀                  ",
      "     ▄▄        ▄▄▄▄██████████▄▄▄▄        ▄▄     ",
      "     ▄▄    ▄▄▄▄▀▀▀▀    ██    ▀▀▀▀▄▄▄▄    ▄▄     ",
      "     ██▄▄▄▄▀▀▀▀        ██        ▀▀▀▀▄▄▄▄██     ",
      "     ▀▀▀▀██      ██    ██    ██      ███▀▀▀     ",
      "       ██              ██              ██       ",
      "      ▄█▀      ▄       ██       ▄      ▀█▄      ",
      "  ▄ ▄▄██     ▄▀▀▀▄     ██     ▄▀▀▀▄     ██▄▄ ▄  ",
      "  ▀ ▀▀██    ▀█   █▀    ██    ▀█   █▀    ██▀▀ ▀  ",
      "      ▀█▄     ▀█▀      ██      ▀█▀     ▄█▀      ",
      "       ██              ██              ██       ",
      "     ▄▄▄██       ▄▄    ██    ▄▄       ██▄▄▄     ",
      "     ██▀▀█▄      ▀▀    ██    ▀▀      ▄█▀▀██     ",
      "     ▀▀    ███         ██         ███    ▀▀     ",
      "     ▀▀       ████▄▄▄▄▄██▄▄▄▄▄████       ▀▀     ",
      "                  ▀▀▀▀▀▀▀▀▀▀▀▀                  ",
      "                                                ",
      "                    tanguix ?                   ",
      "                                                ",
      "                                                ",

    }


    -- define custom highlight groups: one for button, one for text
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#ff9e64" })
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#7dcfff" })
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7" })         -- highlight for Header
    -- vim.api.nvim_set_hl(0, "AlphaButtonIcon", { fg = "#98be65" })     -- highlight for ButtonIcon?



    -- modify button function to use custom highlights (button use hl, text hl_shortcut)
    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl = "AlphaButtons"
      b.opts.hl_shortcut = "AlphaShortcut"

      return b
    end



    -- Set menu with custom colored buttons
    dashboard.section.buttons.val = {
      button("e", "  > New File", "<cmd>ene<CR>"),
      button("Ctrl n", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
      button("SPC wr", "󰁯  > Restore Neovim Session", "<cmd>SessionRestore<CR>"),
      button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
    }

    -- Apply custom highlight to header
    dashboard.section.header.opts.hl = "AlphaHeader"

    -- send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

  end,
}
