vim.pack.add({
    "https://github.com/norcalli/nvim-colorizer.lua"
})

vim.cmd("packadd nvim-colorizer.lua")
require'colorizer'.setup()
