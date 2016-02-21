--[[===================]]--
--[[    OOP for Lua    ]]-- No, not gmod lua,
--[[    oop.lua        ]]-- but it also works
--[[   By GGG KILLER   ]]-- on it too
--[[ Warning, features ]]--
--[[ demonstration at  ]]--
--[[      the end.     ]]--
--[[===================]]--
local sd = string.dump

local function _class ( metatable, ... )
	local parents = {...}
	local constrs = {}
	-- Sets the index to
	metatable.__index = metatable

	-- Sometimes a class doesn't needs a constructor
	metatable.__construct = metatable.__construct or function() end
	metatable.__constructors = {}

	function metatable:AddGetter ( name )
		self['Get' .. name] = function ( obj )
			return obj[name]
		end
	end

	function metatable:AddSetter ( name, OnChanged )
		self['Set' .. name] = function ( obj, v )
			if onChanged then
				-- OnChanged( <Instance>, <Old Value>, <New Value> )
				OnChanged ( obj, obj[name], v )
			end

			obj[name] = v
		end
	end

	function metatable:AddGetterSetter ( name, OnChanged )
		self:AddGetter ( name )
		self:AddSetter ( name, OnChanged )
	end

	-- Adds the parents' properties and methods to the child ( in the order of the classes you pass )
	if #parents > 0 then
		for _, parent in ipairs ( parents ) do

			-- Some metamethods heritance
			metatable.__tostring = metatable.__tostring or parent.__tostring

			-- If parent is children of any other classes, copy parent's parent's constructors
			-- Doing this first will assure that the parents of the parent class get called first
			if parent.__constructors and #parent.__constructors > 0 then
				for _, constructor in ipairs ( parent.__constructors ) do
					if constructor ~= function() end and not constrs[sd(constructor)] then
						metatable.__constructors[#metatable.__constructors + 1] = constructor
						constrs[sd(constructor)] = true
					end
				end
			end

			-- Copy the parent constructor if it exists
			if parent.__construct ~= nil and not constrs[sd(parent.__construct)] then
				metatable.__constructors[#metatable.__constructors + 1] = parent.__construct
				constrs[sd(parent.__construct)] = true
			end

			-- Copy properties and methods of parent class to child
			for key, value in pairs ( parent ) do
				if key:sub ( 1, 2 ) ~= '__' then
					metatable[key] = metatable[key] or value
				end
			end
		end
	end

	metatable.super = metatable.__constructors[ #metatable.__constructors ]

	-- Adds the instance constructor to the class...
	setmetatable(metatable, {
		__call  = function ( self, ... )
			local object = setmetatable({}, self)

			for _, __construct in ipairs ( self.__constructors ) do
				__construct ( object, ... )
			end
			object:__construct ( ... )

			return object
		end
	})

	return metatable
end

-- Warning: features demonstrations below
--[[
	-- Proper heritance demonstration code (uncomment to check):
	do
		local classes = {}
		local write = io.write or Msg -- because this works with pure lua
		print 'Heritance tree:'
		for i = 1, 10 do
			if i > 1 then
				classes[i] = _class ( {}, classes[i-1] ) -- Each class inherits the previous one
				write (' \175 classes[' .. i .. ']' )
			else
				classes[i] = _class ( {} )
				classes[i].Print = function( _, a ) print ( a ) end
				write ('classes[' .. i .. ']') -- 1st class
			end

			classes[i].__construct = function(self)
				self:Print ('Constructor from classes[' .. i .. '] called') -- Show the inheritance and constructor calling order (oldest to newest)
			end

			if i == 10 then
				print '\nCalling construction from last class created (classes[10])'
				classes[i]()
			end
		end
	end
--]]
--[[
	-- Anti-duplicated parent prevention (read the code to understand better):
	do
		local parent = _class {}
		function parent:__construct ()
			print 'Parent constructor'
		end

		local child1 = _class ({}, parent)
		function child1:__construct ()
			print 'Child1 constructor'
		end

		local child2 = _class ({}, parent)
		function child2:__construct ()
			print 'Child2 constructor'
		end

		local subchild = _class({}, child1, child2) -- References 2 parents that have the same parent
		function subchild:__construct ()
			print 'Subchild constructor'
		end
		subchild() -- Parent constructor is called only once because of anti-duplicated parent prevention
	end
--]]

gUtils.OOP = _class
