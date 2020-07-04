local evt = gUtils.OOP {}
gUtils.Classes.Event = evt

--[[==========================================]]--
--[[ Creates an event (and list of listeners) ]]--
--[[==========================================]]--
function evt:__construct()
	self.Listeners = { }
end

--[[========================]]--
--[[ Adds an event listener ]]--
--[[========================]]--
function evt:Listen(name, fn)
	assert(type(name) == 'string', 'String expected for name, but received ' .. type(name) .. ' instead.')
	assert(type(fn) == 'function', 'Function expected for action, but received ' .. type(fn) .. ' instead.')

	self.Listeners[name] = self.Listeners[name] or {}
	local ind = #self.Listeners[name] + 1

	self.Listeners[name][ind] = fn

	return ind
end

--[[===========================]]--
--[[ Removes an event listener ]]--
--[[===========================]]--
function evt:UnListen(name, ind)
	assert(type(name) == 'string', 'String expected for name, but received ' .. type(name) .. ' instead.')
	assert(type(ind) == 'number', 'Number expected for name, but received ' .. type(ind) .. ' instead.')

	if ind then
		self.Listeners[name][ind] = nil
	elseif name then
		for i, fn in ipairs(self.Listeners[name]) do
			self.Listeners[name][i] = nil
		end
	end
end

--[[===========================================]]--
--[[ Triggers the event and runs all listeners ]]--
--[[===========================================]]--
function evt:Trigger(name, ...)
	assert(type(name) == 'string', 'String expected for name, but received ' .. type(name) .. ' instead.')

	if not self.Listeners[name] then return end

	for i, fn in ipairs(self.Listeners[name]) do
		fn(...)
	end
end

function gUtils.AddHookListener(hook)
	hook.Add(hook, 'gUtils.Event.' .. hook, function(...)
		gUtils.Event:Trigger(hook, ...)
	end)
end

gUtils.Event = gUtils.Classes.Event()
