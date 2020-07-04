local logger = gUtils.OOP {}
gUtils.Classes.Logger = logger

--[[===========================================================================]]--
--[[ Logs a message using string.format, you'll realize that while in box mode ]]--
--[[ we do not print the message instantly, but instead until its called, so a ]]--
--[[ perfect box border can be created                                         ]]--
--[[===========================================================================]]--
function logger:Log(format, ...)
	local log = format:format(...):Replace('\t', '    ')

	if not self.BoxState and isstring(self.ParentName) then
		log = '[' .. self.ParentName .. ']' .. log
	elseif self.BoxState then

		if #log > self.MaxLen then -- Always get the longest message
			self.MaxLen = #log -- And update it for border aligning
		end

		-- And add the message to the queue
		self.BoxMessages[#self.BoxMessages + 1] = log
		return
	end

	MsgN(log)
end

--[[=====================================================================]]--
--[[ Logs a message with colors, it uses string format after a new color ]]--
--[[ please note that this does not work with the box mode               ]]--
--[[=====================================================================]]--
function logger:LogC(...)
	local all = { ... }
	local log = { }

	if not IsColor(all[1]) then
		log[ #log + 1 ] = color_white
	end

	for k, v in ipairs(all) do
		if IsColor(v) then
			MsgC(log[1], string.format(unpack(log, 2)))
			gUtils.Table.Clear(log)
		end

		log[#log + 1] = v
	end

	MsgC(log[1], string.format(unpack(log, 2)))
	gUtils.Table.Clear(log)

	Msg '\n'
end

--[[===============================================]]--
--[[ Changes the logging state to box-logging mode ]]--
--[[===============================================]]--
function logger:StartBox()
	if self.BoxState then
		error('A box state was already initialized!', 2)
	end

	self.BoxState = true
end

--[[============================================]]--
--[[ Ends the box state and prints all messages ]]--
--[[============================================]]--
function logger:EndBox()
	local len	  = self.MaxLen
	local headlen = self.MaxLen - (#self.ParentName + 2)

	-- Prints the box title
	local head = '\n///' .. string.rep('/', math.floor(headlen / 2))
	head = head .. ' ' .. self.ParentName .. ' '
	head = head .. string.rep('/', math.ceil(headlen / 2)) .. '///'
	MsgN(head)

	-- Prints each message with the right border padding
	for i, v in ipairs(self.BoxMessages) do
		MsgN('// ' .. v .. string.rep(' ', len - #v) .. ' //')
	end

	-- Prints the lower border
	MsgN(string.rep('/', len + 6) .. '\n')
end

--[[============================================================]]--
--[[ Constructor of the logger, defines the name of what to log ]]--
--[[============================================================]]--
function logger:__construct(name)
	self.ParentName = name
	self.BoxState	= false
	self.MaxLen		= 0
	self.BoxMessages = {}
end
