---@diagnostic disable: undefined-global
(function()
	return {
		options = {
			theme = "auto",
			globalstatus = false,
			ignore_focus = { "atone" },
			disabled_filetypes = {
				statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard", "atone" },
				winbar = { "dashboard", "alpha", "ministarter", "snacks_dashboard", "oil", "atone" },
			},
		},
		winbar = {
			lualine_a = {},
			lualine_b = { { "filename", path = 1 } },
			lualine_c = { { "navic", navic_opts = { icons = nvf_icons.kinds } } },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"diagnostics",
					symbols = {
						error = nvf_icons.diagnostics.Error,
						warn = nvf_icons.diagnostics.Warn,
						info = nvf_icons.diagnostics.Info,
						hint = nvf_icons.diagnostics.Hint,
					},
				},
				{ "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
				{ "lsp_status" },
			},
			lualine_x = {
				Snacks.profiler.status(),
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = function() return { fg = Snacks.util.color("Statement") } end,
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = function() return { fg = Snacks.util.color("Constant") } end,
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = function() return { fg = Snacks.util.color("Debug") } end,
        },
        -- stylua: ignore
        {
          "diff",
          symbols = {
            added = nvf_icons.git.added,
            modified = nvf_icons.git.modified,
            removed = nvf_icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
			},
			lualine_y = {
				{ "progress", separator = " ", padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
			lualine_z = {
				function()
					return " " .. os.date("%R")
				end,
			},
		},
		extensions = { "fzf" },
	}
end)()
