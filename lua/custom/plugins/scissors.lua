return {
  'chrisgrieser/nvim-scissors',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
    },
  },
  opts = {
    snippetDir = '~/.config/nvim/snippetDir',
  },
  keys = {
    {
      '<leader>sa',
      ':ScissorsAddNewSnippet<CR>',
      desc = '[A]dd a new [s]nippet',
    },
    {
      '<leader>se',
      ':ScissorsEditSnippet<CR>',
      desc = '[E]dit a [s]nippet',
    },
  },
}
