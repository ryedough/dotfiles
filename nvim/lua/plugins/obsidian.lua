vim.pack.add({
    "https://github.com/obsidian-nvim/obsidian.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
})

vim.cmd("packadd plenary.nvim")
vim.cmd("packadd obsidian.nvim")

require("obsidian").setup({
    legacy_commands = false,
    workspaces = {
        {
            name = "personal",
            path = "~/Studies/obsidian_vault/personal"
        }
    }
})
