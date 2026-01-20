local map = vim.keymap.set
map('n', '<leader>a', '<cmd>RustLsp codeAction<CR>', { desc = 'Rust code [A]ctions', silent = true, buffer = vim.api.nvim_get_current_buf() })
map('n', '<leader>e', '<cmd>RustLsp expandMacro<CR>', { silent = true, buffer = vim.api.nvim_get_current_buf(), desc = 'Rust macro [e]xpand' })
map('n', 'K', function()
  vim.cmd.RustLsp { 'hover', 'actions' }
end, { silent = true, buffer = vim.api.nvim_get_current_buf() })
