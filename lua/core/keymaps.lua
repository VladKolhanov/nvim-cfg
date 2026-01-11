-- =============================================================================
-- LEADER KEY & GLOBAL OPTIONS
-- =============================================================================

-- Set Space as the main leader and local leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable default spacebar behavior (so it doesn't move cursor when used as leader)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Common options for most keymaps
local opts = { noremap = true, silent = true }


-- =============================================================================
-- FILE OPERATIONS
-- =============================================================================

-- Save current file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- Save file without triggering autocommands (useful to skip auto-formatting)
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- Make the current file executable (chmod +x)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

-- Reload configuration by sourcing the current file
vim.keymap.set("n", "<leader><leader>", ":source %<CR>", opts)


-- =============================================================================
-- WINDOW & SPLIT MANAGEMENT
-- =============================================================================

-- Quick window navigation (use Ctrl + h/j/k/l to switch between splits)
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)
 
-- Split management: vertical, horizontal, equal size, and close
vim.keymap.set("n", "<leader>sv", "<C-w>v", opts) -- Vertical split
vim.keymap.set("n", "<leader>sh", "<C-w>s", opts) -- Horizontal split
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- Make all splits equal size
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", opts) -- Close current split

-- Resize splits using arrow keys
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)


-- =============================================================================
-- TAB MANAGEMENT
-- =============================================================================

-- Tab controls: open, close, navigate, and "zoom" (open current buffer in new tab)
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", opts)
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", opts)
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", opts)
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", opts)


-- =============================================================================
-- EDITOR NAVIGATION & SCROLLING
-- =============================================================================

-- Center the screen after jumping half a page down/up
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Keep search results centered in the middle of the screen
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Toggle line wrapping on and off
vim.keymap.set('n', '<leader>lw', function()
    vim.opt.wrap = not vim.opt.wrap:get()
end, opts)


-- =============================================================================
-- TEXT EDITING & MANIPULATION
-- =============================================================================

-- Move selected lines up or down (gv=gv maintains selection and fixes indent)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Join lines below to the current line but keep cursor at its original position
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Search and replace the word under cursor globally in the current file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Indent or unindent while staying in visual mode (no need to re-select)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Disable Ex-mode (triggered by Q) to avoid accidental UI lock
vim.keymap.set("n", "Q", "<nop>", opts)


-- =============================================================================
-- CLIPBOARD & REGISTER MANAGEMENT
-- =============================================================================

-- Paste over visual selection without losing the yanked text to the "black hole"
vim.keymap.set('v', 'p', '"_dP', opts)
-- vim.keymap.set("x", "<leader>p", [["_dP]], opts)

-- Copy (Yank) entire line to the system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)

-- Delete text into the "black hole" register to preserve your current yank
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Make 'x' (delete character) also use the black hole register
vim.keymap.set("n", "x", '"_x', opts)


-- =============================================================================
-- LSP & DIAGNOSTICS
-- =============================================================================

-- Jump between diagnostic messages (errors/warnings)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)

-- Show diagnostics in a list (loclist)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use built-in LSP to format the current buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)

-- Toggle visibility of LSP diagnostics (virtual text and underlines)
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible
    })
end, opts)


-- =============================================================================
-- MISCELLANEOUS / UI
-- =============================================================================

-- Use Ctrl-c as Escape to exit insert mode or clear search highlights
vim.keymap.set("i", "<C-c>", "<Esc>", opts)
vim.keymap.set("n", "<C-c>", ":nohl<CR>", opts)

-- Copy current file path (relative to home) to system clipboard
vim.keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filePath)
    print("File path copied to clipboard: " .. filePath)
end, opts)

-- Switch projects via tmux-sessionizer (external script)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- Highlight text momentarily after it is yanked (copied)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
