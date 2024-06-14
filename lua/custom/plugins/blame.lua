return {
  'f-person/git-blame.nvim',
  config = function()
    require('gitblame').setup {
      enabled = false,
      virtual_text_column = 80,
    }
  end,
  keys = {
    {
      '<leader>tb',
      ':GitBlameToggle<CR>',
      desc = '[T]oggle Git [B]lame',
    },
  },
}
