-- surround ----------------
vim.keymap.set("v", "<leader>sb", "c****<Esc>hhp", {desc="bold the selection"});
vim.keymap.set("v", "<leader>s$", "c$$<Esc>P", {desc="surround selection with ($)"})
vim.keymap.set("v", "<leader>ss`", "c``````<Esc>hhhpT`i<CR><Esc>f`i<CR><Esc>ea<CR><Esc>", {desc="surround selection with (```)"})
vim.keymap.set("v", "<leader>ss$", "c$$$$<Esc>hhpT$i<CR><Esc>f$i<CR><Esc>ea<CR><Esc>", {desc="surround selection with ($$)"})
vim.keymap.set("n", "<leader>ss`", "i``````<Esc>hhi<CR><Esc>kA ", {desc="create (```) block"});
vim.keymap.set("n", "<leader>ss$", "i$$$$<Esc>hi<CR><CR><Esc>kA", {desc="create ($$) block"});
