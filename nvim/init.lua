
                                            -- • --

                        -- This is file neovim will run whenever it startup --
                -- :checkhealth lazy -- check if everything is compatible in with neovim --
------------------------------------------------------------------------------------------------------------

--@@ "Bootstrap(引导程序) Lazy Plugin Manager" @@-- 
require("tanguix.core") -- your default config
require("tanguix.lazy") -- bootstrap lazy.nvim: neovim install plugins whenever it starts
                        -- load lazy configuration setup (plugins all included inside)



--@@ Automactic Setting @@--
-- auto command (autocmd.lua): setting some auto action for neovim 
------------------------------------------------------------------

local agrp = vim.api.nvim_create_augroup
local acmd = vim.api.nvim_create_autocmd

-- leaving neovim and set the cursor style to horizontal shope
local exitCursor = agrp("RestoreCursorShapeOnExit", { clear = true })

acmd({ "VimLeave" },
      { pattern = "*",
        command = "set guicursor=a:hor10",
        group = exitCursor,})




--@@ catppuccin color palettes @@--

-- local color_palette = {
-- 	rosewater = "#F5E0DC",
-- 	flamingo = "#F2CDCD",
-- 	pink = "#F5C2E7",
-- 	mauve = "#CBA6F7",
-- 	red = "#F38BA8",
-- 	maroon = "#EBA0AC",
-- 	peach = "#FAB387",
-- 	yellow = "#F9E2AF",
-- 	green = "#A6E3A1",
-- 	teal = "#94E2D5",
-- 	sky = "#89DCEB",
-- 	sapphire = "#74C7EC",
-- 	blue = "#89B4FA",
-- 	lavender = "#B4BEFE",
--
-- 	text = "#CDD6F4",
-- 	subtext1 = "#BAC2DE",
-- 	subtext0 = "#A6ADC8",
-- 	overlay2 = "#9399B2",
-- 	overlay1 = "#7F849C",
-- 	overlay0 = "#6C7086",
-- 	surface2 = "#585B70",
-- 	surface1 = "#45475A",
-- 	surface0 = "#313244",
--
-- 	base = "#1E1E2E",
-- 	mantle = "#181825",
-- 	crust = "#11111B",
-- }
--
-- return color_palette
