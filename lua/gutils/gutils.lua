gUtils			= { }
gUtils.Classes	= { }
gUtils.Hooks	= {
	'PlayerAuthed',
	'Think',
	'PlayerInitialSpawn'
}

if SERVER then
	AddCSLuaFile 'loader/loader.lua'
end
include			'loader/loader.lua'

gUtils.LoadSH	'gUtils.OOP'
gUtils.LoadSH	'gUtils.Logger.Logger'
gUtils.LoadSH	'gUtils.Initializer'

gUtils			= gUtils.Initialize ( gUtils, 'gUtils' )

gUtils.Logger:StartBox	( )

	gUtils.Logger:Log		'Loaded gUtils.OOP'
	gUtils.Logger:Log		'Loaded gUtils.Logger.Logger'
	gUtils.Logger:Log		'Loaded gUtils.Initializer'
	
	gUtils.LoadSV			'gUtils.Config'
	if SERVER then
		gUtils.Logger:Log		'Loaded gUtils.Config'
	end
	
	gUtils.LoadSH			'gUtils.List'
	gUtils.Logger:Log		'Loaded gUtils.List'

	gUtils.LoadSH			'gUtils.Event.Event'
	gUtils.Logger:Log		'Loaded gUtils.Event.Event'

	gUtils.Logger:Log		'Adding event listeners...'
	for k, v in pairs ( gUtils.Hooks ) do
		gUtils.Logger:Log	( '\t' .. v )
		gUtils.AddHookListener  ( v )
	end
	gUtils.Hooks = nil

	gUtils.LoadSH			'gUtils.FunctionQueue'
	gUtils.Logger:Log		'Loaded gUtils.FunctionQueue'

	gUtils.FunctionQueue =	gUtils.Classes.FunctionQueue ( )

	gUtils.LoadSH			'gUtils.Extend.Table'
	gUtils.Logger:Log		'Loaded gUtils.Extend.Table'

	gUtils.LoadSH			'gUtils.Extend.String'
	gUtils.Logger:Log		'Loaded gUtils.Extend.String'

	gUtils.LoadSV			'gUtils.Player.Extend'
	if SERVER then
		gUtils.Logger:Log		'Loaded gUtils.Player.Extend'
	end
	
	gUtils.LoadSH			'gUtils.Player.Events'
	gUtils.Logger:Log		'Loaded gUtils.Player.Events'

	gUtils.LoadSH			'gUtils.Player.FakePlayer'
	gUtils.Logger:Log		'Loaded gUtils.Player.FakePlayer'

gUtils.Logger:EndBox	( )
