addEvent ( "syncMoney", true )
addEvent ( "ElementClicked", true )
addEvent ( "HungerChange", true )
addEvent ( "triggerClientElementData", true )

mymoney = 0
local hunger = 60
local elementclicked = false
local elementDataClient = {}

function getElementMoney( )
	return tonumber(mymoney)
end

addEventHandler ( "syncMoney", root, function ( value )
	mymoney = tonumber ( value ) 
end )


function setElementClicked ( bool )
	elementclicked = bool
	triggerServerEvent ( "ElementClickedServer", localPlayer, bool )
end


addEventHandler ( "ElementClicked", root, function ( bool )
	elementclicked = bool
end )


function getElementClicked ( )
	return elementclicked
end


function setElementHunger ( value )
	hunger = tonumber ( value )
	if hunger > 100 then
		hunger = 100
	end
	triggerServerEvent ( "HungerChangeServer", localPlayer, value )
end


addEventHandler ( "HungerChange", root, function ( value )
	hunger = tonumber ( value ) 
	triggerServerEvent ( "HungerChangeServer", localPlayer, value )
end )


function getElementHunger ( )
	return hunger
end


function vioClientGetElementData ( dataString )
	return elementDataClient[dataString] or false
end


function vioClientSetElementData ( dataString, value )
	elementDataClient[dataString] = value
	triggerServerEvent ( "changeClientElementData", lp, dataString, value )
end


addEventHandler ( "triggerClientElementData", root, function ( dataString, value )
	elementDataClient[dataString] = value
end )