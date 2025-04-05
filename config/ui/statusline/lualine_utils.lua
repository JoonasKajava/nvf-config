Lualine_utils = {
	---@type table<number, string>
	cache = {},
	spec = { "lsp", { ".git", "lua" }, "cwd" },
}

---@param opts? {cwd:false, subdirectory: true, parent: true, other: true, icon?:string}
Lualine_utils.root_dir = function(opts)
	opts = vim.tbl_extend("force", {
		cwd = false,
		subdirectory = true,
		parent = true,
		other = true,
		icon = "󱉭 ",
		color = function()
			return { fg = Snacks.util.color("Special") }
		end,
	}, opts or {})

	local function get()
		local cwd = Lualine_utils.cwd()
		local root = Lualine_utils.get({ normalize = true })
		local name = vim.fs.basename(root)

		if root == cwd then
			-- root is cwd
			return opts.cwd and name
		elseif root:find(cwd, 1, true) == 1 then
			-- root is subdirectory of cwd
			return opts.subdirectory and name
		elseif cwd:find(root, 1, true) == 1 then
			-- root is parent directory of cwd
			return opts.parent and name
		else
			-- root and cwd are not related
			return opts.other and name
		end
	end

	return {
		function()
			return (opts.icon and opts.icon .. " ") .. get()
		end,
		cond = function()
			return type(get()) == "string"
		end,
		color = opts.color,
	}
end

Lualine_utils.cwd = function()
	return Lualine_utils.realpath(vim.uv.cwd()) or ""
end

Lualine_utils.realpath = function(path)
	if path == "" or path == nil then
		return nil
	end
	path = vim.uv.fs_realpath(path) or path
	return Lualine_utils.norm(path)
end

---@return string
Lualine_utils.norm = function(path)
	if path:sub(1, 1) == "~" then
		local home = vim.uv.os_homedir()
		if home:sub(-1) == "\\" or home:sub(-1) == "/" then
			home = home:sub(1, -2)
		end
		path = home .. path:sub(2)
	end
	path = path:gsub("\\", "/"):gsub("/+", "/")
	return path:sub(-1) == "/" and path:sub(1, -2) or path
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? {normalize?:boolean, buf?:number}
---@return string
Lualine_utils.get = function(opts)
	opts = opts or {}
	local buf = opts.buf or vim.api.nvim_get_current_buf()
	local ret = Lualine_utils.cache[buf]
	if not ret then
		local roots = M.detect({ all = false, buf = buf })
		ret = roots[1] and roots[1].paths[1] or vim.uv.cwd()
		Lualine_utils.cache[buf] = ret
	end
	if opts and opts.normalize then
		return ret
	end
	return ret
end
