### gUtils Documentation
Formatting:
``<return> Function ( <parameter type> Parameter_Name , ...)``

How to listen to an gUtils event:
```lua
gUtils.Event:Listen ( '<event name>', function ( ... )
	-- do something
end )
```

- ``<Class> gUtils.OOP ( <table> Class, <table(s)> Parents(Optional) )``
	Creates a class and uses the `__construct` method as the constructor

	Usage:
	```lua
	local Dad = gUtils.OOP { }

	function Dad:__construct ( name )
		self.Name = name
	end
	function Dad:talk ( message )
		print ( self.Name .. ": " .. message )
	end

	local Son = gUtils.OOP ( { }, Dad )

	Dad "Son's Dad":talk "Hello son" -- Son's Dad: Hello son
	Son "Dad's Son":talk "Hey dad" -- Dad's Son: Hey dad
	```
- ``<void> gUtils.Load* ( <string> Name )`` functions

	Replaces `.`'s for `/`'s, adds the `.lua` extension and loads the file in the respective realms ( SH - shared, CL - client and SV - server )

- ``<Logger> gUtils.Classes.Logger ( <string> Name )``

	Creates a logger object and uses `Name` as the name of the object to be logged

	Class methods:
	- ``<void> Logger:StartBox ( )``

	Starts the log box

	Only 1 box state can be initialized per time

	- ``<void> Logger:Log ( <string> Format, <vararg> Params )``

	Calls ``string.format`` and then logs the message

	- ``<void> Logger:LogC ( <Color> color, <string> Format, <vararg> Params, ... (Has to be the same structure as before) )``

	This one is a little complicated so I'll explain the parameters for this one: The function prints in chunks, so what it does basically is it gets the following `( <Color> color, <string> Format, <vararg> Params )` multiple times from the parameters passed and prints them with ``MsgC`` after using `string.format` from the 2nd parameter until the last one before the next color

	- ``<void> Logger:EndBox ( )``

	Stops storing the logs and calculates the box size and prints messages with padding

- ``<table> gUtils.Initialize ( <table> Module, <string> Name )``

	Initializes a "module" with a set of default functionalities:
	- LoadSV function
	- LoadSH function
	- LoadCL function
	- Logger instance
	- AddHook function
	- RemoveHook function

	Parameter description:
	- Module - The module/addon you want to apply the default functionalities to
	- Name - The name of the module/addon to be used by the logger instance

- ``<List> gUtils.Classes.List ( )``

	Creates a List object

	Class methods:
	- ``<void> List:Set ( <any> Value, <any> Index )``

	Sets the value `Value` at the `Index` index.

	- ``<void> List:Add ( <any> Value )``

	Adds the value `Value` to the next empty numerical index of the list

	- ``<void> List:Remove ( <any> Index )``

	Removes the value at the index `Index`

	- ``<boolean> List:HasValue ( <any> Value )``

	Checks if the value `Value` is contained in the List

	- ``<any> List:Get ( <any> Index )``

	Returns the value at the `Index` index

	- ``<void> List:Reposition ( )``

	**Only to be used in numberical and ordered indexed tables.**

	Assumes the 1st value has been removed and pulls all values 1 index lower

	- ``<number> List:Size ( )``

	Returns the amount of items stored in the list
- ``<Event> gUtils.Classes.Event ( )``
	Creates an event object

	Class methods:
	- ``<number> Event:Listen ( <string> Name, <function> Listener )``

	Adds an listener to the event `Name` and returns the index it was assigned to

	- ``<void> Event:UnListen ( <string> Name, <number> Index (Optional) )``

	Removes the listener to the event `Name` at the index `Index` or removes all listeners at the event `Name` if no index is provided

	- ``<void> Event:Trigger ( <string> Name, <vararg> Information )``

	Triggers the event `Name` and passes the `Information` to the listeners

- ``<void> gUtils.AddHookListener ( <string> Hook )``

	Adds a listener on `gUtils.Event` for the hook `Hook` which can be listened to with `Event:Listen`

- ``<FunctionQueue> gUtils.Classes.FunctionQueue ( )``

	Creates a function queue (runs the first function in the list every think)

	Class methods:
	- ``<void> FunctionQueue:AddFunction ( <function> Function, <vararg> Parameters )``

	Adds the function `Function` to the queue to be ran with the parameter(s) `Parameters`

	- *Internal* ``<void> FunctionQueue:Run ( )``

	**Internal, do not call.**

	Runs the first function in the queue

- ``<table> gUtils.Table.Add ( <table> Table1, <table> Table2 )``

	Joins the contents of `Table1` and `Table2` in a single table ignoring indexing

- ``<table> gutils.Table.Filter ( <table> Table, <function> Filter )``

	Calls the function `Filter` with the `key`, `value` and `Table` in the respective order and expects the return to be:
	- `<boolean> accept` - Whether the value should be kept
	- `<boolean> nonSequential` - Whether the key should be kept

	for each of the values passed to the function.

- ``<table> gUtils.Table.ValuesForKeys ( <table> Table )``

	Sets the values of the table as keys. Perfect for enums.

- ``<number> gUtils.Table.Count ( <table> Table )``

	Counts the amount of non-nil values stored in the table

- ``<string> gUtils.String.Capitalize ( <string> String )``

	Capitalizes the first letter of the string

- ``<table> gUtils.String.SplitBySize ( <string> String, <number> Size )``

	Returns the string `String` split into chunks of `Size` characters

- ``<void> gUtils.Player.QueueMessage ( <string> SteamID, <string> Message )``

	Prints the message in the chat of the player if they are online or puts the message into a queue that will be printed once the player spawns for the first time

- *Event* `SharedAccount`

	Is triggered when a player is playing with a shared copy of Garry's Mod

	Parameters:
	- `<Player> ply` - The player
	- `<string> SteamID` - The SteamID of the lender

- `<string> Player.FamilyShare`

	Property that identifies the lender of the game to `Player`

- `<boolean> Player:IsFamilyShare ( )`

	Returns whether the player is using a shared copy of Garry's Mod

- `*Internal* <void> Player:SetFamilyShare ( <string> SteamID = nil )`

	**Internal, do not call.**

	Function used to determine whether the player is using a shared copy of the Garry's Mod

- *Event* `PlayerNotFullyAuthenticated`
	Triggered when the player spawns for the first time and is not fully authenticated through steam.

	Paremeters:
	- `<Player> ply` - The unathed player


- ``<FakePlayer> gUtils.Classes.FakePlayer ( <string> Name, <string> SteamID, <string> SteamID64, <string> IPAddress, <boolean> IsBot )``

	Creates a fake player with some of the default player functions: `Player.Name`, `Player.SteamID`, `Player.SteamID64`, `Player.IPAddress`, `Player.IsPlayer` and `Player.IsBot`.

	Also comes with an extra function to identify the fake player: `Player.IsFake` which will always return true

	I recommend you define your own `Player.Team` function if you plan to use this with ULX as it might generate errors and wrong name coloring.

	I initially designed this to use with an anti-abuse system on my server so ULX could ban the players identifying the system which banned them.
