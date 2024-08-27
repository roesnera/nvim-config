local function cmd(command)
  return table.concat({ '<Cmd>', command, '<CR>' })
end
return {
  'anuvyklack/windows.nvim',
  dependencies = { 'anuvyklack/middleclass', 'anuvyklack/animation.nvim' },
  config = function ()
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false
    require('Windows').setup()
  end,
  keys = {
    {
      '<C-w>m',
      cmd 'WindowsMaximize',
      desc = '[M]aximize current [W]indow'
    },
    {
      '<C-w>_',
      cmd 'WindowsMaximizeVertically',
      desc = 'Maximize current [W]indow [V]ertically'
    },
    {
      '<C-w>|',
      cmd 'WindowsMaximizeHorizontally',
      desc = 'Maximize current [W]indow [H]orizontally'
    },
    {
      '<C-w>=',
      cmd 'WindowsEqualize',
      desc = '[E]qualize all [W]indows'
    },
  }
}
