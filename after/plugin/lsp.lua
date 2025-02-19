local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.ensure_installed({
	"pyright", "marksman", "ruff", "clangd"
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local luasnip = require("luasnip")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace, }),
	["<C-Space>"] = cmp.mapping.complete(),
	['<Tab>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_locally_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { 'i', 's' }),

	['<S-Tab>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.locally_jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { 'i', 's' }),

})


lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{
			name = 'cmdline',
			option = {
				ignore_cmds = { 'Man', '!' }
			}
		}
	})
})

lsp.on_attach(function(client, bufnr)
	if client.name == "pylsp" then
		client.server_capabilities.renameProvider = false
	end
	local opts = { buffer = bufnr, remap = false }
	lsp.buffer_autoformat()
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts, { desc = "Go to definition" })
	vim.keymap.set("n", "<leader>gr", require('telescope.builtin').lsp_references, { desc = "Go to references" })
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts, { desc = "Next diagnostic" })
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts, { desc = "Previous diagnostic" })
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts, { desc = "Code action" })
	vim.keymap.set("n", "<leader>n", function() vim.lsp.buf.rename() end, opts, { desc = "Rename" })
end)

require("lspconfig").pyright.setup({})

require("lspconfig").ruff.setup({})

require("lspconfig").clangd.setup({})

lsp.setup()

-- require("neodev").setup()

vim.diagnostic.config({
	virtual_text = true
})
