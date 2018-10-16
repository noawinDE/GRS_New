fraktionNames = {}
fraktionNames = { [0] = "Zivilisten", [1]="SFPD", [2]="Cosa Nostra", [3]="Triaden", [4]="Terroristen", [5]="SAN News", [6]="FBI", [7]="Los Aztecas", [8]="Army", [9]="Angels of Death", [10]="Sanitäter", [11]="Mechaniker", [12]="Ballas", [13]="Grove" }
fraktionJoinable = { ["sfpd"] = true, ["mafia"] = true, ["triaden"] = true, ["terror"] = true, ["reporter"] = true, ["fbi"] = true, ["atzen"] = true, ["army"] = true,["aod"] = true, ["medic"] = true, ["mechaniker"] = true }
fraktionJoinLevel = { ["sfpd"] = 3, ["mafia"] = 3, ["triaden"] = 3, ["terror"] = 10, ["reporter"] = 5, ["fbi"] = 5, ["atzen"] = 3, ["army"] = 10, ["aod"] = 3, ["medic"] = 1, ["mechaniker"] = 1, ["ballas"] = 3, ["grove"] = 3 }
fraktionJoinVIP	= { ["sfpd"] = false, ["mafia"] = false, ["triaden"] = false, ["terror"] = true, ["reporter"] = false, ["fbi"] = false, ["atzen"] = false, ["army"] = false, ["aod"] = false, ["medic"] = false, ["mechaniker"] = false, ["ballas"] = false, ["grove"] = false }
fraktionJoinID	= { ["sfpd"] = 1, ["mafia"] = 2, ["triaden"] = 3, ["terror"] = 4, ["reporter"] = 5, ["fbi"] = 6, ["atzen"] = 7, ["army"] = 8, ["aod"] = 9, ["medic"] = 10, ["mechaniker"] = 11, ["ballas"] = 12, ["grove"] = 13 }


local leaveFactionBan = true
local leaveFactionBanTime = 86400
local allowToChangeSkin = false
local allowToChangeSkinTimer = nil


fraktionMembers = {}
fraktionMemberList = {}
fraktionMemberListInvite = {}


function sendMSGToAllFactions (msg,r,g,b)
	for i = 1, 13  do 
		sendMSGForFaction ( msg, i, r,g,b )
	end
end

function sendMSGToStateFactions (msg,r,g,b)
	sendMSGForFaction ( msg, 1, r,g,b )
	sendMSGForFaction ( msg, 6, r,g,b )
	sendMSGForFaction ( msg, 8, r,g,b )
end  
 

function changeFaction (player, cmd, factionName)
if changeFacctionCMD == true then
	local paket = vioGetElementData ( player, "Paket" )
    if vioGetElementData(player, "loggedin") == 1 then
        if checkFactionBan ( player ) == false then
            if fraktionJoinable[factionName] then
                local factionID = fraktionJoinID[factionName]
                if vioGetElementData ( player, "fraktion") == 0 then
                    if fraktionJoinVIP[factionName] == true and vioGetElementData ( player, "premium") == false then
                        return outputChatBox("Diese Fraktion erfordert einen aktives Premium Status, den du nicht besitzt.", player, 125, 0, 0)
                    end
                    if vioGetElementData ( player, "MainLevel") >= fraktionJoinLevel[factionName] then
                        vioSetElementData ( player, "fraktion", factionID )
                        vioSetElementData ( player, "rang", 0 )
                        vioSetElementData ( player, "FraktionenBetreten", vioGetElementData ( player, "FraktionenBetreten" ) + 1 )
                        outputChatBox("Du bist der Fraktion "..fraktionNames[factionID].." beigetreten.", player, 0, 139, 0)
						local leaveFactionBanTime = math.floor((86400-(math.floor((leaveFactionBanTime/100)*ziviTimeReduction[paket])))/3600)
                        outputChatBox("Um diese zu verlassen tippe /leavefac, beachte dass dies einen "..leaveFactionBanTime.." Stunden Fraktions Ban nach sich zieht.", player, 0, 139, 0)
						dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Fraktion", factionID, "UID", playerUID[getPlayerName(player)] )
					else
                        outputChatBox("Du bist nicht Level "..fraktionJoinLevel[factionName], player, 125, 0, 0)
                    end
                    --    else
                    --        outputChatBox("Diese Fraktion erfordert einen aktives Premium Status, den du nicht besitzt.", player, 125, 0, 0)
                    --    end
                else
                    outputChatBox("Du bist kein Zivilist. Benutze zum verlassen /leavefac", player, 125, 0, 0)
                end
            else
                outputChatBox("Ungültige Fraktion oder momentan deaktiviert.", player, 125, 0, 0)
                outputChatBox("Nutze:  /fc sfpd | mafia | triaden | terror | reporter | fbi | atzen | army | aod | medic | mechaniker |", player, 125, 0, 0)
            end
        end
    end
end
end
addCommandHandler ( "fc", changeFaction )

function leaveFaction ( player )
	local paket = vioGetElementData ( player, "Paket" )
    if vioGetElementData(player, "loggedin") == 1 then
        if vioGetElementData ( player, "fraktion") > 0 then
            if vioGetElementData ( player, "rang") < 5 then
                vioSetElementData ( player, "fraktion", 0 )
                vioSetElementData ( player, "rang", 0 )
                outputChatBox("Du hast erfolgreich deine Fraktion verlassen.", player, 125, 0, 0)
				local leaveFactionBanRealTime = math.floor((86400-(math.floor((leaveFactionBanTime/100)*ziviTimeReduction[paket])))/3600)
				
				
                outputChatBox("Du kannst nun "..leaveFactionBanRealTime.." Stunden keiner Fraktion mehr betreten. ", player, 125, 0, 0)
				local reason = {"Verlassen einer Fraktion"}
				reason = table.concat( reason, " " )
				if leaveFactionBan == true then
					giveFactionBan ( player, leaveFactionBanTime, reason)
				end
            else
                outputChatBox("Dieser Befehl ist als Leader einer Fraktion nicht verfügbar.", player, 125, 0, 0)
            end
        else
            outputChatBox("Du bist Zivilist.", player, 125, 0, 0)
        end
    end
end
addCommandHandler ( "leavefac", leaveFaction )



function giveFactionBan ( player, time, reason)
	local pname = getPlayerName ( player )
	if vioGetElementData(player, "loggedin") == 1 then
		local rt = getRealTime ()
		local zeit = rt.timestamp + tonumber(time)
		dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=? WHERE ??=?", "userdata", "FraktionsBanReason", tostring(reason), "FraktionsBanDate", tonumber(zeit), "FraktionsBan", 1, "UID", playerUID[pname] )
	end
end

function checkExpiredFactionBan ( player )
    local pname = getPlayerName ( player )
    local result = dbPoll ( dbQuery ( handler, "SELECT  ??, ??, ?? FROM ?? WHERE ??=? ","FraktionsBanReason", "FraktionsBanDate", "FraktionsBan", "userdata", "UID", playerUID[pname] ), -1 )
    local rt = getRealTime ()
    local timesamp = rt.timestamp
    if result and result[1] then
        if result[1]["FraktionsBan"] == 1 then
            local date = tonumber( result[1]["FraktionsBanDate"] )
            if date >= 0 then
                if date < timesamp then
					 dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=? WHERE ??=?", "userdata", "FraktionsBanReason", "", "FraktionsBanDate", "0", "FraktionsBan", 0, "UID", playerUID[pname] )
					 outputChatBox("Deine Fraktionssperre ist abgelaufen.", player, 125, 0, 0)
                end
            end
        end
    end
end

function checkFactionBan ( player )
    local pname = getPlayerName ( player )
    local result = dbPoll ( dbQuery ( handler, "SELECT  ??, ??, ?? FROM ?? WHERE ??=? ","FraktionsBanReason", "FraktionsBanDate", "FraktionsBan", "userdata", "UID", playerUID[pname] ), -1 )
    if result and result[1] then
		if result[1]["FraktionsBan"] == 1 then
			local date = tonumber( result[1]["FraktionsBanDate"] )
			local reason = result[1]["FraktionsBanReason"]
            if date == 0 then
                date = "Permanent"
            end
            outputChatBox("Du hast eine Fraktionssperre. (Grund: "..reason.." , bis: "..getData(date)..")", player, 125, 0, 0)
            return true
		else
			return false
        end
    end
end






for i = 0, #fraktionNames+1 do
	fraktionMembers[i] = {}
	fraktionMemberList[i] = {}
	fraktionMemberListInvite[i] = {}
end

local frespawnTimer = {}
local zaehlerFrespawnTimer = {}

factionVehicles = {}
factionVehicles[1] = {}
factionVehicles[2] = {}
factionVehicles[3] = {}
factionVehicles[4] = {}
factionVehicles[5] = {}
factionVehicles[6] = {}
factionVehicles[7] = {}
factionVehicles[8] = {}
factionVehicles[9] = {}
factionVehicles[10] = {}
factionVehicles[11] = {}
factionVehicles[12] = {}
factionVehicles[13] = {}

factionSkins = {}
factionSkins[1] = { 280, 281, 282, 283, 284, 285, 288, 265, 266, 267 }
factionSkins[2] = { 111, 112, 113, 124, 125, 126, 127, 237, 272 }
factionSkins[3] = { 49, 117, 118, 120, 122, 123, 141, 169, 186, 294 }
factionSkins[4] = { 221, 222, 220, 143, 142, 307 }
factionSkins[5] = { 59, 141, 187, 188, 189, 296 }
factionSkins[6] = { 285, 286, 165, 164, 163, 295 }
factionSkins[7] = { 173, 174, 175, 115, 114, 116, 293, 292, 108, 109, 110 }
factionSkins[8] = { 287, 312, 191 }
factionSkins[9] = { 100, 247, 248, 298, 181, 299, 291 }
factionSkins[10] = { 274, 275, 276, 70 }
factionSkins[11] = { 305, 268, 201, 128, 50, 42 }
factionSkins[12] = { 102, 103, 104, 195, 13 }
factionSkins[13] = { 269, 270, 271, 301, 311, 105, 106, 107 }

aktionlaeuft = false
---------------------------------------------------------------------------------------------------------------

function isPDCar ( car )
	if factionVehicles[1][car] then return true else return false end
end

function isMafiaCar ( car )
	if factionVehicles[2][car] then return true else return false end
end

function isTriadenCar ( car )
	if factionVehicles[3][car] then return true else return false end
end

function isTerrorCar ( car )
	if factionVehicles[4][car] then return true else return false end
end

function isNewsCar ( car )
	if factionVehicles[5][car] then return true else return false end
end

function isFBICar ( car )
	if factionVehicles[6][car] then return true else return false end
end

function isAztecasCar ( car )
	if factionVehicles[7][car] then return true else return false end
end

function isArmyCar ( car )
	if factionVehicles[8][car] then return true else return false end
end

function isBikerCar ( car )
	if factionVehicles[9][car] then return true else return false end
end

function isMedicCar ( car )
	if factionVehicles[10][car] then return true else return false end
end

function isMechanikerCar ( car )
	if factionVehicles[11][car] then return true else return false end
end

function isBallasCar ( car )
	if factionVehicles[12][car] then return true else return false end
end

function isGroveCar ( car )
	if factionVehicles[13][car] then return true else return false end
end

function isFederalCar ( car )
	if isArmyCar( car ) or isFBICar( car ) or isPDCar ( car ) then
		return true
	else
		return false
	end
end

function isEvilCar ( car )
	if isMafiaCar( car ) or isTriadenCar( car ) or isTerrorCar ( car ) or isAztecasCar ( car ) or isBikerCar ( car ) or isBallasCar ( car ) or isGroveCar ( car ) then
		return true
	else
		return false
	end
end

function getPlayerFaction ( player )

	local fac = vioGetElementData ( player, "fraktion" )
	
	if fac then
	
		return tonumber(fac)
	
	else

		return false
	
	end

end

function getPlayerRank ( player )

	local ran = vioGetElementData ( player, "rang" )
	
	if ran then
	
		return tonumber(ran)
	
	else
	
		return false
	
	end

end

function getPlayerRankName ( player )

	local ran = getPlayerRank ( player )
	local fac = getPlayerFaction ( player )
	
	if ran then
	
		return factionRankNames[fac][ran]
	
	else
	
		return false
	
	end

end

-----------------------------------------------------------------------------------------------------

function isReporter(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 5 then return true else return false end
end

function isTerror(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 4 then return true else return false end
end

function isTriad(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 3 then return true else return false end
end

function isMafia(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 2 then return true else return false end
end

function isCop(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 1 then return true else return false end
end

function isFBI(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 6 then return true else return false end
end

function isAztecas(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 7 then return true else return false end
end

function isArmy(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 8 then return true else return false end
end

function isBiker(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 9 then return true else return false end
end

function isMedic(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 10 then return true else return false end
end

function isMechaniker(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 11 then return true else return false end
end

function isBallas(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 12 then return true else return false end
end

function isGrove(player)
	if tonumber(vioGetElementData ( player, "fraktion" )) == 13 then return true else return false end
end

------------------------------------------------------------------------------------------------------

function isStateFaction(player)
	if isArmy(player) or isCop(player) or isFBI(player) then return true else return false end
end

function isOnStateDuty(player)
	return isOnDuty(player)
end

function isOnDuty(player)

	local model = getElementModel(player) 
	
	if isCop (player) then
		for i=1, #factionSkins[1] do
			if factionSkins[1][i] == model then		
				return true		
			end	
		end
	
	
	elseif isFBI (player) then
		for i=1, #factionSkins[6] do
			if factionSkins[6][i] == model then	
				return true		
			end	
		end
	
	
	elseif isArmy (player) then
		for i=1, #factionSkins[8] do
			if factionSkins[8][i] == model then		
				return true		
			end	
		end
	end
	
	return false
	
end

function isEmergencyOnDuty(player)

	local model = getElementModel(player) 
	
	if isMedic (player) then
		for i=1, #factionSkins[10] do
			if factionSkins[10][i] == model then		
				return true		
			end	
		end
		
	elseif isMechaniker (player) then
		for i=1, #factionSkins[11] do
			if factionSkins[11][i] == model then		
				return true		
			end	
		end
	end
	
	return false
end


function isAbleOffduty ( player )

	local model = getElementModel(player) 
	
	for i=1, #factionSkins[1] do
		if factionSkins[1][i] == model then	
			return true
		end
	end
	
	for i=1, #factionSkins[6] do
		if factionSkins[6][i] == model then		
			return true		
		end	
	end
	
	for i=1, #factionSkins[8] do
		if factionSkins[8][i] == model then			
			return true		
		end	
	end	
	return false

end

function isEvil(player)
	if isMafia(player) or isTriad(player) or isTerror(player) or isAztecas(player) or isBiker(player) or isBallas(player) or isGrove(player) then return true else return false end
end

function isEmergency(player)
	if isMedic(player) or isMechaniker(player) then return true else return false end
end

function isInDepotFaction(player)
	return true
end

---------------------------------------------------------------------------------------------------


function sendMSGForFaction ( msg, faction, r, g, b )
	outputDebugString ( msg .. " | in sendMSGForFaction" )
	if not r then
		local r, g, b = 200, 200, 100
	end
	if faction > 13 and faction <= 0 then
		outputDebugString ( "sendMSGForFaction | "..msg )
	end
	for playeritem, key in pairs ( fraktionMembers[faction] ) do
		outputChatBox ( msg, playeritem, r, g, b )
	end
	
end

function getFactionMembersOnline ( faction )

	if faction then
		counter = 0
		for playeritem, index in pairs ( fraktionMembers[faction] ) do
			counter = counter + 1
		end
		return counter
	else
		return false
	end
	
end
function policeComputer ( presser, key, state )

	if state == "down" and isOnDuty(presser) and isFederalCar ( getPedOccupiedVehicle ( presser ) ) and getElementModel ( getPedOccupiedVehicle ( presser ) ) ~= 520 then
		triggerClientEvent ( presser,"showPDComputer", getRootElement() )
	end
	
end
function createTeleportMarker ( x1, y1, z1, int1, dim1, x2, y2, z2, int2, dim2, rot, needetFaction )

	if not needetFaction then
		needetFaction = 0
	end
	
	local marker1 = createMarker ( x1, y1, z1 + 0.5, "corona", 1, 0, 0, 0, 0 )
	local marker2 = createMarker ( x1, y1, z1, "cylinder", 1, 255, 0, 0, 150 )
	setElementDimension ( marker1, dim1 )
	setElementDimension ( marker2, dim1 )
	setElementInterior ( marker1, int1 )
	setElementInterior ( marker2, int1 )
	
	addEventHandler ( "onMarkerHit", marker1,
		function ( hit, dim )
			if dim then
				if getElementType ( hit ) == "player" then
					if not getPedOccupiedVehicle ( hit ) then
						if needetFaction == 0 or vioGetElementData ( hit, "fraktion" ) == needetFaction then
							fadeElementInterior ( hit, int2, x2, y2, z2, rot, dim2 )
						else
							infobox ( hit, "Du bist nicht\nbefugt!", 5000, 125, 0, 0 )
						end
					end
				end
			end
		end
	)
	
end

function createFactionVehicle ( model, x, y, z, rx, ry, rz, faction, c1, c2, c3, c4, numberplate )
	
end



function block_tie_cmds ( cmd )
	cancelEvent()
end

function tie_func ( player, cmd, target )
	if target then
		local target = findPlayerByName( target )	
		if target and target ~= player and getPedOccupiedVehicle ( target ) then	
			if isEvil(player) or isOnDuty(player) then		
				if getVehicleOccupant( getPedOccupiedVehicle ( player ) ) ~= target and getPedOccupiedVehicleSeat ( target ) > 0 then				
					local x1, y1, z1 = getElementPosition ( player )
					local x2, y2, z2 = getElementPosition ( target )
					
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
					
						local boolean = not vioGetElementData ( target, "tied" )
						vioSetElementData ( target, "tied", boolean )
						toggleAllControls ( target, boolean )
						if boolean then fix = "ent" else fix = "ge" end
						
						if fix == "ge" then
						
							addEventHandler( "onPlayerCommand", target, block_tie_cmds )
								
						elseif fix == "ent" then
						
							removeEventHandler ( "onPlayerCommand", target, block_tie_cmds )
						
						end
						
						if fix == "ent" then
						
							fadeCamera ( target, true, 0.5, 0, 0, 0 )
							
						elseif isEvil ( player ) then
						
							fadeCamera ( target, false, 0.5, 0, 0, 0 )
							
						end
						
						outputChatBox ( "Du hast "..getPlayerName(target).." "..fix.."fesselt!", player, 0, 125, 0 )
						outputChatBox ( "Du wurdest von "..getPlayerName(player).." "..fix.."fesselt!", target, 200, 200, 0 )
						
					else
					
						outputChatBox ( "Du bist zu weit weg!", player, 125, 0, 0 )
						
					end
					
				else
				
					outputChatBox ( "Ungueltiges Ziel!", player, 125, 0, 0 )
					
				end
				
			else
			
				outputChatBox ( "Du bist in einer ungueltigen Fraktion!", player, 125, 0, 0 )
				
			end
			
		else
		
			outputChatBox ( "Ungueltiges Ziel!", player, 125, 0, 0 )
			
		end
	else
		infobox ( player, "Gebrauch:\n/tie [Name]", 200, 0, 0 )
	end
	
end

addCommandHandler ( "tie", tie_func )

function fstate_func(player)
	local frac = vioGetElementData ( player, "fraktion" )
	
	if frac > 0 then
		if frac == 1 or frac == 6 or frac == 8 then
			outputChatBox ( factionDepotData["money"][1].."$", player, 200, 200, 0 )
			outputChatBox ( ""..fraktionRearms["WeaponSets"].." Waffen Sets | "..fraktionRearms["SWATSets"].." SWAT Sets", player, 200, 200, 0 )
		elseif frac == 5 then
			outputChatBox ( factionDepotData["money"][frac].."$", player, 200, 200, 0 )
		elseif frac == 10 or frac == 11 then
			outputChatBox ( factionDepotData["money"][10] .. "$ | " .. factionDepotData["drugs"][10] .. "g Drogen | " .. factionDepotData["mats"][10] .. " Materialien", player, 200, 200, 0 )
		else
			outputChatBox ( factionDepotData["money"][frac] .. "$ | " .. factionDepotData["drugs"][frac] .. "g Drogen | " .. factionDepotData["mats"][frac] .. " Materialien", player, 200, 200, 0 )
		end
	end
end
addCommandHandler ( "fstate", fstate_func )

function fskin_func ( player )
	
	local curskin = getElementModel ( player )
	local faction = getPlayerFaction ( player )
	local onduty = isOnDuty(player)
	local val = false
	
	if getPedOccupiedVehicle ( player ) then
	
		outputChatBox ( "Bitte nutze diesen Befehl nur ausserhalb von Fahrzeugen!", player, 125, 0, 0 )
			
	elseif faction == 6 and onduty and curskin ~= 285 then
		for i=1, #factionSkins[6] do
			if factionSkins[6][i] == curskin then
				val = i
				break		
			end
		end
		
		if val == false or val == #factionSkins[6] then
			setElementModel ( player, factionSkins[6][1] )
			return		
		else
			setElementModel ( player, factionSkins[6][val+1] )
			return
		end
	elseif faction == 8 then
		for i=1, #factionSkins[8] do
			if factionSkins[8][i] == curskin then
				val = i
				break		
			end
		end
		
		if val == false or val == #factionSkins[8] then
			setElementModel ( player, factionSkins[8][1] )
			return		
		else
			setElementModel ( player, factionSkins[8][val+1] )
			return
		end
		
	elseif faction == 1 and onduty and allowToChangeSkin and curskin ~= 285  then
		for i=1, #factionSkins[1] do
			if factionSkins[1][i] == curskin then
				val = i
				break		
			end
		end
		
		if val == false or val == #factionSkins[1] then
			setElementModel ( player, factionSkins[1][1] )
			return		
		else
			setElementModel ( player, factionSkins[1][val+1] )
			return
		end
		
	elseif faction and faction > 1 and faction ~= 10 and faction ~= 11 and faction ~= 6 and faction ~= 8 then
		for i, skin in pairs (factionSkins[faction]) do
			if skin == getElementModel(player) then
				val = i
				break	
			end
		
		end
		
		if val == false or val == #factionSkins[faction] then
		
			setElementModel ( player, factionSkins[faction][1] )
			vioSetElementData ( player, "skinid", factionSkins[faction][1] )
			return
				
		else
		
			setElementModel ( player, factionSkins[faction][val+1] )
			vioSetElementData ( player, "skinid", factionSkins[faction][val+1] )
			return
		
		end

	else
	
		outputChatBox ( "Du darfst diesen Befehl nicht benutzen!", player, 125, 0, 0 )
		
	end
end

addCommandHandler ( "fskin", fskin_func )


function invite_func ( player, cmd, target )

	local faction = getPlayerFaction ( player )
	local rank = getPlayerRank ( player )

	if faction ~= 0 and rank >= 4 then
	
		local target = findPlayerByName( target )
		
		if target ~= false then
		
			if getPlayerFaction( target ) == 0 then
			
				if not isInGang ( getPlayerName ( target ) ) then
				
					vioSetElementData ( target, "fraktion", faction )
					vioSetElementData ( target, "rang", 0 )
					vioSetElementData ( target, "FraktionenBetreten", vioGetElementData ( target, "FraktionenBetreten" ) + 1 )
					fraktionMembers[faction][target] = faction
					if faction == 10 or faction == 11 then
						fraktionMemberList[10][getPlayerName(target)] = 0
						fraktionMemberListInvite[10][getPlayerName(target)] = timestampOptical()
						for playeritem, _ in pairs ( fraktionMembers[10] ) do
							triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[10], fraktionMemberListInvite[10] )
						end
						for playeritem, _ in pairs ( fraktionMembers[11] ) do
							triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[10], fraktionMemberListInvite[10] )
						end
					else
						fraktionMemberList[faction][getPlayerName(target)] = 0
						fraktionMemberListInvite[faction][getPlayerName(target)] = timestampOptical()
						for playeritem, _ in pairs ( fraktionMembers[faction] ) do
							triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[faction], fraktionMemberListInvite[faction] )
						end
					end	
					triggerClientEvent ( target, "triggeredBlacklist", target, blacklistPlayers[faction] )					
					
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "LastFactionChange", timestampOptical(), "UID", playerUID[getPlayerName(target)] )
					outputChatBox ( "Du wurdest soeben in eine Fraktion aufgenommen! Tippe /t [Text] für den Chat und F1, um mehr zu erfahren!", target, 0, 125, 0 )
					outputChatBox ( "Du hast den Spieler "..getPlayerName(target).." in deine Fraktion aufgenommen!", player, 0, 125, 0 )
					outputLog ( "[INVITE] "..getPlayerName ( player ).."  hat "..getPlayerName(target).." in die Fraktion aufgenommen.", "fraktion"..faction )
					if faction == 1 or faction == 6 or faction == 8 then
						bindKey ( target, "y", "down", "chatbox", "t" )
					end
				else
				
					infobox ( player, "\n\n\nDer Spieler ist\nin einer Gang!", 5000, 125, 0, 0 )
					
				end
				
			else
			
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler ist\nbereits in\neiner Fraktion!", 5000, 125, 0, 0 )
				
			end
			
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
		
	end
	
end
addCommandHandler ( "invite", invite_func )


function uninvite_func ( player, cmd, target )

	local faction = getPlayerFaction ( player )
	local rank = getPlayerRank ( player )

	if faction > 0 and rank >= 4 then
	
		local target = findPlayerByName( target )
		
		if target ~= false then
		
			if (faction == getPlayerFaction( target ) or ( getPlayerFaction( target ) == 10 and faction == 11 ) or ( getPlayerFaction( target ) == 11 and faction == 10 ) ) and getPlayerRank ( target ) <= 4 then
			
				local model = malehomeless[math.random ( 1, 5 )]
				setElementModel ( target, model )
				vioSetElementData ( target, "skinid", model )
				if faction == 1 or faction == 6 or faction == 8 then
					unbindKey ( target, "y", "down", "chatbox" )
				end
				vioSetElementData ( target, "rang", 0 )
				vioSetElementData ( target, "FraktionenVerlassen", vioGetElementData ( target, "FraktionenVerlassen" ) + 1 )
				fraktionMembers[faction][target] = nil
				vioSetElementData ( target, "fraktion", 0 )
				if faction == 10 or faction == 11 then
					fraktionMemberList[10][getPlayerName(target)] = nil
					fraktionMemberListInvite[10][getPlayerName(target)] = nil
					for playeritem, _ in pairs ( fraktionMembers[10] ) do
						triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[10], fraktionMemberListInvite[10] )
					end
					for playeritem, _ in pairs ( fraktionMembers[11] ) do
						triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[10], fraktionMemberListInvite[10] )
					end
				else
					fraktionMemberList[faction][getPlayerName(target)] = nil
					fraktionMemberListInvite[faction][getPlayerName(target)] = nil
					for playeritem, _ in pairs ( fraktionMembers[faction] ) do
						triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[faction], fraktionMemberListInvite[faction] )
					end
				end		
				outputChatBox ( "Du wurdest soeben aus deiner Fraktion geworfen!", target, 0, 125, 0 )
				dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "LastFactionChange", timestampOptical(), "UID", playerUID[getPlayerName(target)] )
				outputChatBox ( "Du hast den Spieler "..getPlayerName(target).." aus deiner Fraktion entfernt!", player, 0, 125, 0 )
				outputLog ( "[UNINVITE] "..getPlayerName ( player ).."  hat "..getPlayerName(target).." aus der Fraktion entfernt.", "fraktion"..faction )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du kannst den\nSpieler nicht aus\nder Fraktion\nentfernen!", 5000, 125, 0, 0 )
			end
			
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
			
		end
		
	else
	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
		
	end
	
end
addCommandHandler ( "uninvite", uninvite_func )


function getchangestate_func ( player, cmd, target )
	if playerUID[target] then
		if vioGetElementData ( player, "adminlvl" ) >= 2 or vioGetElementData ( player, "rang" ) >= 4 then
			local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "LastFactionChange", "userdata", "UID", playerUID[target] ), -1 )
			outputChatBox ( "Letzter Fraktions-Uninvite: ".. result[1]["LastFactionChange"] , player, 200, 200, 0 )			
		else	
			outputChatBox ( "Du bist kein Admin/Leader/Coleader!", player, 125, 0, 0 )	
		end
	else
		outputChatBox ( "Der Spieler ist nicht online!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "getchangestate", getchangestate_func )

function giverank_func ( player, cmd, target, newrank )

	if newrank then 
		local newrank = math.abs ( math.floor ( tonumber ( newrank ) ) )
		local target = findPlayerByName( target )
		local faction = getPlayerFaction ( player )
		local rank = getPlayerRank ( player )
		
		if target then
		
			local targetfaction = getPlayerFaction ( target )
			local targetrank = getPlayerRank ( target )
		
			if faction >= 1 and rank >= 4 and (faction == targetfaction or (faction == 10 and targetfaction == 11) or (faction == 11 and targetfaction == 10)) and rank > newrank and targetrank ~= newrank then
				if targetrank < rank then
					if newrank < 5 and newrank >= 0 then
					
						if newrank > targetrank then
						
							outputChatBox ( "Glückwunsch, du wurdest soeben von "..getPlayerName ( player ).." zum "..factionRankNames[faction][newrank].." befördert!", target, 0, 125, 0 )
							
						else
						
							outputChatBox ( "Du wurdest soeben von "..getPlayerName ( player ).." zum "..factionRankNames[faction][newrank].." degradiert!", target, 125, 0, 0 )
							
						end
						
						vioSetElementData ( target, "rang", newrank )
						if faction == 10 or faction == 11 then
							fraktionMemberList[10][getPlayerName(target)] = newrank
							for playeritem, _ in pairs ( fraktionMembers[10] ) do
								triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[10], fraktionMemberListInvite[10] )
							end
							for playeritem, _ in pairs ( fraktionMembers[11] ) do
								triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[10], fraktionMemberListInvite[10] )
							end
						else
							fraktionMemberList[faction][getPlayerName(target)] = newrank
							for playeritem, _ in pairs ( fraktionMembers[faction] ) do
								triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[faction], fraktionMemberListInvite[faction] )
							end
						end
						outputChatBox ( "Du hast "..getPlayerName(target).." soeben Rang "..factionRankNames[faction][newrank].." ( "..newrank.." ) gegeben!", player, 0, 125, 0 )
						outputLog ( "[RANG] Der Rang von "..getPlayerName(target).." wurde von "..getPlayerName ( player ).." auf "..factionRankNames[faction][newrank].." ( "..newrank.." ) gesetzt.", "fraktion"..faction  )
					
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
				end
				
			else
			
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
				
			end
		
		else
		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
			
		end
	else
		
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Gebrauch:\n/giverank [Name] [Rang]", 5000, 125, 0, 0 )
			
	end
	
end
addCommandHandler ( "giverank", giverank_func )






function selbstUninvite ( player )
	local faction = getPlayerFaction ( player )
	local rank = getPlayerRank ( player )
	if faction > 0 and rank < 5 then
		local model = malehomeless[math.random ( 1, 5 )]
		setElementModel ( player, model )
		vioSetElementData ( player, "skinid", model )
		vioSetElementData ( player, "rang", 0 )
		fraktionMembers[faction][player] = nil
		fraktionMemberList[faction][getPlayerName(player)] = nil
		fraktionMemberListInvite[faction][getPlayerName(player)] = nil
		vioSetElementData ( player, "fraktion", 0 )
		vioSetElementData ( player, "FraktionenVerlassen", vioGetElementData ( player, "FraktionenVerlassen" ) + 1 )
		for playeritem, _ in pairs ( fraktionMembers[faction] ) do
			triggerClientEvent ( playeritem, "syncPlayerList", player, fraktionMemberList[faction], fraktionMemberListInvite[faction] )
		end
		outputChatBox ( "Du hast dich soeben aus der Fraktion uninvitet!", player, 0, 125, 0 )
		dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "LastFactionChange", timestampOptical (), "UID", playerUID[getPlayerName(player)] )
		for member, rank in pairs (fraktionMemberList[faction]) do
			if rank >= 4 then
				if getPlayerFromName ( member ) then
					outputChatBox ( "Der Spieler "..getPlayerName(player).." hat sich selbst uninvitet!", getPlayerFromName ( member ), 200, 200, 200 )
				else
					offlinemsg ( "Der Spieler "..getPlayerName(player).." hat sich selbst uninvitet!", "Fraktion", member )
				end
			end
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist\nals Leader nicht\nbefugt!", 5000, 125, 0, 0 )
	end
end
--addCommandHandler ("selfuninvite", selbstUninvite)


function frespawn ( player )
	local frac = getPlayerFaction ( player )
	local rank = getPlayerRank ( player )
	if frac then
		if frac > 0 then
			if rank >= 2 then
				if not isTimer ( frespawnTimer[frac] ) then
					zaehlerFrespawnTimer[frac] = 0
					sendMSGForFaction ("Countdown zum Fraktionsrespawn wurde von "..getPlayerName(player).. " gestartet. Benutze /stopfrespawn zum Stoppen!", frac, 0, 0, 155)
					frespawnTimer[frac] = setTimer (frespawnCountdown, 1000, 10, player)
					addCommandHandler ("stopfrespawn", stopFrespawnCountdown)
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nEs läuft schon\nein Frespawn\n-Countdown!", 5000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nErst ab\nRang 3!", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist in\nkeiner Fraktion!", 5000, 125, 0, 0 )
		end	
	else	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist in\nkeiner Fraktion!", 5000, 125, 0, 0 )
	end
end
addCommandHandler ( "frespawn", frespawn )


function frespawnCountdown ( player )
	local frac = getPlayerFaction ( player )
	zaehlerFrespawnTimer[frac] = zaehlerFrespawnTimer[frac] + 1
	if zaehlerFrespawnTimer[frac] == 10 then
		sendMSGForFaction ("Wird durchgeführt ..", frac, 0, 155, 0)
		startFrespawn ( player )
	elseif zaehlerFrespawnTimer[frac] == 5 then
		sendMSGForFaction ("Noch 5 Sekunden!", frac, 0, 155, 0)
	elseif zaehlerFrespawnTimer[frac] >= 7 then
		sendMSGForFaction (10-zaehlerFrespawnTimer[frac].." ..", frac, 0, 155, 0)
	end		
end

function startFrespawn ( player )
	frespawnTimer[getPlayerFaction ( player )] = nil
	local frak = vioGetElementData ( player, "fraktion" )
	for veh, _ in pairs ( factionVehicles[frak] ) do
		respawnVehicle ( veh )
		setElementFrozen ( veh, true )
	end
end


function stopFrespawnCountdown ( player )
	local frac = getPlayerFaction ( player )
	if frac then
		if frac > 0 then
			if frespawnTimer[frac] then
				if isTimer(frespawnTimer[frac]) then
					killTimer(frespawnTimer[frac])
					frespawnTimer[frac] = nil
					sendMSGForFaction ("Fraktions-Respawn abgebrochen durch "..getPlayerName(player), frac, 155, 0, 0)
				end
			end
		end
	end
end


function allowFSkinFunction ( player )
	if vioGetElementData ( player, "fraktion" ) == 1 and vioGetElementData ( player, "rang" ) >= 4 then
		if not allowToChangeSkin then
			allowToChangeSkin = true
			sendMSGForFaction ( "/fskin wurde für zwei Minuten aktiviert!", 1, 0, 200, 0 )
			allowToChangeSkinTimer = setTimer ( allowFSkinFunction, 2 * 60 * 1000, 1, player )
		else
			allowToChangeSkin = false
			sendMSGForFaction ( "/fskin wurde wieder deaktiviert!", 1, 200, 0, 0 )
			if isTimer ( allowToChangeSkinTimer ) then
				killTimer ( allowToChangeSkinTimer )
			end
		end
	end
end
addCommandHandler ( "allowfskin", allowFSkinFunction )
				
				
addCommandHandler ( "frakpm", function ( player, cmd, ... )
	local frac = vioGetElementData ( player, "fraktion" )
	local rang = vioGetElementData ( player, "rang" )
	local pname = getPlayerName ( player )
	if frac > 0 and rang >= 4 then
		local msg = table.concat ( {...}, " " )
		if msg and msg ~= "" then
			if frac == 10 or frac == 11 then
				for playeritem, _ in pairs ( fraktionMemberList[10] ) do
					if getPlayerFromName ( playeritem ) then
						outputChatBox ( pname..": "..msg, getPlayerFromName ( playeritem ), 200, 200, 0 )
					else
						offlinemsg ( msg, pname, playeritem )
					end
				end
			else
				for playeritem, _ in pairs ( fraktionMemberList[11] ) do
					if getPlayerFromName ( playeritem ) then
						outputChatBox ( pname..": "..msg, getPlayerFromName ( playeritem ), 200, 200, 0 )
					else
						offlinemsg ( msg, pname, playeritem )
					end
				end
				for playeritem, _ in pairs ( fraktionMemberList[frac] ) do
					if getPlayerFromName ( playeritem ) then
						outputChatBox ( pname..": "..msg, getPlayerFromName ( playeritem ), 200, 200, 0 )
					else
						offlinemsg ( msg, pname, playeritem )
					end
				end
			end
		end
	else
		infobox ( player, "Du bist\nnicht befugt!", 4000, 200, 0, 0 )
	end
end )


local SFPDVehicleRespawnCol = createColCuboid ( -1626.9000244141, 647.5, -6.5, -1618.6999511719+1626.9000244141, 655.40002441406-647.5, 7 )
local FBIVehicleRespawnCol = createColCuboid ( -2429.6999511719, 530.70001220703, 28, -2422.6999511719+2429.6999511719, 540.20001220703-530.70001220703, 5 )
local ARMYVehicleRespawnCol = createColCuboid ( 265.5, 1803.0999755859, 16, 272.39999389648-265.5, 1809.5999755859-1803.0999755859, 5 )

function respawnFrakVehicleInColShape ( hitElement, dim )
	if getElementType ( hitElement ) == "vehicle" and dim then
		if factionVehicles[1][hitElement] or factionVehicles[6][hitElement] or factionVehicles[8][hitElement] then
			for _, occupant in pairs ( getVehicleOccupants ( hitElement ) ) do
				removePedFromVehicle ( occupant )
			end
			respawnVehicle ( hitElement )
			setElementFrozen ( hitElement, true )
		end
	end
end 
addEventHandler ( "onColShapeHit", SFPDVehicleRespawnCol, respawnFrakVehicleInColShape )
addEventHandler ( "onColShapeHit", FBIVehicleRespawnCol, respawnFrakVehicleInColShape )
addEventHandler ( "onColShapeHit", ARMYVehicleRespawnCol, respawnFrakVehicleInColShape )



function FrakSpawn()
    if getElementData(source,"FrakCar") == true then
        cancelEvent()
        respawnVehicle(source)
        setElementDimension(source,0)
        setElementInterior(source,0)
    end
end




	