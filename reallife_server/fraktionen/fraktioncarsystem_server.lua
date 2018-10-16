factionVehicle = {}
factionVehicleRang = {}
factionVehicleLevel = {}
---local factionVehicleColor = {}
fraktionsNamen = { [1]="SFPD", [2]="Cosa Nostra", [3]="Triaden", [4]="Terroristen", [5]="SAN News", [6]="FBI", [7]="Los Aztecas", [8]="Army", [9]="Angels of Death", [10]="Sanitäter", [11]="Mechaniker", [12]="Ballas", [13]="Grove" }
fraktionsVehs = 0
factionColors = {} 
factionColors[1] = {[1] = 0,[2] = 0, [3] = 204, [4] = 255, [5] = 255, [6] =  255 }
factionColors[2] = {[1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 1, [6] =  1 }
factionColors[3] = {[1] = 255, [2] = 4, [3] = 4, [4] = 255, [5] = 1, [6] =  1 }
factionColors[4] = {[1] = 3, [2] = 0, [3] = 8, [4] = 9, [5] = 1, [6] =  1 }
factionColors[5] = {[1] = 6, [2] = 6, [3] = 0, [4] = 0, [5] = 1, [6] =  1 }
factionColors[6] = {[1] = 6, [2] = 0, [3] = 0, [4] = 6, [5] = 0, [6] =  0 }
factionColors[7] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0, [5] = 1, [6] =  1 }
factionColors[8] = {[1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 1, [6] =  1 }
factionColors[9] = {[1] = 113, [2] = 113, [3] = 8, [4] = 113, [5] = 113, [6] =  8 }
factionColors[10] = {[1] = 255, [2] = 255, [3] = 255, [4] = 255, [5] = 8, [6] =  8 }
factionColors[11] = {[1] = 255, [2] = 255, [3] = 255, [4] = 0, [5] = 1, [6] =  1 }
factionColors[12] = {[1] = 22, [2] = 0, [3] = 85, [4] = 0, [5] = 1, [6] =  1 }
factionColors[13] = {[1] = 0, [2] = 238, [3] = 0, [4] = 0, [5] = 1, [6] =  1 }



SFPD = createColCircle(-1603.8896484375, 675.7958984375, 100 )
SFPD1 = createColCircle(2272.560546875,2440.080078125, 100 )
Mafia = createColCircle(-688.0791015625,939.6416015625, 100 )
Mafia1 = createColCircle(2291.1953125,1725.3330078125, 100 )
Triaden = createColCircle(-2176.9521484375,684.6259765625, 100 )
FBI = createColCircle(-2053.4475097656,-191.60914611816, 100 )
AoD = createColCircle(-2207.2216796875,-2341.9423828125, 100 )
AoD1 = createColCircle(2489.853515625, 1568.423828125, 100 )
Medic = createColCircle(-2649.095703125,625.6962890625, 100 )
Terror = createColCircle(-1998.8271484375,-1563.93359375, 100 )
Army = createColCircle(-1340.4794921875,468.98046875, 200 )
Army1 = createColCircle(210.8173828125,1896.7294921875, 200 )
LTR = createColCircle(-2520.8505859375, -611.7421875, 100 )
Aztecas = createColCircle(-1314.8125, 2505.298828125, 100 )
Aztecas1 = createColCircle(693.6572265625,1963.7353515625, 100 )
Grove = createColCircle(2502.4208984375,-1668.2265625, 100 )
Ballas = createColCircle(-2205.6103515625, 49.3369140625, 100 )
Mechaniker = createColCircle(-2389.9443359375, -138.763671875, 50 )

function getColShapeSpawnArea ( player )
    local faction = getPlayerFaction ( player )
    if faction == 1 then
        sp = SFPD
        sp2 = SFPD1
    elseif faction == 2 then
        sp = Mafia
        sp2 = Mafia1
    elseif faction == 3 then
        sp = Triaden
        sp2 = Triaden
    elseif faction == 4 then
        sp = Terror
        sp2 = Terror
    elseif faction == 5 then
        sp = LTR
        sp2 = LTR
    elseif faction == 6 then
        sp = FBI
        sp2 = FBI
    elseif faction == 7 then
        sp = Aztecas
        sp2 = Aztecas1
    elseif faction == 8 then
        sp = Army
        sp2 = Army1
    elseif faction == 9 then
        sp = AoD
        sp2 = AoD1 
    elseif faction == 10 then
        sp = Medic
        sp2 = Medic
    elseif faction == 11 then
        sp = Mechaniker
        sp2 = Mechaniker
    elseif faction == 12 then
        sp = Grove
        sp2 = Grove
    elseif faction == 13 then
        sp = Ballas
        sp2 = Ballas
    end
    return sp,sp2
end
function loadFactionCars ()
    local result =  dbQuery(handler,"SELECT * FROM fraktionen_vehicle")
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                local id = rows.ID
               
                local model = rows.Modell
                local FactionID = tonumber(rows.OwnerID)
                local Rang = tonumber(rows.Rang)
                local Level = tonumber(rows.Aufwertung)
                local SX = tonumber(rows.X)
                local SY = tonumber(rows.Y)
                local SZ = tonumber(rows.Z)
                local SXR = tonumber(rows.RX)
                local SYR = tonumber(rows.RY)
                local SZR = tonumber(rows.RZ)
                fraktionsVehs = fraktionsVehs+1
                createFactionVehicleDB (fraktionsVehs,model,SX,SY,SZ,SXR,SYR,SZR,FactionID,Rang,Level)
				
            end
            outputDebugString(fraktionsVehs.." Fraktionsfahrzeuge geladen.")
        end
    end
end
addEventHandler("onResourceStart", resourceRoot, loadFactionCars )

function createFactionVehicleDB (id, model, x, y, z, rx, ry, rz, faction, rang, level)

	if not dbExist ( "fraktionen_buy_vehicle", "Modell LIKE '"..model.."' AND OwnerID LIKE '"..faction.."'") then
		price = carprices[model]	
		if not price then
			price = 200000
		end
		dbExec ( handler, "INSERT INTO fraktionen_buy_vehicle (Modell, Preis, OwnerID) VALUES (?, ?, ?)", model, price, faction  )   
	end
	
    factionVehicle[id] = createVehicle (  model,  x, y, z, rx, ry, rz)
    factionVehicles[faction][factionVehicle[id]] = true
    factionVehicleRang[id] = rang
    factionVehicleLevel[id] = level
    setElementData(factionVehicle[id], "ID", id)
    setElementData(factionVehicle[id], "Rang", rang)
    setElementData(factionVehicle[id], "FactionCarOwner", tonumber(faction))
    addEventHandler ( "onVehicleEnter", factionVehicle[id], cancelFCar )
	setElementPosition(factionVehicle[id], x, y, z)
	setVehicleRotation (factionVehicle[id], rx, ry, rz )
    setElementDimension(factionVehicle[id],0)
    setElementInterior(factionVehicle[id],0)
	
 
    if factionVehicleLevel[id] == 0 then
        setElementHealth(factionVehicle[id], 1000)
    elseif factionVehicleLevel[id] == 1 then
        setElementHealth(factionVehicle[id], 1500)
        setVehicleHandling(factionVehicle[id], "maxVelocity", getVehicleHandling(factionVehicle[id]) + 10)
    elseif factionVehicleLevel[id] == 2 then
        setElementHealth(factionVehicle[id], 2000)
        setVehicleHandling(factionVehicle[id], "maxVelocity", getVehicleHandling(factionVehicle[id]) + 20)
    end
	
    local c1, c2,c3,c4, c5, c6 = factionColors[faction][2],factionColors[faction][2],factionColors[faction][3],factionColors[faction][4],factionColors[faction][5],factionColors[faction][6]
	setVehicleRespawnPosition(factionVehicle[id],x,y,z,rx,ry,rz)
    setVehiclePaintjob ( factionVehicle[id], 3 )
    toggleVehicleRespawn ( factionVehicle[id], true )
	toggleVehicleRespawn (  factionVehicle[id], true )
	setVehicleRespawnDelay ( factionVehicle[id], FCarDestroyRespawn * 1000 * 60 )
	setVehicleIdleRespawnDelay ( factionVehicle[id], FCarIdleRespawn * 1000 * 60 )
	giveSportmotorUpgrade ( factionVehicle[id] )
	local v = factionVehicle[id]
	setVehicleColor ( v, c1, c2,c3,c4, c5, c6 )
	if faction == 1 or  faction == 6 or  faction == 8 then
		if getElementModel (v) == 411 then
			addVehicleSirens(v, 2, 2, true, false, true, false)
			setVehicleSirens(v, 1, 0, 0, 0, 0, 0, 122.4, 0, 183.6)
			setVehicleSirens(v, 2, 0, 1.1, 0.2, 0, 0, 153, 198.9, 198.9)
		end
		if getElementModel (v) == 415 then
			addVehicleSirens(v, 2, 2, true, false, true, false)
			setVehicleSirens(v, 1, 0, 0, 0, 0, 0, 122.4, 0, 183.6)
			setVehicleSirens(v, 2, 0, 0.6, 0, 0, 0, 153, 198.9, 198.9)
		end
	end
	if faction == 11 then
		if getElementModel (v) == 525 then
			addVehicleSirens(v, 3, 2, false, true, true, true)
			setVehicleSirens(v, 1, 0.55, -0.5, 1.5, 255, 0, 0, 200, 200)
			setVehicleSirens(v, 2, -0.55, -0.5, 1.5, 255, 0, 0, 255, 200)
			setVehicleSirens(v, 3, 0, -0.5, 1.5, 255, 255, 0, 255, 200)
		elseif getElementModel (v) == 417 then
			Mechaniker_magnet (v)
			addEventHandler("onVehicleExplode", v, MechanikerMagnetExplode)
		end
	end
end

function cancelFCar ( player, seat )
    local faction = getPlayerFaction ( player )
    local rank = getPlayerRank ( player )
	local veh = source
    if tonumber(getElementData(source,"ID")) and seat == 0 then
        if not isKeyBound ( player, "sub_mission", "down", policeComputer ) and isStateFaction(player) then
            bindKey ( player, "sub_mission", "down", policeComputer )
        end
		if isElementFrozen(veh) then
			 outputChatBox ( "Nutze /fbreak um die Handbremse zu lösen.", source, 125, 0, 0 )
		end
        -- nix
        if faction == 8 then
            if getElementModel ( veh ) == 433 then

                setElementHealth ( player, 100 )
                setPedArmor ( player, 100 )
                setElementHunger ( player, 100 )

            elseif getElementModel ( veh ) == 432 then

                if vioGetElementData ( player, "job" ) ~= "tankcommander" then
                    opticExitVehicle ( player )
                    outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
                end

            elseif getElementModel ( veh ) == 425 or getElementModel ( veh ) == 520 then

                if vioGetElementData ( player, "job" ) ~= "air" then
                    opticExitVehicle ( player )
                    outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
                end

            elseif getElementModel ( veh ) == 563 or getElementModel ( veh ) == 595 then

                if vioGetElementData ( player, "job" ) ~= "marine" and seat == 0 then
                    opticExitVehicle ( player )
                    outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
                else
                    giveWeapon ( player, 46, 3, true )
                end
            end
        end
        if getElementData(source, "FactionCarOwner") ==  faction then
            if rank < tonumber(getElementData(source, "Rang"))  then
                triggerClientEvent ( player, "infobox_start", getRootElement(), "Dein Rang ist\nzu niedrig.", 5000, 125, 0, 0 )
                opticExitVehicle ( player )
            end
        else
            triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist\nnicht in der\nFraktion "..fraktionNames[getElementData(source, "FactionCarOwner")], 5000, 125, 0, 0 )
            opticExitVehicle ( player )
        end
    end
end



function fCarBreak ( player )
    local faction = getPlayerFaction ( player )
    local veh = getPedOccupiedVehicle ( player )
    if veh then
        if  getElementData ( veh, "ID") then
            if faction == getElementData(veh, "FactionCarOwner") then
                if getPedOccupiedVehicleSeat( player ) == 0 then
                    if isElementFrozen(veh) then
                        setElementFrozen ( veh, false )
                        outputChatBox ( "Die Handbremse wurde gelöst.", player, 0, 125, 0 )
                    else
                        setElementFrozen ( veh, true )
                        outputChatBox ( "Die Handbremse wurde angezogen.", player, 0, 125, 0 )
                    end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht der Fahrer,", 5000, 125, 0, 0 )
				end
            else
                triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist\nnicht in der\nFraktion.", 5000, 125, 0, 0 )
            end
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nim Fahrzeug!", 5000, 125, 0, 0 )
    end

end
addEvent ( "fCarBreak", true )
addEventHandler ( "fCarBreak", getRootElement(),  fCarBreak )
addCommandHandler( "fbreak", fCarBreak)



function deleteBuyableCar ( player, id )
	
	local faction = getPlayerFaction ( player )
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Fahrzeug gelöscht.", 5000, 125, 0, 0 )
	dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "fraktionen_buy_vehicle", "ID", id )
	
end
addEvent ( "deleteBuyableCar", true )
addEventHandler ( "deleteBuyableCar", getRootElement(),  deleteBuyableCar )

function parkFacCar ( player )
    local faction = getPlayerFaction ( player )
    local sp,sp2 = getColShapeSpawnArea ( player )
    local rank = getPlayerRank ( player )
    local veh = getPedOccupiedVehicle ( player )
    if veh then
        if  getElementData ( veh, "ID") then
            if rank >= 4 then
                if faction == getElementData(veh, "FactionCarOwner") then
                    if isElementWithinColShape (player, sp ) or isElementWithinColShape (player, sp2 ) then
						if getPedOccupiedVehicleSeat( player ) == 0 then
							local x,y,z = getElementPosition(veh)
							local rx,ry,rz = getElementRotation(veh)
							local id = getElementData ( veh, "ID")
							setVehicleRespawnPosition(veh,x,y,z,rx,ry,rz)
							dbExec ( handler, "UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=?", "fraktionen_vehicle", "X", x,"Y", y,"Z", z,"RX", rx,"RY", ry,"RZ", rz, "ID", id  )
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Fahrzeug geparkt.", 5000, 255, 0, 0)
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht der Fahrer,", 5000, 125, 0, 0 )
						end
                    else
                        triggerClientEvent ( player, "infobox_start", getRootElement(), "Ungültiges Gebiet.", 5000, 125, 0, 0 )
                    end
                else
                    triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist\nnicht in der\nFraktion.", 5000, 125, 0, 0 )
                end
            else
                triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
            end
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nim Fahrzeug!", 5000, 125, 0, 0 )
    end
end
addEvent ( "parkFacCar", true )
addEventHandler ( "parkFacCar", getRootElement(),  parkFacCar )
addCommandHandler( "fpark", parkFacCar)

function makeNewBuyableCar ( player, model, price, faction )
    dbExec ( handler, "INSERT INTO fraktionen_buy_vehicle (Modell, Preis, OwnerID) VALUES (?, ?, ?)", model, price, faction  )
    local fraktion = getPlayerFaction ( player )
    if tonumber(model) then
        if getVehicleNameFromModel(model) then
            if tonumber(price) then
                if tonumber(faction) then
                    if fraktionsNamen[faction] then
                        dbExec ( handler, "INSERT INTO fraktionen_buy_vehicle (Modell, Preis, OwnerID) VALUES (?, ?, ?)", model, price, faction  )
                    end
                end
            end
        end

    end
end
addEvent ( "makeNewBuyableCar", true )
addEventHandler ( "makeNewBuyableCar", getRootElement(),  makeNewBuyableCar )

function buyNewFactionCar ( player, model, price )

    local faction = getPlayerFaction ( player )
    local sp,sp2 = getColShapeSpawnArea ( player )

    if faction == 1 or faction == 6 or faction == 8 then
        depotFaction = 1
    else
        depotFaction = faction
    end

    if factionDepotData["money"][depotFaction] >= tonumber(price) then
        if isElementWithinColShape (player, sp ) or isElementWithinColShape (player, sp2 ) then
            local model = getVehicleModelFromName(model)
            local x,y,z = getElementPosition(player)
            local rx,ry,rz = getElementPosition(player)
            createFactionVehicleDB (fraktionsVehs+1,model,x,y,z,rx,ry,rz,faction,0,0 )
            dbExec ( handler, "INSERT INTO fraktionen_vehicle (Modell, OwnerID, Rang, Aufwertung, X, Y, Z, RX, RY, RZ) VALUES (?,?,?,?,?,?,?,?,?,?)", model, faction, 0, 0, x,y,z,rx,ry,rz )
            warpPedIntoVehicle(player, factionVehicle[fraktionsVehs + 1] )
            factionDepotData["money"][faction] = factionDepotData["money"][faction] - price
			sendMSGForFaction ( getPlayerName(player).." hat einen "..getVehicleNameFromModel(model).." für "..price.."$ die Frakion gekauft.", faction ,0,255,0)
			outputLog ( "[CAR-BUY] "..getPlayerName(player).." hat einen "..getVehicleNameFromModel(model).." für "..price.."$ die Frakion gekauft.", "fraktion"..faction )
        else
            triggerClientEvent ( player, "infobox_start", getRootElement(), "Ungültiges Gebiet.", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "Zuwenig Geld\nIhr habt "..factionDepotData["money"][depotFaction].."$", 5000, 125, 0, 0 )
    end
end
addEvent ( "buyNewFactionCar", true )
addEventHandler ( "buyNewFactionCar", getRootElement(),  buyNewFactionCar )





function loadBuyableCars ( player )

    local fraktion = getPlayerFaction ( player )
   
    local result = dbQuery ( handler, "SELECT * FROM fraktionen_buy_vehicle WHERE ??=?", "OwnerID", fraktion )
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                local id = rows.ID
                local model = rows.Modell
                local price = rows.Preis



               
                triggerClientEvent ( player, "loadBuyableCars", getRootElement(), id,model, price)

            end
        end
    end
end
addEvent ( "loadBuyableCars", true )
addEventHandler ( "loadBuyableCars", getRootElement(),  loadBuyableCars )
