
-- specific comments 
return {
  
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- set keymaps 
    local keymap = vim.keymap -- for conciseness 

    -- jump to the next closest TODO
    keymap.set("n", "]t",function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    -- jump to the previous closest TODO
    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    -- remember to call the setup function evrey time for activating
    todo_comments.setup()

    -- below are examples:
    -- TODO:  add some comment here
    -- BUG:   bug color 
    -- HACK:  hacking?
    -- TODO:  bottom comments
  end,

}
