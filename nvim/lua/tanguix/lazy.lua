
----------------------------- Setup lazy.nvim Download Source -----------------------------
--
--
-- download and install lazy.nvim if not exist

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)




----------------------------- Before All Plugins -----------------------------
---
-- pull all plugins configuration from a "path"
-- so in the init.lua at the outer level you only need to import lazy 
-- ==> 1) normal plugins 2) LSP plugins
require("lazy").setup( { {import = "tanguix.plugins" }, { import = "tanguix.plugins.lsp" } }, {

  checker = {
    enabled = true,   -- check if there's update
    notify = false,   -- but don't need to notify me
  },
  -- these lines disable the notification of changes of .lua file everytime, annoying
  change_detection = {
    notify = false,
  },

})
