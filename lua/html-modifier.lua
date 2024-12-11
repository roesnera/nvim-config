local M = {}

function M.setup()
  -- Helper function to get node at cursor
  local function get_node_at_cursor()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]
    local parser = vim.treesitter.get_parser(bufnr, 'html')
    local tree = parser:parse()[1]
    return tree:root():named_descendant_for_range(row, col, row, col)
  end

  -- Helper function to get node text
  local function get_node_text(node)
    local bufnr = vim.api.nvim_get_current_buf()
    return vim.treesitter.get_node_text(node, bufnr)
  end

  -- Helper function to find attribute node by name
  local function find_attribute_node(element_node, attr_name)
    for child in element_node:iter_children() do
      if child:type() == 'attribute' then
        local name_node = child:field('name')[1]
        if name_node and get_node_text(name_node) == attr_name then
          return child
        end
      end
    end
    return nil
  end

  -- Main function to modify HTML element
  function M.modify_element()
    local node = get_node_at_cursor()
    if not node then
      return
    end

    -- Find parent element node
    while node and node:type() ~= 'element' do
      local current_node = node:parent()
      if not current_node then
        print 'No HTML element found at cursor'
        return
      end
      node = current_node:parent()
    end
    if not node then
      print 'No HTML element found at cursor'
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd "normal! m'" -- Set mark for undo

    -- 1. Handle ID attribute
    local id_node = find_attribute_node(node, 'id')
    local template_ref_value = nil
    if id_node then
      local id_value = get_node_text(id_node:field('value')[1])
      id_value = id_value:gsub('"', '') -- Remove quotes
      template_ref_value = id_value

      -- Add #templateRef
      local start_row, start_col = node:start()
      local element_text = get_node_text(node)
      local tag_name_end = element_text:find '%s' or element_text:find '>'
      if tag_name_end then
        vim.api.nvim_buf_set_text(
          bufnr,
          start_row,
          start_col + tag_name_end - 1,
          start_row,
          start_col + tag_name_end - 1,
          { string.format(' #%s', template_ref_value) }
        )
      end

      -- Delete ID attribute
      local id_start_row, id_start_col = id_node:start()
      local id_end_row, id_end_col = id_node:end_()
      vim.api.nvim_buf_set_text(bufnr, id_start_row, id_start_col, id_end_row, id_end_col, { '' })
    end

    -- 2. Remove [for] binding
    local for_node = find_attribute_node(node, '[for]')
    if for_node then
      local for_start_row, for_start_col = for_node:start()
      local for_end_row, for_end_col = for_node:end_()
      vim.api.nvim_buf_set_text(bufnr, for_start_row, for_start_col, for_end_row, for_end_col, { '' })
    end

    -- 3. & 4. Handle child element
    for child in node:iter_children() do
      if child:type() == 'element' then
        -- Remove specified properties
        local props_to_remove = {
          'uniqId',
          '[inputId]',
          function(name)
            return name:match '#.*="uniqId"'
          end,
        }

        for _, prop in ipairs(props_to_remove) do
          local prop_node
          if type(prop) == 'function' then
            -- Handle pattern matching case
            for attr in child:iter_children() do
              if attr:type() == 'attribute' then
                local attr_text = get_node_text(attr)
                if prop(attr_text) then
                  prop_node = attr
                  break
                end
              end
            end
          else
            prop_node = find_attribute_node(child, prop)
          end

          if prop_node then
            local prop_start_row, prop_start_col = prop_node:start()
            local prop_end_row, prop_end_col = prop_node:end_()
            vim.api.nvim_buf_set_text(bufnr, prop_start_row, prop_start_col, prop_end_row, prop_end_col, { '' })
          end
        end

        -- Add ariaLabelledBy if we have a template reference
        if template_ref_value then
          local child_start_row, child_start_col = child:start()
          local child_text = get_node_text(child)
          local tag_name_end = child_text:find '%s' or child_text:find '>'
          if tag_name_end then
            vim.api.nvim_buf_set_text(
              bufnr,
              child_start_row,
              child_start_col + tag_name_end - 1,
              child_start_row,
              child_start_col + tag_name_end - 1,
              { string.format(' [ariaLabelledBy]="%s.id"', template_ref_value) }
            )
          end
        end

        break -- Only process first child
      end
    end

    vim.cmd "normal! `'" -- Return to original position
  end
end

return M
