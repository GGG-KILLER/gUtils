local fakePly = gUtils.OOP {}
gUtils.Classes.FakePlayer = fakePly

--[[==============================================================================================]]--
--[[ Fake player constructor, all parameters are optional, but you might want to change the name. ]]--
--[[==============================================================================================]]--
function fakePly:__construct ( Name, SteamID, SteamID64, IPAddress, IsBot )
	self.Info = {
		Name		= Name or ( 'Fake Player #' .. math.random ( 500 ) ),
		SteamID		= SteamID	or ( 'STEAM_0:' .. math.random ( 0, 1 ) .. ':' .. math.random ( 11111111, 99999999 ) ),
		SteamID64	= SteamID64 or ( '76561198' .. math.random ( 000001111, 999999999 ) ),
		IPAddress	= IPAddress or ( math.random ( 1, 223 ) .. '.' .. math.random ( 0, 255 ) .. '.' .. math.random ( 0, 255 ) .. '.' .. math.random ( 0, 255 ) ),
		IsBot		= IsBot or false
	}
end


--[[==============================================================================================]]--
--[[ The rest below are just the default function overwrites, feel free to read, but don't modify ]]--
--[[==============================================================================================]]--

function fakePly:IsFake ( )
	return true
end

function fakePly:Name ( )
	return self.Info.Name
end

function fakePly:SteamID ( )
	return self.Info.SteamID
end

function fakePly:SteamID64 ( )
	return self.Info.SteamID64
end

function fakePly:IPAddress ( )
	return self.Info.IPAddress
end

function fakePly:IsPlayer ( )
	return not self.Info.IsBot
end

function fakePly:IsBot ( )
	return self.Info.IsBot
end
