------------------------------
-------- Urheberrecht --------
------- by [LA]Leyynen -------
------------ 2012 ------------
------------------------------
local x, y = guiGetScreenSize()
local sx, sy = x/1920, y/1080
local player_screen = x * y
local screen = (1920 * 1080) -- deine auflösung
local screen = screen/100 --dreisatz = 1%
local player_screen = player_screen/screen -- die Prozentzahl vom Spieler Bildschirm im Vergleich mit der größten Auflösung
local size = 1*sx

-- TO DO | KOORDINATEN --
local greenzones = { 
	[1] = { x = -2016.5999755859, y = 78.300003051758, width = 102.5, height = 160.1 },
	[2] = { x = -1781.6999511719, y = 915.29998779297, width =  57.6999511719, height = 55 } -- rathhaus
	
}
local colCuboids = {}

addEventHandler ("onClientResourceStart", resourceRoot, function()
	for i=1, #greenzones do
		createRadarArea ( greenzones[i].x, greenzones[i].y, greenzones[i].width, greenzones[i].height, 0, 255, 0, 127, localPlayer )
		colCuboids[i] = createColCuboid ( greenzones[i].x, greenzones[i].y, -50, greenzones[i].width, greenzones[i].height, 7500)
		setElementID (colCuboids[i], "greenzoneColshape")
		addEventHandler ( "onClientColShapeHit", colCuboids[i], startGreenZone )
		addEventHandler ( "onClientColShapeLeave", colCuboids[i], stopGreenZone )
	end
end )


function startGreenZone (hitElement, matchingDimension)
	if hitElement == localPlayer and matchingDimension then
		infobox ( "Du hast\neine Schutzzone\nbetreten!", 5000, 0, 150, 0 )
		vioClientSetElementData ( "nodmzone", 1 )
		toggleControl ("fire", false)
		toggleControl ("next_weapon", false)
		toggleControl ("previous_weapon", false)
		toggleControl ("aim_weapon", false)
		toggleControl ("vehicle_fire", false)
		setPedDoingGangDriveby ( hitElement, false )
		setPedWeaponSlot( hitElement, 0 )
		renderWarn(true)
	end
end

function stopGreenZone (leaveElement, matchingDimension)
	if leaveElement == localPlayer and matchingDimension then
		infobox ( "Du hast\ndie Schutzzone\nverlassen!", 5000, 150, 0, 0 )
		vioClientSetElementData ( "nodmzone", 0 )
		toggleControl ("fire", true)
		toggleControl ("next_weapon", true)
		toggleControl ("previous_weapon", true)
		toggleControl ("aim_weapon", true)
		toggleControl ("vehicle_fire", true)
		renderWarn(false)
	end
end

addEventHandler ( "onClientPlayerSpawn", localPlayer, function ( )
	for i=1, #colCuboids do
		if isElementWithinColShape ( source, colCuboids[i] ) then
			startGreenZone ( source, true )
		end
	end
end )


addEventHandler ( "onClientPlayerVehicleExit", localPlayer, function ( )
	setPedWeaponSlot ( localPlayer, 0 )
end )

function drawWarn ()
	dxDrawRectangle(1680*sx, 287*sy, 151*sx, 68*sy, tocolor(255, 0, 0, 114), false)
    dxDrawText("NO-DM Zone", 1722*sx, 291*sy, 1791, 307, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawLine(1677*sx, 310*sy, 1833*sx, 310*sy, tocolor(255, 255, 255, 255), 1, false)
    dxDrawText("Jede Art von Deathmatch\n      ist hier verboten", 1684*sx, 317*sy, 1823*sx, 345*sy, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
end

function renderWarn(value)
if value == true then
	addEventHandler ( "onClientRender", root, drawWarn )
else
	removeEventHandler ( "onClientRender", root, drawWarn )
	end
end