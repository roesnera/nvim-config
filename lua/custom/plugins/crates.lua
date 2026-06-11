local opts = { silent = true }
return {
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  config = function()
    require('crates').setup()
  end,
  keys = {
    { '<leader>ct', ':Crates toggle<cr>', desc = '[T]oggle [c]rates' },
    { '<leader>cr', ':Crates reload<cr>', desc = '[R]eload [c]rates' },

    { '<leader>cv', ':Crates show_versions_popup<cr>', desc = 'Show [c]rates [v]ersions popup' },
    { '<leader>cf', ':Crates show_features_popup<cr>', desc = 'Show [c]rates [f]eatures popup' },
    { '<leader>cd', ':Crates show_dependencies_popup<cr>', desc = 'Show [c]rates [d]ependencies popup' },
    { '<leader>ce', ':Crates focus_popup<cr>', desc = '[E]nter [c]rates popup' },

    { '<leader>cu', ':Crates update_crate<cr>', desc = '[U]pdate [c]rate under cursor' },
    { '<leader>cu', ':Crates update_crates<cr>', mode = 'v', opts, desc = '[U]pdate highlighted [c]rates' },
    { '<leader>ca', ':Crates update_all_crates<cr>', mode = 'n', opts, desc = 'Update [a]ll [c]rates' },
    { '<leader>cU', ':Crates upgrade_crate<cr>', mode = 'n', opts, desc = '[U]pgrade [c]rate under cursor' },
    { '<leader>cU', ':Crates upgrade_crates<cr>', mode = 'v', opts, desc = '[U]pgrade highlighted [c]rates' },
    { '<leader>cA', ':Crates upgrade_all_crates<cr>', mode = 'n', opts, desc = 'Upgrade [a]ll [c]rates' },

    { '<leader>cx', ':Crates expand_plain_crate_to_inline_table<cr>', mode = 'n', opts, desc = 'E[x]pand plain [c]rate to inline table' },
    { '<leader>cX', ':Crates extract_crate_into_table<cr>', mode = 'n', opts, desc = 'E[x]tract [c]rate to table' },

    { '<leader>cH', ':Crates open_homepage<cr>', mode = 'n', opts, desc = 'Open [c]rate [h]omepage' },
    { '<leader>cR', ':Crates open_repository<cr>', mode = 'n', opts, desc = 'Open [c]rate [r]epository' },
    { '<leader>cD', ':Crates open_documentation<cr>', mode = 'n', opts, desc = 'Open [c]rate [d]ocumentation' },
    { '<leader>cC', ':Crates open_cratesio<cr>', mode = 'n', opts, desc = 'Open [cc]rates io page' },
  },
}
