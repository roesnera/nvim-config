return {
  'stevearc/conform.nvim',
  lazy = false,
  opts = {},
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt', lsp_format = 'fallback' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }
    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format { async = true, lsp_format = 'fallback', range = range }
    end, { range = true })
    vim.api.nvim_create_user_command('ListFormatters', function()
      local P = function(v)
        local out = ''
        for _, val in ipairs(v) do
          if val.available then
            out = out .. ' | ' .. val.command
          end
        end
        print(out)
        return v
      end
      P(require('conform').list_formatters(0))
    end, {})
  end,
  keys = {
    {
      '<leader>f',
      ':Format<CR>',
      desc = '[F]ormat current buffer',
    },
    {
      '<leader>lf',
      ':ListFormatters<CR>',
      desc = '[L]ist [f]ormatters for current buffer',
    },
  },
}
