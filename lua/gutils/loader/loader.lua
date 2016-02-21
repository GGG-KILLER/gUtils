local function normalizePath ( name )
	-- Transforms into an actual path (if you use upper case letters in file names/paths you're stupid)
	return name:lower ( ):gsub ( '%.', '/' ) :gsub ( ' ', '_' ):gsub ( '[\\/]+', '/' ) .. '.lua'
end

gUtils.LoadCL = function ( name )
	name = normalizePath ( path )
	if SERVER then
		AddCSLuaFile ( name )
	else
		include ( name )
	end
end

gUtils.LoadSV = function ( name )
	if SERVER then
		include ( normalizePath ( name ) )
	end
end

gUtils.LoadSH = function ( name )
	name = normalizePath ( name )
	if SERVER then
		AddCSLuaFile ( name )
	end
	include ( name )
end
