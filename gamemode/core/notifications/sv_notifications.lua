local Notification = {}
local net = net
local util = util

Notification.Presets = {}

util.AddNetworkString("lava_notification")

function Notification.Create( Text, Table, Player )
	net.Start("lava_notification")
	net.WriteTable( Table )
	net.WriteString( Text )
	net.Send( Player or player.GetAll() )
end

function Notification.SendType( Type, Text, Player )
	net.Start("lava_notification")
	net.WriteTable( Notification.Presets[ Type ] )
	net.WriteString( Text )
	net.Send( Player or player.GetAll() )
end

function Notification.CreateType( TypeName, Data )
	Notification.Presets[ TypeName ] = Data
end

Notification.CreateType( "General", {
	SOUND = "ambient/water/drip2.wav",
	TIME = 5,
	ICON = 2438
})

_G.Notification = Notification