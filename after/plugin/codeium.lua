-- vim.g.codeium_disable_bindings = 1
vim.keymap.set('i', '<C-d>', function() return vim.fn['codeium#Accept']() end, { expr = true })
vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
