local lualine_temp_message = require "custom.lualine_temp_message"
local detail = false
local git_ignored = setmetatable({}, {
  __index = function(self, key)
    local proc = vim.system({ 'git', 'ls-files', '--ignored', '--exclude-standard', '--others', '--directory' }, {
      cwd = key,
      text = true,
    })
    local result = proc:wait()
    local ret = {}
    if result.code == 0 then
      for line in vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true }) do
        -- Remove trailing slash
        line = line:gsub('/$', '')
        table.insert(ret, line)
      end
    end

    rawset(self, key, ret)
    return ret
  end,
})
local show_ignored = false
local set_is_hidden_including_gitignore = function(name, _)
  -- dotfiles are always considered hidden
  if vim.startswith(name, '.') then
    return true
  end
  local dir = require('oil').get_current_dir()
  -- if no local directory (e.g. for ssh connections), always show
  if not dir then
    return false
  end
  -- Check if file is gitignored
  return vim.list_contains(git_ignored[dir], name)
end
local set_is_hidden_without_gitignore = function(name, _)
  if vim.startswith(name, '.') then
    return true
  end
  return false
end

return {
  opts = {},
  'stevearc/oil.nvim',
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  config = function()
    require('oil').setup {
      keymaps = {
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
        ['ti'] = {
          desc = 'Toggle show/hide gitignored files',
          callback = function()
            show_ignored = not show_ignored
            if show_ignored then
              require('oil').set_is_hidden_file(set_is_hidden_without_gitignore)
              lualine_temp_message.append_temp_message('Gitignored files hidden', 2)
            else
              require('oil').set_is_hidden_file(set_is_hidden_including_gitignore)
              lualine_temp_message.append_temp_message('Gitignored files shown', 2)
            end
          end,
        },
      },
      view_options = {
        show_hidden = true,
        is_hidden_file = set_is_hidden_including_gitignore,
      },
    }
  end,
}
