

-- options.lua

------------------- Default File Explorer Style (tree) -------------------
vim.cmd("let g:netrw_liststyle = 3")


-- global variable 
local opt = vim.opt


-- numbers 
opt.relativenumber = true
opt.number = true


-- tab & indentation 
opt.tabstop = 2 	                  -- great for web development, what's about python
opt.shiftwidth = 2	                -- 2 space for indent width 
opt.expandtab = true	              -- expand tab to spaces 
opt.autoindent = true 	            -- copy indent from current line when starting new lines


-- action when line reaches edge 
opt.wrap = false


-- search settings 
opt.ignorecase = true 	            -- ignore case when searching 
opt.smartcase = true	              -- if you include mixed case, assume case-sensitive 


-- truecolor turn on for colorscheme (only for true color terminal)
opt.termguicolors = true
opt.background = "dark"             -- considering 
opt.signcolumn = "yes"	            -- show sign column so text doesn't shift 


-- backspace
opt.backspace = "indent,eol,start"  -- allow backspace on indent, end of line/insert mode start position


-- unified the clipboard 
opt.clipboard:append("unnamedplus") -- use system clipboard as default register


-- cursor line
opt.cursorline = true                   -- highlight the current cursor line


-- recognize "-" for connecting words 
-- semi-colon is a single string instead of three, ctrl+w will delete them all  
opt.iskeyword:append("-")
