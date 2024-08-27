return {
	'stevearc/oil.nvim',
	opts = {},
	dependencies = { { 'echasnovski/mini.icons', opts = {} } },
	config = function()
		require('oil').setup({
		view_options = {
				show_hidden = true
			}
		})
	end
}
