local queue = gUtils.OOP {}
gUtils.Classes.FunctionQueue = queue

--[[==========================]]--
--[[ Creates a function queue ]]--
--[[==========================]]--
function queue:__construct ( )
	self.Queue = gUtils.Classes.List ( )

	gUtils.Event:Listen ( 'Think' , function ( )
		self:Run ( )
	end )
end

--[[==============================]]--
--[[ Adds a function to the queue ]]--
--[[==============================]]--
function queue:AddFunction ( fn, ... )
	assert( type ( fn ) == 'function' , 'Function expected, but received ' .. type ( fn ) )
	self.Queue:Add {
		fn = fn,
		params = { ... }
	}
end

--[[===========================================]]--
--[[ Runs the function in the top of the queue ]]--
--[[===========================================]]--
function queue:Run ( )
	local data = self.Queue:Get ( 1 )

	if data then
		data.fn ( unpack ( data.params ) )

		self.Queue:Remove ( 1 )
		self.Queue:Reposition ( )
	end
end
