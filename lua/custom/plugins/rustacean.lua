local map = vim.keymap.set
return {
  'mrcjkb/rustaceanvim',
  version = '^9',
  init = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {},
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- you can also put keymaps in here
          map('n', '<leader>a', function()
            vim.cmd.RustLsp { 'codeAction' }
          end, { desc = 'Rust code [A]ctions', silent = true, buffer = vim.api.nvim_get_current_buf() })
          map('n', '<leader>e', function()
            vim.cmd.RustLsp { 'expandMacro' }
          end, { silent = true, buffer = vim.api.nvim_get_current_buf(), desc = 'Rust macro [e]xpand' })
          map('n', 'K', function()
            vim.cmd.RustLsp { 'hover', 'actions' }
          end, { silent = true, buffer = vim.api.nvim_get_current_buf(), desc = 'Rust hover actions' })
          map('n', '<A-k>', function()
            vim.cmd.RustLsp { 'renderDiagnostic', 'current' }
          end, { silent = true, buffer = vim.api.nvim_get_current_buf(), desc = 'Open diagnostic under cursor' })
          map('n', '<C-e>', function()
            vim.cmd.RustLsp { 'explainError', 'current' }
          end, { silent = true, buffer = vim.api.nvim_get_current_buf(), desc = 'Explain error under cursor' })
          map('n', '<leader>rm', function()
            vim.cmd.RustLsp { 'rebuildProcMacros' }
          end, { silent = true, buffer = vim.api.nvim_get_current_buf(), desc = '[R]ebuild proc [m]acros' })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {},
        },
      },
      -- DAP configuration
      dap = {},
    }
  end,
  lazy = false,
}
