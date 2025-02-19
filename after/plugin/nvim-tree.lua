require("nvim-tree").setup {
    update_focused_file = {
        enable = true,
        update_root = true,
    }
    
  }
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {desc = "Toggle Nvim-tree"})
