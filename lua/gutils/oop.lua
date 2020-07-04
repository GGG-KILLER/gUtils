--[[===================]]--
--[[    OOP for Lua    ]]--
--[[ works in pure lua ]]--
--[[   By GGG KILLER   ]]--
--[[===================]]--

function gUtils.OOP(metatable, base, ...)
	assert(type(metatable) == 'table', 'Expected table for metatable but got ' + type(metatable))
	assert(base == nil or type(base) == 'table', 'Expected table or nil for base but got ' + type(base))

	-- Sets the index to itself
	metatable.__index = metatable

	-- Adds the base as a fallback to the class's members
	if base then
		metatable.__index = setmetatable(metatable.__index, { __index = base })
	end

	local mixins = { ... }
	if #mixins > 0 then
		for _, mixin in ipairs(mixins) do
			if mixin.__constructor then
				error('Mixins cannot have a constructor.', 2)
			end
			metatable.__index = setmetatable(metatable.__index, { __index = mixins })
		end
	end

	-- Sometimes a class doesn't needs a constructor
	metatable.base = setmetatable({}, {
		__index = base,
		__newindex = function() error('Cannot modify base', 2) end,
		__call = base.__construct
	})
	metatable.__construct = metatable.__construct or function() end

	-- Adds the instance constructor to the class...
	setmetatable(metatable, {
		__call  = function(self, ...)
			local object = setmetatable({}, self)
			object:__construct(...)
			return object
		end
	})

	return metatable
end
