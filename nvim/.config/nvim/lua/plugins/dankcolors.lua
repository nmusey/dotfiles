return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
<<<<<<< HEAD
				base00 = '#101418',
				base01 = '#101418',
=======
				base00 = '#0f1417',
				base01 = '#0f1417',
>>>>>>> 4890571 (Hyprland updates)
				base02 = '#5c6370',
				base03 = '#5c6370',
				base04 = '#abb2bf',
				base05 = '#ffffff',
				base06 = '#ffffff',
				base07 = '#ffffff',
<<<<<<< HEAD
				base08 = '#e05f60',
				base09 = '#e05f60',
				base0A = '#a9d8ff',
				base0B = '#88e086',
				base0C = '#6279a8',
				base0D = '#a9d8ff',
				base0E = '#457f9e',
				base0F = '#457f9e',
=======
				base08 = '#e05f63',
				base09 = '#e05f63',
				base0A = '#98ddff',
				base0B = '#8ae086',
				base0C = '#5b7c9f',
				base0D = '#98ddff',
				base0E = '#3b8292',
				base0F = '#3b8292',
>>>>>>> 4890571 (Hyprland updates)
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#5c6370',
				fg = '#ffffff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
<<<<<<< HEAD
				bg = '#a9d8ff',
				fg = '#101418',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#5c6370' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#6279a8', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#457f9e',
=======
				bg = '#98ddff',
				fg = '#0f1417',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#5c6370' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#5b7c9f', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#3b8292',
>>>>>>> 4890571 (Hyprland updates)
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
<<<<<<< HEAD
				fg = '#a9d8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#a9d8ff',
=======
				fg = '#98ddff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#98ddff',
>>>>>>> 4890571 (Hyprland updates)
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
<<<<<<< HEAD
				fg = '#6279a8',
=======
				fg = '#5b7c9f',
>>>>>>> 4890571 (Hyprland updates)
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
<<<<<<< HEAD
				fg = '#88e086',
=======
				fg = '#8ae086',
>>>>>>> 4890571 (Hyprland updates)
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#abb2bf' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#abb2bf' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#5c6370',
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
