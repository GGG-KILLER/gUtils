gUtils.Event:Listen ( 'PlayerInitialSpawn', function ( ply )
	if not ply:IsFullyAuthenticated ( ) then
		gUtils.Event:Trigger ( 'PlayerNotFullyAuthenticated', ply )
	end
end )
