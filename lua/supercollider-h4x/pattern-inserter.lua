local eval = require'scnvim'.eval
local utils = require('supercollider-h4x/utils')

local M = {}

function M.generate_pattern(synth_def_name)
	if synth_def_name == nil then return end

	print(synth_def_name)

	local sc_code = "load(\\\"" .. utils.get_plugin_root_dir() .. "/supercollider/pattern_generator.scd\\\").value(" .. synth_def_name .. ");"

	eval(
		sc_code,
		function (returnVal)
			vim.api.nvim_paste(returnVal, nil, -1)
			print(returnVal)
		end
	)
end

vim.cmd("command! -nargs=1 SCGeneratePattern lua require('supercollider-h4x/pattern-inserter').generate_pattern(<f-args>)")

return M
