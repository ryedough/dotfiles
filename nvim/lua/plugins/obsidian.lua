vim.pack.add({
    "https://github.com/epwalsh/obsidian.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
})

vim.cmd("packadd plenary.nvim")
vim.cmd("packadd obsidian.nvim")

require("obsidian").setup({
    workspaces = {
        {
            name = "personal",
            path = "~/Studies/obsidian_vault/personal"
        }
    }
})
