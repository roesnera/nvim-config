local M = {}

function M.setup()
  local function print_macros()
    for char=0,24,1 do
      print(char)
    end
  end

  local function load_macros()

  end
  M.print_macros = print_macros
  M.load_macros = load_macros
end

return M
