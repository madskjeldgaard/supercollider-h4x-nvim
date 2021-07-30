local eval = require'scnvim'.eval
local utils = require('supercollider-h4x/utils')

local M = {}

function M.paste_ndef_preset(ndef_name)
	if ndef_name == nil then return end


	local sc_code = "Ndef(" .. ndef_name .. ").controlNames().collect{|control| [\\\"'\\\" ++ control.name ++ \\\"'\\\" , control.defaultValue]}.flatten";

	eval(
		sc_code,
		function (returnVal)
			returnVal = "Ndef(" .. ndef_name .. ").set(*" .. returnVal .. ");"
			vim.api.nvim_paste(returnVal, nil, -1)
			print(returnVal)
		end
	)
end

vim.cmd("command! -nargs=1 SCPasteNdef lua require('supercollider-h4x/nodeproxy-hacks').paste_ndef_preset(<f-args>)")

return M
