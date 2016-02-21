function gUtils.Initialize ( module, name )
	module.Name   = name
	module.Logger = gUtils.Classes.Logger ( name )
	module.LoadSH = gUtils.LoadSH
	module.LoadSV = gUtils.LoadSV
	module.LoadCL = gUtils.LoadCL

	module.AddHook = function ( obj, event, action, identifier )
		hook.Add (
			event,
			string.format ( '%s.Hooks.%s', obj.Name, event ) .. ( identifier ~= nil and ( '.' .. identifier ) or '' ),
			action
		)
	end

	module.RemoveHook = function ( obj, event, identifier )
		hook.Remove( event, string.format ( '%s.Hooks.%s', obj.Name, event ) .. ( identifier ~= nil and ( '.' .. identifier ) or '' ) )
	end

	module.RemHook = module.RemoveHook

	return module
end
