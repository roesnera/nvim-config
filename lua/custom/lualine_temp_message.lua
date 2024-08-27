local M = {}

local temp_messages = {}
local timer = nil

local function update_lualine_section()
  local content = ''
  for _, msg in ipairs(temp_messages) do
    content = content .. ' | ' .. msg.text
  end

  -- Debug print

  require('lualine').refresh {
    place = { 'statusline' },
    scope = { 'custom_section' },
  }

  return content
end

function M.append_temp_message(message, duration)
  table.insert(temp_messages, { text = message, expires = os.time() + duration })

  if timer then
    timer:stop()
  end
  timer = vim.loop.new_timer()
  timer:start(
    1000,
    1000,
    vim.schedule_wrap(function()
      local current_time = os.time()
      local updated = false

      for i = #temp_messages, 1, -1 do
        if current_time >= temp_messages[i].expires then
          table.remove(temp_messages, i)
          updated = true
        end
      end

      if updated then
        update_lualine_section()
      end

      if #temp_messages == 0 then
        timer:stop()
        timer = nil
      end
    end)
  )

  update_lualine_section()
end

function M.get_current_content()
  local content = update_lualine_section()
  return content
end

return M
