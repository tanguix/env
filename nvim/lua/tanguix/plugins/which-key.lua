
-- press "q" to exit
return {
  "folke/which-key.nvim",
  event = "VeryLazy",       -- create an event, which lazy load this plugins, whenever needed
  init = function()         
    vim.o.timeout = true    -- timeout make it not immediately activate when trigger behavior present
    vim.o.timeoutlen = 500  -- how long? 500ms later (press leader key to see what's coming)
  end,                      -- keymap.set("", "", "", { desc = "" }), desc will show with "which-key.nvim"

  opts = {
    -- Add this configuration to exclude 'n' from which-key
    triggers_blacklist = {
      n = { "n" },
    },
    -- your configuration comes here 
    -- or leave it empty to use the default settings 
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    -- Explicitly set 'n' back to its default behavior
    vim.keymap.set('n', 'n', 'n', { noremap = true, desc = "Next search result" })
  end

}
