local opts = { noremap = true, silent = true }
return {
  'fedepujol/move.nvim',
  opts = opts,
  config = function()
    require('move').setup {
      block = {
        enable = true,
        indent = true,
      },
      line = {
        enable = true,
        indent = true,
      },
      word = {
        enable = true,
      },
      char = {
        enable = false,
      },
    }
  end,
  keys = {
    {
      '<A-j>',
      ':MoveLine(1)<CR>',
      opts,
    },
    {
      '<A-k>',
      ':MoveLine(-1)<CR>',
      opts,
    },
    {
      '<A-h>',
      ':MoveHLine(-1)<CR>',
      opts,
    },
    {
      '<A-l>',
      ':MoveHLine(1)<CR>',
      opts,
    },
    {
      '<leader>wf',
      ':MoveWord(1)<CR>',
      opts,
    },
    {
      '<leader>wb',
      ':MoveWord(-1)<CR>',
      opts,
    },
    {
      '<C-j>',
      ':MoveBlock(1)<CR>',
      mode = 'v',
      opts,
    },
    {
      '<C-k>',
      ':MoveBlock(-1)<CR>',
      mode = 'v',
      opts,
    },
    {
      '<C-h>',
      ':MoveHBlock(-1)<CR>',
      mode = 'v',
      opts,
    },
    {
      '<C-l>',
      ':MoveHBlock(1)<CR>',
      mode = 'v',
      opts,
    },
  },
}
