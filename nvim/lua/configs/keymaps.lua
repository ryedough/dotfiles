vim.opt.timeoutlen = 500

vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

---- Surround ----
vim.keymap.set("v", "<leader>s(", "c()<Esc>hp", {desc = "Surround selection with ()"})
vim.keymap.set("v", "<leader>s{", "c{}<Esc>hp", {desc = "Surround selection with {}"})
vim.keymap.set("v", '<leader>s"', 'c""<Esc>hp', {desc = "Surround selection with {}"})
vim.keymap.set("v", "<leader>s'", 'c""<Esc>hp', {desc = "Surround selection with {}"})
vim.keymap.set("v", '<leader>s`', 'c``<Esc>hp', {desc = "Surround selection with {}"})

-- LSP ---------------------
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "get symbol docs"})
--- Addon Keybinds ---------
----------------------------
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bl", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bh", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<A-h>", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", "<A-l>", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	print("file:", path)
end, { desc = "Show full file path" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
