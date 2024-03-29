-- ----------------------
-- Local helper functions
-- ----------------------
--
local M = {}

function M.scnvim_send(cmd)
	require("scnvim").send(cmd)
end

--------------------
--  small things  --
--------------------

-- Load superCollider files
function M.load_file(file)
	local sccode = string.format("\"%s\".load", file)
	M.scnvim_send(sccode)
end

function M.load_file_relative(file)
	local sccode = string.format("\"%s\".loadRelative", file)
	M.scnvim_send(sccode)
end

function M.load_main()
	M.load_file("main.scd")
end

-- ----------------------
-- Lua utilities
-- ----------------------

function M.tbl_len(T)
	local count = 0
	for _ in pairs(T) do
		count = count + 1
	end
	return count
end

function M.terminal(cmd)
		vim.cmd("term " .. cmd)
end

function M.shell(command)
	local lines = {}
    local file = io.popen(command)

    for line in file:lines() do
        table.insert(lines, line)
    end

    file:close()

    return lines
end

-- ----------------------
-- Paths and filesystem
-- ----------------------

--- Check if a file or directory exists in this path
function M.exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Check if a directory exists in this path
function M.isdir(path)
   -- "/" works on both Unix and Windows
   return M.exists(path.."/")
end

function M.home()
	return vim.loop.os_homedir()
end

--- Get the root directory of the plugin.
-- This is taken from scnvim (thanks David!)

local path_sep = vim.loop.os_uname().sysname:match('Windows') and '\\' or '/'

function M.get_plugin_root_dir()
  local package_path = debug.getinfo(1).source:gsub('@', '')
  package_path = vim.split(package_path, path_sep, true)
  -- find index of plugin root dir
  local index = 1
  for i, v in ipairs(package_path) do
    if v == 'supercollider-h4x-nvim' then
      index = i
      break
    end
  end
  local path_len = M.tbl_len(package_path)
  if index == 1 or index == path_len then
    error('[supercollider-h4x-nvim] could not find plugin root dir')
  end
  local path = {}
  for i, v in ipairs(package_path) do
    if i > index then
      break
    end
    path[i] = v
  end
  local dir = ''
  for _, v in ipairs(path) do
    -- first element is empty on unix
    if v == '' then
      dir = path_sep
    else
      dir = dir .. v .. path_sep
    end
  end
  assert(dir ~= '', '[supercollider-h4x-nvim] Could not get supercollider-h4x-nvim root path')
  dir = dir:sub(1, -2) -- delete trailing slash
  return dir
end

M.supercollider_h4x_nvim_root_dir = M.get_plugin_root_dir()

-- ----------------------
-- Cookiecutter stuff
-- ----------------------

-- Cookiecutter templates
-- requires https://github.com/cookiecutter/cookiecutter
function M.cookiecutter(url, output_dir)
	-- local cmd = "cookiecutter " .. url .. " -o " .. output_dir
	local cmd = string.format("cookiecutter %s -o %s", url, output_dir)
	local executable = vim.call("executable", "cookiecutter")
	if executable == 1 then
		M.terminal(cmd)
	else
		vim.api.nvim_err_writeln("cookiecutter not executable!")
	end
end

-- ----------------------
-- Fuzzy find
-- ----------------------

function M.fzf(sources, sinkfunc, custom_options)
	-- Deprecation warning
	error("supercollider-h4x-nvim: All fuzzy searchers in this plugin are deprecated and will be removed. Use fzf-sc instead.")
end

-- Unpack csv file with tags into lua table
function M.scnvim_unpack_tags_table()
	local root = vim.g.scnvim_root_dir
	local classes = root .. "/scnvim-data/tags"
	local tagsfile = io.open(classes)
	local help = {}

	for line in tagsfile:lines() do
		local tagname, tagpath, _, _= line:match("%s*(.-)\t%s*(.-)\t%s*(.-)\t%s*(.-)")
		help[tostring(tagname)] = tagpath
		-- print(tagname)
	end

	return help
end

function M.scnvim_help_keys()
	local help = M.scnvim_unpack_tags_table()
	local help_keys = {};

	for k,_ in pairs(help) do
		table.insert(help_keys, tostring(k))
	end

	return help_keys
end

function M.scnvim_help_win_id()
	local id = vim.g.scnvim_user_settings.help_window.id
	return id
end

function M.scnvim_set_help_win_id(id)
	-- vim.g.scnvim_user_settings.help_window.id = id
	vim.cmd("let g:scnvim_user_settings.help_window.id=" .. id)
end

function M.scnvim_prep_help(subject)
	M.scnvim_send("SCNvim.prepareHelpFor(" .. subject .. ")")
end

return M
