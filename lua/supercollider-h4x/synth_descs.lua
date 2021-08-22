local M = {}

local utils = require'supercollider-h4x/utils'
local fzf = utils.fzf

-- Split string into table
function M.split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function M.all_synth_descs()
	local sc_code = [[SynthDescLib.default.synthDescs.keys.asCompileString.replace(\"Set[\", \"\").replace(\"]\")]]
	local descs = {}

	require'scnvim'.eval(sc_code, function(ret)
		descs = M.split(ret, ",")
	end)

	return descs
end

function M.fuzzy_synths()
	fzf(M.all_synth_descs(), function(ret)
		print("fuzz")
		-- require'scnvim'.send(string.format("\"%s\"", ret))
	end)
end

return M
