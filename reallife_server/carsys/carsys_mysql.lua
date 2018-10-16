local usedCarStrings = {}
debug.sethook()
carsSpawned = false
allPrivateCars = {}
objectYacht = {}


function mySQLCarCreate ( array )
	for i=1, #array do
		local carsData = array[i]
		if carsData["AuktionsID"] == "0" then
			local Besitzer = carsData["Besitzer"]
			if not allPrivateCars[Besitzer] then
				allPrivateCars[Besitzer] = {}
			end
			local Typ = carsData["Typ"]
			local Tuning = carsData["Tuning"]
			local Spawnpos_X = tonumber(carsData["Spawnpos_X"])
			local Spawnpos_Y = tonumber(carsData["Spawnpos_Y"])
			local Slot = carsData["Slot"]
			if not badMySQLCarHouseXSpawns[math.floor ( Spawnpos_X )] and not badMySQLCarHouseYSpawns[math.floor ( Spawnpos_Y )] then
				local Spawnpos_Z = tonumber(carsData["Spawnpos_Z"])
				local Spawnrot_X = tonumber(carsData["Spawnrot_X"])
				local Spawnrot_Y = tonumber(carsData["Spawnrot_Y"])
				local Spawnrot_Z = tonumber(carsData["Spawnrot_Z"])
				local Special = tonumber(carsData["Special"]) 
				local Sportmotor = tonumber ( carsData["Sportmotor"] )
				local Bremse = tonumber ( carsData["Bremse"] )
				local Antrieb = carsData["Antrieb"]
				local Farbe = carsData["Farbe"]
				if #Farbe <= 3 then
					Farbe = "0|0|0|0"
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", "Farbe", Farbe, "UID", playerUID[Besitzer], "Slot", Slot )
				end
				local Paintjob = tonumber ( carsData["Paintjob"] )
				local Benzin = tonumber ( carsData["Benzin"] )
				allPrivateCars[Besitzer][Slot] = createVehicle ( Typ, Spawnpos_X, Spawnpos_Y, Spawnpos_Z, 0, 0, 0, Besitzer )
				if Special == 2 then
					if not objectYacht[Besitzer] then
						objectYacht[Besitzer] = {}
					end
					objectYacht[Besitzer][Slot] = createObject ( 1337, Spawnpos_X, Spawnpos_Y-2, 1.55 )
					attachElements ( objectYacht[Besitzer][Slot], allPrivateCars[Besitzer][Slot], 0, 2, 1.55 )
					setElementDimension ( objectYacht[Besitzer][Slot], 1 )
				end
				local veh = allPrivateCars[Besitzer][Slot]
				local STuning = carsData["STuning"]
				vioSetElementData ( veh, "stuning", STuning )
				setVehicleAsMagnetHelicopter ( veh )
				setVehicleRotation ( veh, Spawnrot_X, Spawnrot_Y, Spawnrot_Z )
				vioSetElementData ( veh, "owner", Besitzer )
				vioSetElementData ( veh, "name", veh )
				vioSetElementData ( veh, "carslotnr_owner", Slot )
				vioSetElementData ( veh, "locked", true )
				vioSetElementData ( veh, "color", Farbe )
				vioSetElementData ( veh, "spawnpos_x", Spawnpos_X )
				vioSetElementData ( veh, "spawnpos_y", Spawnpos_Y )
				vioSetElementData ( veh, "spawnpos_z", Spawnpos_Z )
				vioSetElementData ( veh, "spawnrot_x", Spawnrot_X )
				vioSetElementData ( veh, "spawnrot_y", Spawnrot_Y )
				vioSetElementData ( veh, "spawnrot_z", Spawnrot_Z )
				vioSetElementData ( veh, "special", Special )
				vioSetElementData ( veh, "lcolor", carsData["Lights"] )
				vioSetElementData ( veh, "distance", tonumber ( carsData["Distance"] ) )
				vioSetElementData ( veh, "sportmotor", Sportmotor )
				vioSetElementData ( veh, "bremse", Bremse )
				vioSetElementData ( veh, "antrieb", Antrieb )
				setPrivVehCorrectLightColor ( veh )
				setVehicleLocked ( veh, true )
				vioSetElementData ( veh, "fuelstate", Benzin )
				setPrivVehCorrectColor ( veh )
				setVehiclePaintjob ( veh, Paintjob )
				if tonumber(Tuning) == 1 then
					local Tuning = "|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|"
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", "Tuning", Tuning, "UID", playerUID[Besitzer], "Slot", Slot )
				else
					pimpVeh ( veh, Tuning )
				end
				giveSportmotorUpgrade ( veh )
				vioSetElementData ( veh, "rcVehicle", tonumber ( carsData["rc"] ) )
			end
		end
	end
	outputServerLog("Es wurden "..#array.." Fahrzeuge gefunden.")
end


function pimpVeh ( veh, tuning )
	for i = 1, 17 do
		local tunepart = ( tonumber(gettok ( tuning, i, string.byte('|') )) )
		if tunepart > 0 then
			addVehicleUpgrade ( veh, tunepart )
		end
	end
	specPimpVeh ( veh )
end


function setPrivVehCorrectColor ( veh )
	local spezcolor = vioGetElementData ( veh, "spezcolor" )
	if spezcolor and spezcolor ~= "" then
		local c1 = tonumber ( gettok ( spezcolor, 1, string.byte( '|' ) ))
		local c2 = tonumber ( gettok ( spezcolor, 2, string.byte( '|' ) ))
		local c3 = tonumber ( gettok ( spezcolor, 3, string.byte( '|' ) ))
		local c4 = tonumber ( gettok ( spezcolor, 4, string.byte( '|' ) ))
		local c5 = tonumber ( gettok ( spezcolor, 5, string.byte( '|' ) ))
		local c6 = tonumber ( gettok ( spezcolor, 6, string.byte( '|' ) ))
		setVehicleColor ( veh, c1, c2, c3, c4, c5, c6 )
		setTimer ( setVehicleColor, 100, 1, veh, c1, c2, c3, c4, c5, c6 )
	else
		local colors = vioGetElementData ( veh, "color" )
		local c1 = tonumber ( gettok ( colors, 1, string.byte( '|' ) ))
		local c2 = tonumber ( gettok ( colors, 2, string.byte( '|' ) ))
		local c3 = tonumber ( gettok ( colors, 3, string.byte( '|' ) ))
		local c4 = tonumber ( gettok ( colors, 4, string.byte( '|' ) ))
		setVehicleColor ( veh, c1, c2, c3, c4 )
		setTimer ( setVehicleColor, 100, 1, veh, c1, c2, c3, c4 )
	end
end
	
	
function setPrivVehCorrectLightColor ( veh )
	if veh then
		local colors = vioGetElementData ( veh, "lcolor" )
		if colors then
			local c1 = tonumber ( gettok ( colors, 1, string.byte( '|' ) ))
			local c2 = tonumber ( gettok ( colors, 2, string.byte( '|' ) ))
			local c3 = tonumber ( gettok ( colors, 3, string.byte( '|' ) ))
			setVehicleHeadLightColor ( veh, c1, c2, c3 )
		end
	end
end


function isOwnerActive ( pname )
	return true
end