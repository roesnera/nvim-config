local bufnr = vim.api.nvim_get_current_buf
return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false,
  keys = {
    {
      '<leader>a',
      function()
        vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
      end,
      desc = 'Rust [A]ttach',
      { silent = true, buffer = bufnr() },
    },
    {
      'K',
      function ()
        vim.cmd.RustLsp {'hover', 'actions'}
      end,
      { silent = true, buffer = bufnr() },
    },
  },
}
