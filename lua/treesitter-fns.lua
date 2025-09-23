local ts = vim.treesitter
local parsers = require 'nvim-treesitter.parsers'
local utils = require 'nvim-treesitter.ts_utils'

local t = function(node)
  p(ts.get_node_text(node, 0))
end

p = function(v)
  print(vim.inspect(v))
  return v
end

local M = {}

function M.setup()
  -- Get Full Path to node
  -- @param node
  -- @param array?
  -- @return string
  local function get_full_path(node, array)
    local parent = node:parent()
    if parent == nil then
      if array == nil then
        return node:type()
      end
      local reverse = vim.tbl_map(function(index)
        return array[#array + 1 - index]:type()
      end, vim.tbl_keys(array))
      return table.concat(reverse, " -> ")
    end
    return get_full_path(parent, vim.list_extend(array or {}, { node }))
  end
  -- Helper function to get node at cursor
  function M.get_node_at_cursor()
    local node = utils.get_node_at_cursor()
    return node
  end

  -- Helper function to get node text
  function M.get_node_text()
    t(M.get_node_at_cursor())
  end

  ---gets element node parent of node
  ---@param arg_node TSNode
  ---@return TSNode|nil
  function M.get_element_node(arg_node)
    local node = arg_node
    local parent = node:parent()
    while node and node:type() ~= "element" and parent do
      node = parent
      parent = node:parent()
    end
    if node and node:type() == "element" then
      return node
    else
      p('no element found at cursor')
      return nil
    end
  end

  function M.get_element_node_at_cursor()
    local node = M.get_node_at_cursor()
    while node and node:type() ~= "element" and node:parent() do
      node = node:parent()
    end
    if node and node:type() == "element" then
      t(node)
    else
      p('no element found at cursor')
    end
  end

  function M.get_checkboxes()
    local qs = [[
    ((tag_name) @name (#match? @name "p-checkbox")) @capture
    ]]
    local parser = parsers.get_parser()
    local query = ts.query.parse(parser:lang(), qs)
    local root = parser:parse()[1]:root()
    for _, matches, _ in query:iter_matches(root, 0) do
      for _, match in ipairs(matches[1]) do
        local checkbox_node = M.get_element_node(match)
        if checkbox_node then
          p(checkbox_node:child_count())
        else
          p('no element node found for this match (?)')
        end
      end
    end
  end

  -- Helper function to find attribute node by name
  function M.find_attribute_node(element_node, attr_name)
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
  end
end

return M
