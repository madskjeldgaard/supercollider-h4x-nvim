-- A collection of hacks, functions and nice little extra things for working with
-- SuperCollider as well as developing source code and help files for the same.
--
-- The most important functions are accessible as commands (see the init() function below)
--
-- Almost all of these assume that you are working in scnvim
--
-- A lot of functions depend on external programs (each function will let you know if there is a problem):
-- - fzf or skim
-- - git
-- - python
-- - watchdog (pip install watchdog)
-- - cmake
--
-- by Mads Kjeldgaard , 2020
-- for Nvim => v0.5

-- ------------------
-- Get helper functions
-- ------------------
local utils = require('supercollider-h4x/utils')
local fzf = utils.fzf
local scnvim_unpack_tags_table = utils.scnvim_unpack_tags_table
local cookiecutter = utils.cookiecutter
local shell = utils.shell
local terminal = utils.terminal
local exists = utils.exists
local isdir = utils.isdir
local homedir = utils.home()

local M = {}

-- Init function
-- Run this to register commands that interface with the functions here
function M.setup()

	-- Load commands
	require('supercollider-h4x/commands')

	-- Option: choose fuzzy command ("fzf" or "skim")
	vim.g.scnvim_fuzzy_command = vim.g.scnvim_fuzzy_command or "fzf"

	-- Option: path to supercollider development source code for compiling plugins
	vim.g.sc_source_code = vim.g.sc_source_code or homedir .. "/supercollider"

	-- Option: Where to put a newly generated quark
	vim.g.sc_quark_path = vim.g.sc_quark_path or homedir .. "/.local/share/SuperCollider/Extensions"

	-- Option: Where to put a newly generated plugin
	vim.g.sc_plugin_dir = vim.g.sc_quark_path or homedir .. "/.local/share/SuperCollider/Extensions"

end

-- Uses https://github.com/elgiano/schelp-watch
function M.get_schelp_watch()
	local clone_to = utils.get_plugin_root_dir() .. "/schelp-watch"

	if exists(clone_to) then
		error("sc-help folder already exists in supercollider-h4x folder")
	else
		local url = "https://github.com/elgiano/schelp-watch" 
		local clone_cmd = string.format("git clone %s %s", url, clone_to)
		local post_clone = "echo schelp-watch >> .gitignore"
		terminal(clone_cmd .. "&& " .. post_clone)
	end
end

function M.schelp_watch(sc_lang_config_file)
	local schelpwatch = utils.get_plugin_root_dir() .. "/schelp-watch/schelp-watch"

	if not exists(schelpwatch) then
		M.get_schelp_watch()
	end

	local cmd
	local helpsource_dir = "HelpSource"
	if isdir(helpsource_dir) then
		if sc_lang_config_file then
			cmd = schelpwatch .. helpsource_dir .. " --config " .. sc_lang_config_file .. " -o"
		else
			cmd = schelpwatch .. " " .. helpsource_dir .. " -o"
		end

		terminal(cmd)
	else
		error(helpsource_dir .. " does not exist in this root directory")
		error("Run this in the root of a directory with a HelpSource folder")
	end
end

function M.scnvim_fuzzy_definition()
	local help = scnvim_unpack_tags_table()
	local help_keys = {};

	for k,_ in pairs(help) do
		table.insert(help_keys, k)
	end

	fzf(help_keys, function(class_name)
		local key = tostring(class_name)
		local lookup_path = help[key]
		vim.cmd("spl " .. lookup_path)
	end)
end

-- Reappropriate scnvim's open help function in lua
M.open_help = vim.fn["scnvim#help#open_help_for"]

function M.scnvim_fuzzy_help()
	local help = scnvim_unpack_tags_table()
	local help_keys = {};

	for k,_ in pairs(help) do
		table.insert(help_keys, tostring(k))
	end

	fzf(help_keys, function(class_name)
		M.open_help(tostring(class_name))
	end)
end

-- Create a SuperCollider plugin with cpp
-- TODO: Open the files after generation
function M.create_plugin()
	local output_dir = vim.g.sc_plugin_dir
	local url = "https://github.com/supercollider/cookiecutter-supercollider-plugin"
	cookiecutter(url, output_dir)
end

-- Create a quark
-- TODO: Open the files after generation
function M.create_quark()
	local output_dir = vim.g.sc_quark_path
	local url = "https://github.com/madskjeldgaard/cookiecutter-quark"
	cookiecutter(url, output_dir)
end

-- Get SC Source code for development
function M.get_sc_source()
	local url = "https://github.com/supercollider/supercollider/"
	local cmd = "git clone --recurse-submodules " .. url
	local executable = vim.call("executable", "git")
	if executable == 1 then
		terminal(cmd)
	else
		vim.api.nvim_err_writeln("Git not executable!")
	end
end

-- For compiling Supercollider plugins
-- Expects vim to be inside plugin root directory
function M.sc_compile_plugin()
	local function run_build()
		local cmake_cmd = string.format("mkdir build; cd build && cmake .. -DCMAKE_BUILD_TYPE=Debug -DSC_PATH=%s", vim.g.sc_source_code)
		local build_cmd = "cmake --build . --config Debug"
		local cmd = cmake_cmd .. " && " .. build_cmd

		-- print(cmd)
		terminal(cmd)
	end

	if exists("build") then
		run_build()
	else
		-- mkdir
		shell("mkdir build")
		run_build()
	end

end

return M
