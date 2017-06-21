gUtils.Table = {}

--[[=============================================]]
--[[ A function that joins the value of 2 tables ]]
--[[=============================================]]
function gUtils.Table.Add ( a, b )
	local r = {}
	for k, v in ipairs ( a ) do
		r[ #r + 1 ] = v
	end

	for k, v in ipairs ( b ) do
		r[ #r + 1 ] = v
	end

	return r
end

--[[============================================================]]--
--[[ Filters a table according to the return of the function fn ]]--
--[[============================================================]]--
function gUtils.Table.Filter ( tbl, fn )
	local out = {}

	for k, v in pairs ( tbl ) do
		local accept, nonSequential = fn ( k, v, tbl )

		if accept and nonSequential then

			out[k] = v

		elseif accept then

			out[ #out + 1 ] = v

		end
	end

	return out
end

--[[==================================]]--
--[[ Clears a table to save up memory ]]--
--[[==================================]]--
function gUtils.Table.Clear ( tbl )
	for k, v in pairs ( tbl ) do
		tbl[k] = nil
	end
end

--[[=========================]]--
--[[ Changes values for keys ]]--
--[[=========================]]--
function gUtils.Table.ValuesForKeys ( tbl )
	for k, v in pairs ( tbl ) do
		tbl[ v ] = k
	end
end

--[[==========================================]]--
--[[ Counts the number of values in the table ]]--
--[[==========================================]]--
function gUtils.Table.Count ( tbl )
	local count = 0
	for _, v in pairs ( tbl ) do
		count = count + 1
	end
	return count
end
