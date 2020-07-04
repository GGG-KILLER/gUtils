gUtils.Table = {}

--[[=============================================]]
--[[ A function that joins the value of n arrays ]]
--[[=============================================]]
function gUtils.Table.Concat(...)
	local res, idx = {}, 1
	for _, tbl in ipairs { ... } do
		for k, v in ipairs(tbl) do
			res[idx] = v
			idx = idx + 1
		end
	end
	return res
end

--[[============================================================]]--
--[[ Filters a table according to the return of the function fn ]]--
--[[============================================================]]--
function gUtils.Table.Filter(tbl, fn)
	local out = {}

	for k, v in pairs ( tbl ) do
		local accept, keepKey = fn ( v, k, tbl )

		if accept and keepKey then
			out[k] = v
		elseif accept then
			out[#out + 1] = v
		end
	end

	return out
end

--[[================]]--
--[[ Clears a table ]]--
--[[================]]--
function gUtils.Table.Clear(tbl)
	for k, v in pairs(tbl) do
		tbl[k] = nil
	end
end

--[[=========================]]--
--[[ Changes values for keys ]]--
--[[=========================]]--
function gUtils.Table.ValuesForKeys(tbl)
	local out = {}
	for k, v in pairs(tbl) do
		out[v] = k
	end
	return out
end

--[[==========================================]]--
--[[ Counts the number of values in the table ]]--
--[[==========================================]]--
function gUtils.Table.Count(tbl)
	local count = 0
	for _k, _v in pairs(tbl) do
		count = count + 1
	end
	return count
end
