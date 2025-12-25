

-- mason.lua language server 
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Force Homebrew Python BEFORE Mason loads
    -- local homebrew_python = "/opt/homebrew/bin/python3"
    -- vim.env.PATH = "/opt/homebrew/bin:" .. vim.env.PATH
    
    -- import mason
    local mason = require("mason")
    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    
    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      pip = {
        upgrade_pip = true,
      },
      PATH = "prepend",
    })
    
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "svelte",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
      },
    })
    
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "pylint",
        "black",
        "isort",
        "eslint_d",
      },
    })
  end,
}


