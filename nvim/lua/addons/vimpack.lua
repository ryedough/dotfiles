function vim.pack.list()
    for _, p in ipairs(vim.pack.get()) do print(p.spec.name) end
end
