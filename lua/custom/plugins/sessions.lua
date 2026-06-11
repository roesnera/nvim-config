---@type string
local path = '~/.config/nvim/sessions/'
---@type vim.api.keyset.user_command
local customConfig = {
  nargs = 1,
  complete = function()
    local suggestions = {}
    for file in io.popen('ls ' .. path):lines() do
      table.insert(suggestions, file)
    end
    return suggestions
  end,
}
return {
  'tpope/vim-obsession',
  init = function()
    vim.api.nvim_create_user_command('Sesh', function(opts)
      ---@type string
      local sessionName = opts.fargs[1]
      ---@type string
      local fullSeshPath = path .. sessionName
      vim.cmd.Obsess { fullSeshPath }
    end, customConfig)
  end,
}
