
-- syntax highlighting
return {

  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },   -- lazy load, when you in buffer or new file opened
  build = ":TSUpdate",                      -- remember this, some default configuration
  dependencies = {
    "windwp/nvim-ts-autotag",
  },

  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      -- closing the html taging
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "python",
        "c",
        "cpp",
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        -- "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        -- "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        -- "vimdoc",
      },

      -- it's a selection shortcut, you can increment your selection using keyboard
      -- very nice function
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ss",    -- selection: select
          node_incremental = "<leader>si",  -- selection: increment
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
