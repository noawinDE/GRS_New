﻿zugicon = createPickup ( -1974, 117.69999694824, 27.700000762939, 3, 1239, 250 )
local blip = createBlip ( -1974, 117.69999694824, 27.700000762939, 58, 2, 255, 255, 0, 255, 0, 200 )
--local blip = createBlip ( 1735, -1943.8000488281, 13.60000038147, 58, 1, 0, 0, 0, 255, 0, 200 )

local zugmarker = {
	[1] = { x = 1477.6999511719, y = 2636.3000488281, z = 9.6000003814697 },
	[2] = { x = 2864.8999023438, y = 1246.5, z = 9.8999996185303 },
	[3] = { x = 1687.4000244141, y = -1953.9000244141, z = 12.5 },
	[4] = { x = 775.5, y = -1331.0999755859, z = -2.5999999046326  }, 
	[5] = { x = -1941.8000488281, y = 185.10000610352, z = 24.60000038147 },
	[6] = { x = -230, y = 1270.6999511719, z = 26 },
	[7] = { x = 107.80000305176, y = 1279.9000244141, z = 20.39999961853 },
	[8] = { x = 346.39999389648, y = 1206.8000488281, z = 21.1 },
	[9] = { x = 596.40002441406, y = 1281.5999755859, z = 11 },
	[10] = { x = 737.40002441406, y = 1445.6999511719, z = 10.3 },
	[11] = { x = 742, y = 1868.1999511719, z = 4.6999998092651 },
	[12] = { x = 731.5, y = 2435.8999023438, z = 19.200000762939 },
	[13] = { x = 956.5, y = 2758.6000976563, z = 17.3 },
	[14] = { x = 1168, y = 2649.3000488281, z = 11.3 },
	[15] = { x = 1431, y = 2632.6000976563, z = 10 },
	[16] = { x = 1701, y = 2649.6000976563, z = 10 },
	[17] = { x = 1931, y = 2694.3000488281, z = 10 },
	[18] = { x = 2174.1000976563, y = 2690.3999023438, z = 10 },
	[19] = { x = 2516.3999023438, y = 2644.3000488281, z = 10 },
	[20] = { x = 2553, y = 2366.6000976563, z = 6.4 },
	[21] = { x = 2781, y = 1890.4000244141, z = 6.6 },
	[22] = { x = 2865.1999511719, y = 1457.0999755859, z = 10 },
	[23] = { x = 2848.8999023438, y = 1173.8000488281, z = 9.8 },
	[24] = { x = 2764.6999511719, y = 859.90002441406, z = 11.6 },
	[25] = { x = 2765.3000488281, y = 485.79998779297, z = 7.5 },
	[26] = { x = 2786.5, y = 226.89999389648, z = 9.4 },
	[27] = { x = 2808.6000976563, y = -163.30000305176, z = 29.6 },
	[28] = { x = 2454.3999023438, y = -274.39999389648, z = 17.3 },
	[29] = { x = 2068.3000488281, y = -367.10000610352, z = 63.1 },
	[30] = { x = 2148.5, y = -667.5, z = 52.5 },
	[31] = { x = 2284.8999023438, y = -1186.9000244141, z = 24.8 },
	[32] = { x = 2247, y = -1553.8000488281, z = 18.5 },
	[33] = { x = 2185.3999023438, y = -1937.3000488281, z = 12.8 },
	[34] = { x = 1722.1999511719, y = -1954.0999755859, z = 12.7 },
	[35] = { x = 1135.4000244141, y = -1706.9000244141, z = -5.2 },
	[36] = { x = 632.09997558594, y = -1216.8000488281, z = 2.1 },
	[37] = { x = 140.69999694824, y = -1021.4000244141, z = 21.3 },
	[38] = { x = -166.19999694824, y = -1031.1999511719, z = 10.6 },
	[39] = { x = -371.20001220703, y = -1236.5999755859, z = 40.5 },
	[40] = { x = -603.90002441406, y = -1155.6999511719, z = 41.3 },
	[41] = { x = -826.70001220703, y = -1277.3000488281, z = 76.2 },
	[42] = { x = -1007.0999755859, y = -1501, z = 79.099998474121 },
	[43] = { x = -1318.3000488281, y = -1510.4000244141, z = 23 },
	[44] = { x = -1814.0999755859, y = -1345.5999755859, z = 13.1 },
	[45] = { x = -1975.8000488281, y = -1001.799987793, z = 23 },
	[46] = { x = -1980.0999755859, y = -571.70001220703, z = 25 },
	[47] = { x = -1944.5999755859, y = -34.099998474121, z = 24.9 }
}

local playerZugMarker = {}
local playerZugBlip = {}
local playerZugZug = {}
local playerZugLetzerMarker = {}
local playerAnzahlMarkerEingesammelt = {}

function ZugJobIconHit_func ( player )
	if vioGetElementData ( player, "job" ) == "zugfuehrer" and not getPedOccupiedVehicle ( player ) then
		infobox ( player, "Mit /zugjob\nstartest du deine\nZugfahrt.", 5000, 200, 200, 0 )
	else
		infobox ( player, "Tippe /job, um\nals Zugführer zu\narbeiten.", 5000, 200, 200, 0 )
	end
end
addEventHandler ( "onPickupHit", zugicon, ZugJobIconHit_func )


function startTheZugJob ( player )
	if vioGetElementData ( player, "job" ) == "zugfuehrer" then
		local x, y, z = getElementPosition ( player )
		if getDistanceBetweenPoints3D ( x, y, z, -1974, 117.69999694824, 27.700000762939 ) <= 5 then
			if not vioGetElementData ( player, "jailtime" ) or vioGetElementData ( player, "jailtime" ) <= 0 then
				if not vioGetElementData ( player, "prison" ) or vioGetElementData ( player, "prison" ) <= 0 then
					if not vioGetElementData ( player, "heaventime" ) or vioGetElementData ( player, "heaventime" ) <= 0 then
						startTheZugJobPhaseZwei ( player )
					end
				end
			end
		else
			infobox ( player, "Du bist\nnicht am Marker!", 5000, 255, 0, 0 )
		end	
	else
		infobox ( player, "Du bist\nkein Zugführer!", 5000, 255, 0, 0 )
	end	
end	
addCommandHandler ( "zugjob", startTheZugJob )


function startTheZugJobPhaseZwei ( player )
	infobox ( player, "Fahre alle\nMarker einzeln ab!", 5000, 0, 255, 0 )
	vioSetElementData ( player, "imzugjob", 1 )
	playerZugZug[player] = createVehicle ( 538, -1943.900390625, 142.5, 27.200000762939, 0, 0, 358 )
	setVehicleLocked ( playerZugZug[player], true )
	addEventHandler ( "onVehicleExit", playerZugZug[player], brecheZugJobAb )
	addEventHandler ( "onVehicleExplode", playerZugZug[player], brecheZugJobAb )
	addEventHandler ( "onVehicleRespawn", playerZugZug[player], brecheZugJobAb )
	warpPedIntoVehicle ( player, playerZugZug[player] )
	createZugJobMarker ( player )
	playerZugLetzerMarker[player] = 0
	playerAnzahlMarkerEingesammelt[player] = 0
	triggerClientEvent ( player, "activeCarGhostModeZugJob", player )
end
	
	
function createZugJobMarker ( player )
	local rnd = math.random ( 1, #zugmarker )
	while rnd == playerZugLetzerMarker[player] do
		rnd = math.random ( 1, #zugmarker )
	end
	playerZugLetzerMarker[player] = rnd
	local koord = zugmarker[rnd]
	playerZugMarker[player] = createMarker ( koord.x, koord.y, koord.z, "checkpoint", 3, 0, 187, 0, 150, player )
	playerZugBlip[player] = createBlip ( koord.x, koord.y, koord.z, 19, 2, 255, 0, 0, 255, 0, 99999, player )
	addEventHandler ( "onMarkerHit", playerZugMarker[player], erfolgreicherMarkerHitZugJob )
end
	
	
function erfolgreicherMarkerHitZugJob ( hitElement )
	if hitElement and isElement ( hitElement ) and getElementType ( hitElement ) == "player" then
		local player = hitElement
		if source == playerZugMarker[player] then
			if playerZugMarker[player] and isElement ( playerZugMarker[player] ) then
				removeEventHandler ( "onMarkerHit", source, erfolgreicherMarkerHitZugJob )
				destroyElement (source)
				playerZugMarker[player] = nil
			end
			if playerZugBlip[player] and isElement ( playerZugBlip[player] ) then
				destroyElement ( playerZugBlip[player] )
				playerZugBlip[player] = nil
			end
			playerAnzahlMarkerEingesammelt[player] = playerAnzahlMarkerEingesammelt[player] + 1
			infobox ( player, "Das war dein\n"..playerAnzahlMarkerEingesammelt[player]..". Marker!", 4000, 0, 255, 0 )	
			if playerAnzahlMarkerEingesammelt[player] == 10 then
				outputChatBox ("Das war dein 10. Marker - dafür kriegst du 150$ Bonus!", player, 0, 0, 255 )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 150 )
				givePlayerXP(player,5)
			elseif playerAnzahlMarkerEingesammelt[player] == 25 then
				outputChatBox ("Das war dein 25. Marker - dafür kriegst du 350$ Bonus!", player, 0, 0, 255 )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 350 )
				givePlayerXP(player,20)
			elseif playerAnzahlMarkerEingesammelt[player] == 50 then
				outputChatBox ("Das war dein 50. Marker - dafür kriegst du 600$ Bonus!", player, 0, 0, 255 )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 600 )
				givePlayerXP(player,30)
			elseif playerAnzahlMarkerEingesammelt[player] == 100 then
				outputChatBox ("Das war dein 100. Marker - dafür kriegst du 1000$ Bonus!", player, 0, 0, 255 )
				givePlayerXP(player,100)
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 1000 )
			end
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 300 )
			
			createZugJobMarker ( player )
		end
	end
end	
	
	
function brecheZugJobAb ( thePlayer )
	local player
	if thePlayer and isElement ( thePlayer ) and getElementType ( thePlayer ) == "player" then
		player = thePlayer
	else
		for playeritem, zug in pairs ( playerZugZug ) do
			if source == zug then
				player = playeritem
			end
		end
	end
	if not player or not isElement ( player ) then return false end
	vioSetElementData ( player, "imzugjob", 0 )
	executeCommandHandler ( "stoplimit", player )
	if playerZugMarker[player] and isElement ( playerZugMarker[player] ) then
		destroyElement ( playerZugMarker[player] )
		playerZugMarker[player] = nil
	end
	if playerZugBlip[player] and isElement ( playerZugBlip[player] ) then
		destroyElement ( playerZugBlip[player] )
		playerZugBlip[player] = nil
	end
	if playerZugZug[player] and isElement ( playerZugZug[player] ) then
		destroyElement ( playerZugZug[player] )
		playerZugZug[player] = nil
	end
	playerZugLetzerMarker[player] = 0
	playerAnzahlMarkerEingesammelt[player] = 0
	infobox ( player, "Job abgebrochen!", 5000, 255, 0, 0 )
	setElementPosition ( player, -1977.5, 115.09999847412, 27.700000762939 )
	triggerClientEvent ( player, "deactiveCarGhostModeZugJob", player )
end