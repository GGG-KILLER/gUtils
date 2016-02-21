gUtils.String = {}

--[[============================================]]--
--[[ Capitalizes the first letter of the string ]]--
--[[============================================]]--
function gUtils.String.Capitalize (str)
    return (str:sub(1,1)):upper() .. str:sub(2)
end

--[[============================================================]]--
--[[ Splits a string in chunks having the maximum size of <max> ]]--
--[[============================================================]]--
local trim, sub = string.Trim, string.sub
function gUtils.String.SplitBySize(str, size)
    local chunks = {}
    local last = 1
	str = trim(str)

    for i=1, #str, size do
        last = i + size
        chunks [#chunks + 1] = sub(str, i, math.Clamp(i + size, i, #str))
    end

    if last ~= #str then chunks [#chunks + 1] = str:sub(last) end

    return chunks
end
