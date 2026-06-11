return {
  'cordx56/rustowl',
  version = '*', -- Latest stable version
  build = 'cargo install rustowl',
  lazy = false, -- This plugin is already lazy
  opts = {
    auto_enable = true,
    colors = {
      lifetime = '#90ee90', -- Light green
      imm_borrow = '#87ceeb', -- Sky blue
      mut_borrow = '#dda0dd', -- Plum
      move = '#f0e68c', -- Khaki
      call = '#ffd700', -- Gold
      outlive = '#ff6347', -- Tomato
    },
    client = {
      on_attach = function(_, buffer)
        vim.keymap.set('n', '<leader>ro', function()
          require('rustowl').toggle(buffer)
        end, { buffer = buffer, desc = 'Toggle RustOwl' })

        vim.keymap.set('n', '<leader>re', function()
          require('rustowl').enable(buffer)
        end, { buffer = buffer, desc = 'Enable RustOwl' })

        vim.keymap.set('n', '<leader>rd', function()
          require('rustowl').disable(buffer)
        end, { buffer = buffer, desc = 'Disable RustOwl' })
      end,
    },
  },
}
