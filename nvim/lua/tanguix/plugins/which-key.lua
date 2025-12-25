

-- press "q" to exit
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {},
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    -- Explicitly set 'n' back to its default behavior
    vim.keymap.set('n', 'n', 'n', { noremap = true, desc = "Next search result" })
  end
}


