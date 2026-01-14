-- Global variables (vim.g)
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- General options (vim.opt)
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Text wrapping and line breaking
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Search and UI behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 4
vim.opt.mouse = "a"
-- vim.opt.signcolumn = "yes"
-- vim.opt.colorcolumn = "80"

-- Search feedback and performance
vim.opt.hlsearch = true
vim.opt.inccommand = "split" -- Preview increments of substitute (:s/old/new) in a split window
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Folding (consistent with nvim-ufo or manual folding)
vim.opt.foldenable = true
vim.opt.foldmethod = "manual"
vim.opt.foldlevel = 99

-- Undo persistence
vim.opt.undofile = true

-- Autocommands for specific filetypes (Text, Markdown, Gitcommit)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "text", "markdown", "gitcommit" },
	callback = function()
		vim.opt_local.textwidth = 80
		vim.opt_local.formatoptions:append("t") -- Auto-wrap text using textwidth
		vim.opt_local.smartindent = false
	end,
})

-- Allow certain keys to move the cursor to the previous/next line
vim.opt.whichwrap:append("<,>,[,],h,l")
