-- File: gutils/lib/player.lua
-- Desc: Extends the player class with new functionalities and the player lib
gUtils.Player = {}


--[[====================================================================================================]]--
--[[ Queues a message by SteamID incase the player is not on the server, else sends the message to them ]]--
--[[====================================================================================================]]--
local messageQueue = { }
function gUtils.Player.QueueMessage(steamid, message)
	local ply = player.GetBySteamID64(steamid)

	if not ply then
		messageQueue[steamid] = messageQueue[steamid] or gUtils.Classes.List()
		messageQueue[steamid]:Add(message)
	else
		ply:ChatPrint(message)
	end
end

gUtils.Event:Listen('PlayerInitialSpawn', function(ply)
	if messageQueue[ply:SteamID()] and messageQueue[ply:SteamID()]:Size() > 0 then
		for i = 1, messageQueue[ply:SteamID()]:Size() do
			ply:ChatPrint(messageQueue[ply:SteamID()]:Get(i))
			messageQueue[ply:SteamID()]:Remove(i)
		end
	end
end)

local function CheckFamilySharing(ply)
	local format = 'http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=%s&format=json&steamid=%s&appid_playing=4000'
	local url = format:format(gUtils.DEVKEY, ply:SteamID64())

	http.Fetch(url, function(body) -- On Success
		body = util.JSONToTable(body)

		if not body or not body.response or not body.response.lender_steamid then
			error(
				string.format(
					'[gUtils - Player - FamilySharing]: Invalid Steam API response for %s | %s\n',
					ply:Nick(),
					ply:SteamID()
				)
			)
		end

		local lender = body.response.lender_steamid

		if lender ~= '0' then
			ply:SetFamilyShare(util.SteamIDFrom64(lender))
			gUtils.Event:Trigger('SharedAccount', ply, util.SteamIDFrom64(lender))
		else
			ply:SetFamilyShare(false)
		end

	end, function(code) -- On Error
		error(
			string.format(
				'[gUtils - Player - FamilySharing]: Failed API call for %s | %s (Error: %s)\n',
				ply:Nick(),
				ply:SteamID(),
				code
			)
		)
	end)
end

gUtils.Event:Listen('PlayerAuthed', CheckFamilySharing)

do
	local META = FindMetaTable 'Player'

	function META:SetFamilyShare(sid)
		self.FamilyShare = sid
	end

	function META:IsFamilyShare()
		return self.FamilyShare and true
	end
end
