return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#15140c',
				base01 = '#15140c',
				base02 = '#88877e',
				base03 = '#88877e',
				base04 = '#dcdbcf',
				base05 = '#fffef8',
				base06 = '#fffef8',
				base07 = '#fffef8',
				base08 = '#ffa99f',
				base09 = '#ffa99f',
				base0A = '#e6de8d',
				base0B = '#affba3',
				base0C = '#fffaca',
				base0D = '#e6de8d',
				base0E = '#fff7ad',
				base0F = '#fff7ad',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#88877e',
				fg = '#fffef8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#e6de8d',
				fg = '#15140c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#88877e' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#fffaca', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#fff7ad',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#e6de8d',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#e6de8d',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#fffaca',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#affba3',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#dcdbcf' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#dcdbcf' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#88877e',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
