# gUtils
Because gLib was already taken.

## What is it?
It is a gLua (only some can be used with pure lua) object-oriented library that strives to provide some default controls and utilities to make developers lives without over-complicating things.

## Features
- OOP Implementation
- List object
- Function queue (makes functions be called on next think, helps when you need everything to finish processing before something else runs)
- A logger that can be used on any addon and creates an ULX/ULib-like startup box automatically if requested
- Player extensions:
	- Event when the player is not fully authenticated
	- Fake player generation(can be used with admin mods when you don't want "(Console)" to show up, but a name of your choosing instead)
	- Event when the player is playing the game with family sharing identifying the lender
	- Player functions to identify whether the player is playing with a shared copy of Garry's Mod and who lent it
	- Possibility to queue messages for showing when the player spawns incase the player is not in the server
- Loader functions (basically replaces `.` for `/` and adds `.lua` to the end)
- Event system (think of it as hooks but without all that hook name competition and that can be binded to objects)
- String extensions:
	- String capitalizing method
	- Function to split a string in even chunks (last one may not be the same size since the string may not be of a divisible by the chunk length size)
- Table extensions:
	- Adding function (adds to tables together and returns the value (does not modify original tables))
	- Table filtering function (filter a table's contents according to the return of a function)
	- Table clearing function (because assigning {} wastes memory)
	- Function to change the values of a table for keys (perfect for enums)

### What can be used with pure lua?
- OOP implementation (was actually made using the lua interpreter not GMod's)
- List object
- String extensions (with inclusion of gLua's `string.Trim` for chunk splitting)
- Table extensions
- Loader (I have no idea why you'd want this, but with some modifications it works)
- Event system
---
Expect more to be added to this as I have alot of free time in my programming classes
