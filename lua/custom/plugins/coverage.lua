return {
  'andythigpen/nvim-coverage',
  requires = 'nvim-lua/plenary.nvim',
  version = '*',
  config = function()
    require('coverage').setup {
      commands = true, -- create commands
      highlights = {
        -- customize highlight groups created by the plugin
        covered = { fg = '#C3E88D' }, -- supports style, fg, bg, sp (see :h highlight-gui)
        uncovered = { fg = '#F07178' },
      },
      signs = {
        -- use your own highlight groups or text markers
        covered = { hl = 'CoverageCovered', text = '▎' },
        uncovered = { hl = 'CoverageUncovered', text = '▎' },
      },
      summary = {
        -- customize the summary pop-up
        min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
      },
      lang = {
        -- customize language specific settings
      },
    }
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      pattern = { '*.ts', '*.js', '*.mjs' },
      callback = function()
        vim.api.nvim_cmd({ cmd = 'CoverageLoad' }, {})
      end,
    })
    vim.keymap.set('n', '<leader>tr', ':CoverageToggle<CR>', { desc = '[T]oggle coverage [r]eport' })
  end,
}
