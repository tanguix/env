
-- hex color preview 
return {
  "norcalli/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local color_preview = require("colorizer")

    color_preview.setup({
      'css';
      'javascript';
      'toml';
      -- "*";                  -- all files enable preview
      html = {
        mode = 'foreground';
      }
    })

    -- set keymap 
    local keymap = vim.keymap         -- for conciseness
    keymap.set("n", "<leader>cp", "<cmd>ColorizerToggle<cr>", { desc = "Toggle Hex Color Preview" })


  end,
}
