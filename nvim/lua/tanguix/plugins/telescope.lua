
-- telescope fuzzy finder -- 
--
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",    -- branch to use
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },   -- this is for improving sorting in telescope
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",     -- todo comments.nvim plugin for telescope to find 
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },   -- truncate path if too long (filters out)
        mappings = {
          i = {
            -- ["<C-k>"] = actions.move_selection_previous,   -- I have virtual keyboard
            -- ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,  -- modify lines without opening related files
          },
        },
      },
    })

    telescope.load_extension("fzf")   -- improve sorting performance 

    -- set keymap 
    local keymap = vim.keymap         -- for conciseness

    -- normal mode
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })

    -- close telescope with ctrl + c
  end,
}

